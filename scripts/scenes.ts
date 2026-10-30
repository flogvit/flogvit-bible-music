#!/usr/bin/env bun
/**
 * Pictures for the big screen. For a song in library/, a local LLM (Ollama) splits the song into its parts and
 * describes one photograph for each, from what those lines say; Z-Image Turbo (mflux, in .venv-images) makes
 * them; a vision model looks at each one and has it made again with another seed when it shows writing,
 * something modern or a broken body. The result is library/<id>/scenes.json with scenes/*.webp (README,
 * scenes.json), which publish.ts puts on the host next to the song.
 *
 * Usage: bun scripts/scenes.ts <library/<id>> [...]   the songs given, if they have no scenes.json yet
 *        bun scripts/scenes.ts --all                  every song in library/ without one
 * Environment: MUSIC_SCENES_MODEL (default qwen3.8:27b), MUSIC_LOOK_MODEL (default qwen3-vl:8b), OLLAMA_HOST.
 *
 * Pictures are not made while YuE generates on this Mac (both want the GPU and much memory): it waits.
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

/** The same look for every picture, so the songs belong together; the lower third stays calm for the words. */
const LOOK = '35mm film photograph, Kodak Portra 400, natural light, muted earth tones, subtle grain, quiet, ' +
  'simple uncluttered composition, wide 16:9, the lower third of the frame is calm with little detail';

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
- Say what is in the picture, where, and the light and time of day. Not the camera or film; that is added.
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
type Look = { writing: boolean; modern: boolean; broken: boolean; posing: boolean; note: string };

type Plan = { model: string; scenes: { line: number; description: string }[] };

function log(text: string) {
  console.log(`${new Date().toTimeString().slice(0, 8)} ${text}`);
}

async function ask<T>(model: string, think: boolean, system: string, user: string, format: object, images?: string[]): Promise<T> {
  const r = await fetch(`${OLLAMA}/api/chat`, {
    timeout: false, // queued behind another Ollama request, an answer can take longer than Bun's 5 minutes
    method: 'POST',
    body: JSON.stringify({
      model, stream: false, think, format,
      keep_alive: 0, // give the memory back to the image model and YuE
      options: { temperature: 0, seed: 1, num_ctx: 8192 },
      messages: [{ role: 'system', content: system }, { role: 'user', content: user, ...(images ? { images } : {}) }],
    }),
  });
  if (!r.ok) throw new Error(`${model}: ${r.status} ${await r.text()}`);
  return JSON.parse((await r.json() as { message: { content: string } }).message.content) as T;
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
  const answer = await ask<{ scenes: { line: number; description: string }[] }>(SCENES_MODEL, true, PLAN_RULES,
    `Song: ${about}\n\n${numberedLyrics(info, sung)}`, PLAN_SCHEMA);
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
  const plan = { model: SCENES_MODEL, scenes };
  mkdirSync(path.dirname(file), { recursive: true });
  writeFileSync(file, JSON.stringify(plan, null, 1) + '\n');
  return plan;
}

const yueRunning = () => Bun.spawnSync(['pgrep', '-f', 'yue2 batch']).exitCode === 0;

async function waitForGpu() {
  if (!yueRunning()) return;
  log('PICTURES WAIT: YuE is generating on this Mac');
  while (yueRunning()) await Bun.sleep(60_000);
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
    const convert = Bun.spawnSync([PYTHON, '-c', `
import sys
from PIL import Image
im = Image.open(sys.argv[1]).convert('RGB')
top = (im.height - 1080) // 2
im = im.crop((0, top, 1920, top + 1080))
im.save(sys.argv[2], quality=85, method=6)
im.resize((960, 540)).save(sys.argv[3], quality=85)
`, png, out, small]);
    rmSync(png, { force: true });
    if (convert.exitCode !== 0) throw new Error(`convert: ${convert.stderr.toString()}`);
    const look = await ask<Look>(LOOK_MODEL, false, LOOK_RULES, `The picture was meant to show: ${description}`, LOOK_SCHEMA,
      [Buffer.from(readFileSync(small)).toString('base64')]);
    rmSync(small, { force: true });
    if (!look.writing && !look.modern && !look.broken && !look.posing) return true;
    const what = (['writing', 'modern', 'broken', 'posing'] as const).filter((k) => look[k]).join(', ');
    log(`PICTURE AGAIN ${path.basename(out)} seed ${seed + attempt}: ${what} (${look.note})`);
  }
  rmSync(out, { force: true });
  return false;
}

/** Makes scenes.json and its pictures for a library song that has none. Returns the number of pictures. */
export async function makeScenes(folder: string): Promise<number> {
  const id = path.basename(folder);
  if (existsSync(path.join(folder, 'scenes.json'))) return 0;
  if (!existsSync(path.join(folder, 'alignment.json'))) throw new Error(`${id} has no alignment.json`);
  const sung: string[] = JSON.parse(readFileSync(path.join(folder, 'alignment.json'), 'utf8')).lines.map((l: { text: string }) => l.text);
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

/** The library songs (finished: with alignment.json) that have no pictures yet. */
export function withoutScenes(library = path.join(MAIN, 'library')): string[] {
  if (!existsSync(library)) return [];
  return readdirSync(library, { withFileTypes: true }).filter((d) => d.isDirectory()).map((d) => path.join(library, d.name))
    .filter((f) => existsSync(path.join(f, 'alignment.json')) && !existsSync(path.join(f, 'scenes.json'))).sort();
}

/**
 * Pictures for every song that lacks them, one song at a time, starting no song after `until` (ms since 1970);
 * a song that fails is logged and skipped.
 */
const failedHere = new Set<string>();
export async function makeAllScenes(folders = withoutScenes(), until = Infinity) {
  for (const folder of folders.filter((f) => !failedHere.has(f))) {
    if (Date.now() > until) return;
    try {
      await makeScenes(folder);
    } catch (e) {
      failedHere.add(folder); // tried again when the run starts again, not between every song
      log(`PICTURES FAILED ${path.basename(folder)}: ${e}`);
    }
  }
}

if (import.meta.main) {
  const args = process.argv.slice(2);
  if (!args.length) {
    console.error('Usage: bun scripts/scenes.ts <library/<id>> [...] | --all');
    process.exit(1);
  }
  const notReady = await scenesReady();
  if (notReady) {
    console.error(`cannot make pictures: ${notReady}`);
    process.exit(1);
  }
  await makeAllScenes(args.includes('--all') ? withoutScenes() : args.map((a) => path.resolve(a)));
}
