#!/usr/bin/env bun
/**
 * Pictures for the big screen. For a song in library/, a local LLM (Ollama) splits the song into its parts and
 * describes one photograph for each, from what those lines say; Z-Image Turbo (mflux, in .venv-images) makes
 * them; a vision model looks at each one and has it made again with another seed when it shows writing,
 * something modern or a broken body. The result is library/<id>/scenes.json with scenes/*.webp (README,
 * scenes.json), which publish.ts puts on the host next to the song.
 *
 * Usage: bun scripts/scenes.ts --watch                every song in library/ without pictures, newest first, and
 *                                                    then each new one as it comes (scripts/install-pictures.sh)
 *        bun scripts/scenes.ts <library/<id>> [...]   the songs given
 * Environment: MUSIC_SCENES_MODEL (default qwen3.8:27b), MUSIC_LOOK_MODEL (default qwen3-vl:8b), OLLAMA_HOST.
 *
 * A song made again with other lyrics, or with pictures in an earlier look, gets new pictures. On a Mac with less than 96 GB, pictures and YuE take
 * turns: a song's pictures wait while YuE generates, and generate.ts starts no song while a song's pictures are
 * being made (HOLD_GPU). On a larger Mac they run side by side.
 */
import { existsSync, mkdirSync, openSync, readdirSync, readFileSync, rmSync, writeFileSync } from 'fs';
import path from 'path';
import { letters, type Scene } from '../lib/music';

export const SCENES_MODEL = process.env.MUSIC_SCENES_MODEL ?? 'qwen3.8:27b';
const LOOK_MODEL = process.env.MUSIC_LOOK_MODEL ?? 'qwen3-vl:8b';
const OLLAMA = process.env.OLLAMA_HOST ?? 'http://localhost:11434';
const REPO = path.join(import.meta.dir, '..');
const MAIN = path.dirname(Bun.spawnSync(['git', 'rev-parse', '--path-format=absolute', '--git-common-dir'], { cwd: REPO }).stdout.toString().trim());
const PYTHON = path.join(MAIN, '.venv-images', 'bin', 'python');
const MFLUX = path.join(MAIN, '.venv-images', 'bin', 'mflux-generate-z-image-turbo');
const ATTEMPTS = 3;

/**
 * The same look for every picture, so the songs belong together. The words lie over the bottom third, so the
 * subject stands above it, on a low horizon, and the bottom third is empty foreground.
 */
const LOOK = '35mm film photograph, Kodak Portra 400, natural light, muted earth tones, subtle grain, quiet, ' +
  'simple uncluttered composition, wide 16:9. The main subject stands in the upper middle of the frame with a little ' +
  'space above it, seen from slightly below; a low line of sky at most; the bottom third of the frame is plain empty ' +
  'foreground with nothing in it (bare ground, a stone floor, still water), softly out of focus';

const PLAN_RULES = `You choose the pictures shown behind the lyrics of a song on a big screen in a church or a
meeting, while people sing along. The song is about a Bible passage, story, person or theme. The words are shown
low on the screen, over the lower third of the picture.

Split the song into its parts (verses, chorus, bridge, outro) and give each part one picture, from the line where
that part begins. Usually 3 to 7 pictures. A part whose words change image halfway may get a second picture from
that line, but every picture stays up for at least two lines: when two images come close, choose the stronger.
The first picture starts at line 0.

Each picture is one quiet photograph, described in 20 to 40 words of plain English:
- Take the concrete image the lines give (a tree by water, a lamp, a shepherd with sheep, a stormy sea). When the
  lines are abstract (praise, grace, sin), choose a place, a light or an object whose mood fits them.
- Keep it simple and clean: one subject, few elements, much calm space. No collage, no symbolism piled up.
- The world of the Bible: the land, the light, the plants, animals, houses and things of ancient Israel and the
  Near East. Nothing modern.
- People and animals may be in a picture when the words call for them, but not in most: few of them, seen at a
  distance, from behind, at the edge or in part (hands, a figure on a path), going about their life, never posing
  or looking at the camera, never a face close up. Say what they wear: simple robes, tunics and head cloths of
  the time (the image model dresses people in today's clothes otherwise). Never God as a person; Jesus only from
  behind or far away, with no halo.
- No writing, letters or signs. No crosses or church symbols unless the line is about the cross.
- Say what is in the picture, where, and the light and time of day. Not the camera, the film or the framing;
  that is added (the subject stands high in the frame, and the bottom of the picture stays empty for the words).
- A chorus that comes back gets the exact same description as the first time, so it shows the same picture.
- Two pictures in a row should differ in place or light.

The lines are numbered; give the number of the line where each picture begins.`;

const PLAN_SCHEMA = {
  type: 'object',
  properties: {
    scenes: {
      type: 'array',
      items: {
        type: 'object',
        properties: { line: { type: 'integer' }, description: { type: 'string' } },
        required: ['line', 'description'],
      },
    },
  },
  required: ['scenes'],
};

const LOOK_RULES = `You check a photograph before it is shown behind song lyrics on a big screen. Answer about what
you see, strictly:
- writing: any letters, words, numbers, signs, logos or watermarks;
- modern: anything from after ancient times (roads with markings, wires, cars, modern buildings or clothes);
- broken: a body, face, hand or animal that is deformed, has extra or missing limbs or fingers, or melts into
  something else; or an object that makes no physical sense;
- posing: a person looking into the camera, or a face close up.`;

const LOOK_SCHEMA = {
  type: 'object',
  properties: {
    writing: { type: 'boolean' }, modern: { type: 'boolean' }, broken: { type: 'boolean' }, posing: { type: 'boolean' },
    note: { type: 'string' },
  },
  required: ['writing', 'modern', 'broken', 'posing', 'note'],
};
const FAULTS = ['writing', 'modern', 'broken', 'posing'] as const;
/**
 * A picture whose text band (62–91 % of the height, where the words lie) has more than this times the detail of
 * the part above it has its subject under the words and empty sky or wall above. Pictures looked at by eye: subject
 * in the band 3.7–7.7, subject above it 0.4–0.9.
 */
const LOW = 2;
type Look = Record<(typeof FAULTS)[number], boolean> & { note: string };

/**
 * `lines` are the sung lines the plan was made for, and `look` the look its pictures were made with: a song made
 * again with other lyrics, or pictures made with another look, get a new plan and new pictures.
 */
type Plan = { model: string; lines?: string[]; look?: string; scenes: { line: number; description: string }[] };

function log(text: string) {
  console.log(`${new Date().toTimeString().slice(0, 8)} ${text}`);
}

/** Asks a model for JSON. `think` unset leaves thinking to the model (the vision check: see below). */
async function ask<T>(model: string, think: boolean | undefined, system: string, user: string, format: object, images?: string[]): Promise<T> {
  const r = await fetch(`${OLLAMA}/api/chat`, {
    timeout: false, // queued behind another Ollama request, an answer can take longer than Bun's 5 minutes
    method: 'POST',
    body: JSON.stringify({
      model, stream: false, think, format,
      keep_alive: 0, // give the memory back to the image model and YuE
      options: { temperature: 0, seed: 1, num_ctx: 16384 }, // a long psalm's thinking does not fit in 8192
      messages: [{ role: 'system', content: system }, { role: 'user', content: user, ...(images ? { images } : {}) }],
    }),
  });
  if (!r.ok) throw new Error(`${model}: ${r.status} ${await r.text()}`);
  // Ollama 0.32 puts the answer under `thinking` when thinking is off; an empty answer throws, and the caller decides.
  const { message } = await r.json() as { message: { content: string; thinking?: string } };
  try {
    return JSON.parse(message.content) as T;
  } catch (e) {
    if (message.thinking?.trim().startsWith('{')) return JSON.parse(message.thinking) as T;
    throw e;
  }
}

/** Can pictures be made here? Pulls the Ollama models once; undefined when ready, else what is missing. */
export async function scenesReady(): Promise<string | undefined> {
  if (!existsSync(MFLUX)) return `no ${MFLUX} (README, Pictures for the big screen)`;
  try {
    const have = (await (await fetch(`${OLLAMA}/api/tags`)).json() as { models: { name: string }[] }).models.map((m) => m.name);
    for (const model of [SCENES_MODEL, LOOK_MODEL]) {
      if (have.includes(model)) continue;
      const r = await fetch(`${OLLAMA}/api/pull`, { method: 'POST', body: JSON.stringify({ model, stream: false }) });
      if (!r.ok) return `cannot pull ${model}: ${await r.text()}`;
    }
  } catch (e) {
    return `Ollama does not answer at ${OLLAMA} (${e})`;
  }
}

/** The song's lyrics with its parts, each sung line numbered as in alignment.json. */
function numberedLyrics(info: any, sung: string[]): string {
  let next = 0;
  const out: string[] = [];
  for (const section of info.lyrics?.sections ?? []) {
    out.push(`[${section.section}]`);
    for (const line of section.lines as string[]) {
      if (next < sung.length && letters(sung[next]!) === letters(line)) out.push(`${next++}: ${line}`);
      else out.push(`   ${line}`);
    }
  }
  return out.join('\n');
}

/** The parts of the song and a picture description for each, kept in scenes/plan.json once made. */
export async function planOf(folder: string, sung: string[]): Promise<Plan> {
  const file = path.join(folder, 'scenes', 'plan.json');
  if (existsSync(file)) return JSON.parse(readFileSync(file, 'utf8'));
  const info = JSON.parse(readFileSync(path.join(folder, 'info.json'), 'utf8'));
  const about = [info.title, info.anchor?.label, info.kind && `(a ${info.kind} song)`].filter(Boolean).join(', ');
  const question = `Song: ${about}\n\n${numberedLyrics(info, sung)}`;
  type Answer = { scenes: { line: number; description: string }[] };
  // Thinking gives better pictures; when it runs out of room and leaves no answer, ask once without it.
  const answer = await ask<Answer>(SCENES_MODEL, true, PLAN_RULES, question, PLAN_SCHEMA)
    .catch(() => ask<Answer>(SCENES_MODEL, false, PLAN_RULES, question, PLAN_SCHEMA));
  // One picture per starting line, in order, inside the song, the first from line 0.
  const byLine = new Map<number, string>();
  for (const s of answer.scenes) {
    if (Number.isInteger(s.line) && s.line >= 0 && s.line < sung.length && s.description.trim() && !byLine.has(s.line)) {
      byLine.set(s.line, s.description.trim());
    }
  }
  // Every picture stays up for at least two lines; one that comes sooner gives way to the one before.
  const scenes: Plan['scenes'] = [];
  for (const [line, description] of [...byLine].sort(([a], [b]) => a - b)) {
    if (!scenes.length || line - scenes.at(-1)!.line >= 2) scenes.push({ line, description });
  }
  if (!scenes.length) throw new Error(`${SCENES_MODEL} gave no pictures`);
  scenes[0]!.line = 0;
  const plan = { model: SCENES_MODEL, lines: sung, look: LOOK, scenes };
  mkdirSync(path.dirname(file), { recursive: true });
  writeFileSync(file, JSON.stringify(plan, null, 1) + '\n');
  return plan;
}

/**
 * YuE (12 GB), the picture model (26 GB) and the judge (17 GB) at once come too close to 64 GB, so a smaller Mac
 * takes turns; one with 96 GB or more runs pictures beside YuE.
 */
const TAKE_TURNS = Number(Bun.spawnSync(['sysctl', '-n', 'hw.memsize']).stdout.toString()) < 96 * 2 ** 30;
/** While a song's pictures are made (its own scenes.ts process, from --watch), generate.ts starts no song. */
export const HOLD_GPU = TAKE_TURNS ? 'bun scripts/scenes\\.ts /.*/library/' : undefined;

const yueRunning = () => Bun.spawnSync(['pgrep', '-f', 'yue2 batch']).exitCode === 0;

async function waitForGpu() {
  if (!TAKE_TURNS || !yueRunning()) return;
  log('PICTURES WAIT: YuE is generating on this Mac');
  while (yueRunning()) await Bun.sleep(5_000);
}

/**
 * One picture: made with mflux at 1920×1088, cut to 1920×1080 as WebP, and looked at. Up to ATTEMPTS seeds;
 * false when none passed.
 */
async function render(description: string, out: string, seed: number, logFile: string): Promise<boolean> {
  const png = out.replace(/\.webp$/, '.png');
  const small = out.replace(/\.webp$/, '.look.jpg');
  for (let attempt = 0; attempt < ATTEMPTS; attempt++) {
    await waitForGpu();
    const fd = openSync(logFile, 'a');
    const made = Bun.spawn(['taskpolicy', '-b', MFLUX, '--prompt', `${LOOK}. ${description}`, '--width', '1920', '--height', '1088',
      '--steps', '9', '-q', '8', '--seed', String(seed + attempt), '--output', png], { stdout: fd, stderr: fd });
    if (await made.exited !== 0) throw new Error(`mflux failed (see ${logFile})`);
    // Cut to 1080 rows, save, and measure the detail in the text band against the part above it (structure, not
    // grain: on a small, blurred copy).
    const convert = Bun.spawnSync([PYTHON, '-c', `
import sys
import numpy as np
from PIL import Image, ImageFilter
im = Image.open(sys.argv[1]).convert('RGB')
top = (im.height - 1080) // 2
im = im.crop((0, top, 1920, top + 1080))
im.save(sys.argv[2], quality=85, method=6)
im.resize((960, 540)).save(sys.argv[3], quality=85)
a = np.asarray(im.convert('L').resize((320, 180), Image.LANCZOS).filter(ImageFilter.GaussianBlur(1.2)), dtype=np.float32) / 255
g = np.abs(np.diff(a, axis=0))[:, :-1] + np.abs(np.diff(a, axis=1))[:-1]
h = g.shape[0]
print(g[int(0.62 * h):int(0.91 * h)].mean() / max(g[int(0.10 * h):int(0.58 * h)].mean(), 1e-4))
`, png, out, small]);
    rmSync(png, { force: true });
    if (convert.exitCode !== 0) throw new Error(`convert: ${convert.stderr.toString()}`);
    const low = Number(convert.stdout.toString().trim());
    if (low > LOW) {
      rmSync(small, { force: true });
      log(`PICTURE AGAIN ${path.basename(out)} seed ${seed + attempt}: the subject is under the words (${low.toFixed(1)})`);
      continue;
    }
    // The vision model is left to think (Ollama 0.32 with thinking off answers in prose); when it still gives no
    // answer, it is asked once without thinking, and a picture no answer is had for does not pass.
    const image = [Buffer.from(readFileSync(small)).toString('base64')];
    const question = `The picture was meant to show: ${description}`;
    const look = await ask<Look>(LOOK_MODEL, undefined, LOOK_RULES, question, LOOK_SCHEMA, image)
      .catch(() => ask<Look>(LOOK_MODEL, false, LOOK_RULES, question, LOOK_SCHEMA, image))
      .catch(() => null);
    rmSync(small, { force: true });
    if (look && !FAULTS.some((k) => look[k])) return true;
    const what = look ? FAULTS.filter((k) => look[k]).join(', ') : 'no answer from the check';
    log(`PICTURE AGAIN ${path.basename(out)} seed ${seed + attempt}: ${what}${look ? ` (${look.note})` : ''}`);
  }
  rmSync(out, { force: true });
  return false;
}

const sungLines = (folder: string): string[] =>
  JSON.parse(readFileSync(path.join(folder, 'alignment.json'), 'utf8')).lines.map((l: { text: string }) => l.text);

/** Why a song's pictures must be made again: other lyrics than the song has now, or another look; else null. */
function outdated(folder: string): string | null {
  const file = path.join(folder, 'scenes', 'plan.json');
  if (!existsSync(file)) return null;
  const { lines, look } = JSON.parse(readFileSync(file, 'utf8')) as Plan;
  if (lines && JSON.stringify(lines) !== JSON.stringify(sungLines(folder))) return 'the song was made again with other lyrics';
  if (look !== LOOK && existsSync(path.join(folder, 'scenes.json'))) return 'they were made with an earlier look';
  return null;
}

/** Makes scenes.json and its pictures for a library song that has none, or has them for other lyrics. */
export async function makeScenes(folder: string): Promise<number> {
  const id = path.basename(folder);
  if (!existsSync(path.join(folder, 'alignment.json'))) throw new Error(`${id} has no alignment.json`);
  const why = outdated(folder);
  if (why) {
    log(`PICTURES AGAIN ${id}: ${why}`);
    rmSync(path.join(folder, 'scenes.json'), { force: true });
    rmSync(path.join(folder, 'scenes'), { recursive: true, force: true });
  }
  if (existsSync(path.join(folder, 'scenes.json'))) return 0;
  const sung = sungLines(folder);
  const plan = await planOf(folder, sung);
  mkdirSync(path.join(folder, 'scenes'), { recursive: true });
  const logFile = path.join(folder, 'scenes', 'mflux.log');
  // A chorus that comes back has the same description, and gets the same picture.
  const unique = [...new Set(plan.scenes.map((s) => s.description))];
  const ok = new Map<string, string>();
  for (const [k, description] of unique.entries()) {
    const image = `scenes/${k + 1}.webp`;
    if (existsSync(path.join(folder, image)) || await render(description, path.join(folder, image), (k + 1) * 100, logFile)) {
      ok.set(description, image);
    }
  }
  // A picture that never passed is left out: the one before it stays up longer.
  const scenes: Scene[] = plan.scenes.filter((s) => ok.has(s.description))
    .map((s) => ({ line: s.line, image: ok.get(s.description)!, alt: s.description }));
  if (!scenes.length) throw new Error(`no picture for ${id} passed the look`);
  scenes[0]!.line = 0;
  // Written last: publish-auto.sh sees a new scenes.json, and every image it names is there.
  writeFileSync(path.join(folder, 'scenes.json'), JSON.stringify(scenes, null, 2) + '\n');
  log(`PICTURES DONE ${id}: ${scenes.length} scenes, ${ok.size} pictures`);
  return scenes.length;
}

/** The library songs (finished: with alignment.json) that need pictures, the newest first. */
export function songsWithoutPictures(library = path.join(MAIN, 'library')): string[] {
  if (!existsSync(library)) return [];
  const made = (f: string) => {
    try {
      return Date.parse(JSON.parse(readFileSync(path.join(f, 'info.json'), 'utf8')).generated?.date) || 0;
    } catch {
      return 0;
    }
  };
  return readdirSync(library, { withFileTypes: true }).filter((d) => d.isDirectory()).map((d) => path.join(library, d.name))
    .filter((f) => existsSync(path.join(f, 'alignment.json')) && (!existsSync(path.join(f, 'scenes.json')) || outdated(f)))
    .sort((a, b) => made(b) - made(a));
}

/** This checkout moved to the newest origin/main; true when the picture code changed, so the process restarts. */
function update(): boolean {
  const code = () => Bun.spawnSync(['git', 'rev-parse', 'HEAD:scripts/scenes.ts', 'HEAD:lib/music.ts'], { cwd: REPO }).stdout.toString();
  const before = code();
  const fetched = Bun.spawnSync(['git', 'fetch', '-q', 'origin', 'main'], { cwd: REPO }).exitCode === 0;
  const clean = !Bun.spawnSync(['git', 'status', '--porcelain', '--untracked-files=no'], { cwd: REPO }).stdout.toString().trim();
  if (fetched && clean) Bun.spawnSync(['git', 'checkout', '-q', '--detach', 'origin/main'], { cwd: REPO });
  return code() !== before;
}

/**
 * Pictures for every library song that needs them, newest first, and then for each new one as it comes. Each
 * song is made by a scenes.ts process of its own, which generate.ts waits for on a Mac that takes turns. A song
 * that fails is logged and tried again when this starts again (launchd starts it again after new code too).
 */
async function watch() {
  const failed = new Set<string>();
  log(`PICTURES START${TAKE_TURNS ? ', taking turns with YuE' : ', beside YuE'}`);
  for (;;) {
    if (update()) {
      log('PICTURES RESTART: new picture code on origin/main');
      process.exit(0);
    }
    const next = songsWithoutPictures().find((f) => !failed.has(f));
    if (!next) {
      await Bun.sleep(5 * 60_000);
      continue;
    }
    await waitForGpu();
    const song = Bun.spawn([process.execPath, 'scripts/scenes.ts', next], { cwd: REPO, stdout: 'inherit', stderr: 'inherit' });
    if (await song.exited !== 0) {
      failed.add(next);
      log(`PICTURES FAILED ${path.basename(next)}; tried again when this starts again`);
    }
  }
}

if (import.meta.main) {
  const args = process.argv.slice(2);
  if (!args.length) {
    console.error('Usage: bun scripts/scenes.ts --watch | <library/<id>> [...]');
    process.exit(1);
  }
  const notReady = await scenesReady();
  if (notReady) {
    console.error(`cannot make pictures: ${notReady}`);
    process.exit(1);
  }
  if (args[0] === '--watch') await watch();
  let failed = 0;
  for (const folder of args.map((a) => path.resolve(a))) {
    try {
      await makeScenes(folder);
    } catch (e) {
      failed++;
      log(`PICTURES FAILED ${path.basename(folder)}: ${e}`);
    }
  }
  process.exit(failed ? 1 : 0);
}
