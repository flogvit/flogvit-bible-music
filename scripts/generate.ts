#!/usr/bin/env bun
/**
 * Generate catalog songs on several machines at once without making any song twice.
 *
 * Every song has a lock on GitHub: the ref refs/claims/<id>, a chain of empty commits. Each commit's subject is
 * the song's state (`claimed`, `alive`, `done`, `failed`, `released`, `rejected`, `aside`, `retry`, `remake`) and its
 * body names the machine; its committer date is the last sign of life. Taking a song pushes a commit to that ref without force, so GitHub
 * accepts it only if the ref is still where this machine saw it (missing, or at the stale or released commit it
 * builds on): of two machines that ask at the same time, one push is rejected. While a song generates, the
 * machine adds an `alive` commit every minute; a lock with no sign of life for 20 minutes is free again.
 *
 * Usage:
 *   bun scripts/generate.ts run [--from-end]   finish local songs, then take the next free song, generate it,
 *                                              make its sheets and library folder, mark it done, and repeat;
 *                                              with few songs free, write the next portion of the catalog
 *                                              (scripts/catalog-write.ts); with none free, remake this machine's
 *                                              songs whose catalog request (style, lyrics, cot, abc) changed, and
 *                                              make pictures (scripts/scenes.ts) for library songs without them
 *   bun scripts/generate.ts status            every song in catalog/order.txt with its state
 *   bun scripts/generate.ts claim <id>         take one song by hand (prints `claimed` or who has it)
 *   bun scripts/generate.ts retry <id>         put a song that was set aside back in the queue
 *   bun scripts/generate.ts rejudge <id>       judge a set-aside song's kept takes again, keep the first that passes
 *   bun scripts/generate.ts remake <id>        make one song again the same way, also one that is done or set
 *                                              aside (after its request changed); a done song whose new take
 *                                              does not pass, or is not as good, keeps its old take
 *
 * Before a song gets its sheets, scripts/lyrics-check.ts judges whether the singing delivers its lyrics. A song
 * sung as written is kept; one sung differently but as good lyrics is kept with the lyrics as sung
 * (lyrics-sung.txt in its folder, used by its sheets and library). Only a broken song is made again with the next
 * seed; after MUSIC_MAX_ATTEMPTS (default 3) it is set aside in aside/<id>.json and the run goes on.
 */
import { existsSync, mkdirSync, openSync, readdirSync, readFileSync, renameSync, rmSync, statSync, writeFileSync } from 'fs';
import { hostname } from 'os';
import path from 'path';
import { writeNext } from './catalog-write';
import { judge, JUDGE_MODEL, judgeReady, outcome, type Verdict } from './lyrics-check';
import { makeAllScenes, scenesReady } from './scenes';

const REPO = path.join(import.meta.dir, '..');
// YuE/, .venv-sheets and library/ live in the main checkout, also when this runs from a worktree.
const MAIN = path.dirname(git('rev-parse', '--path-format=absolute', '--git-common-dir').trim());
const YUE = path.join(MAIN, 'YuE');
const OUTPUTS = path.join(YUE, 'outputs', 'catalog');
const NS = 'refs/claims';
const EMPTY_TREE = '4b825dc642cb6eb9a060e54bf8d69288fbee4904';
const HEARTBEAT_MS = 60_000;
const STALE_SECONDS = 20 * 60;
// Songs generated before this ran on torch 2.10 and are not done (see README).
const TORCH_FIX = new Date('2026-10-28T16:20:00+01:00');
const MACHINE = process.env.MUSIC_MACHINE ?? hostname();
// A song whose lyrics check fails this many times in a row is set aside in aside/ instead of made again.
const MAX_ATTEMPTS = Number(process.env.MUSIC_MAX_ATTEMPTS ?? 3);
const ASIDE = path.join(REPO, 'aside');
// The lyrics as sung, in a song folder, when the lyrics check adopted them.
const SUNG_LYRICS = 'lyrics-sung.txt';

// rejected: the lyrics check failed and the song is free to make again; aside: it failed MAX_ATTEMPTS times;
// retry: put back by hand after being set aside; remake: taken by `remake`, held like `claimed`.
type State = 'claimed' | 'alive' | 'done' | 'failed' | 'released' | 'rejected' | 'aside' | 'retry' | 'remake';
type Outcome = 'done' | 'failed' | 'rejected' | 'aside';
type Claim = { id: string; sha: string; state: State; machine: string; time: number };

function git(...args: string[]): string {
  const r = Bun.spawnSync(['git', ...args], { cwd: REPO });
  if (r.exitCode !== 0) throw new Error(`git ${args.join(' ')}: ${r.stderr.toString().trim()}`);
  return r.stdout.toString();
}

function log(text: string) {
  console.log(`${new Date().toTimeString().slice(0, 8)} ${text}`);
}

function readClaims(): Map<string, Claim> {
  git('fetch', '-q', '--prune', 'origin', `+${NS}/*:${NS}/*`);
  const claims = new Map<string, Claim>();
  const out = git('for-each-ref', '--format=%(refname:lstrip=2)%00%(objectname)%00%(committerdate:unix)%00%(subject)%00%(body)%01', NS);
  for (const rec of out.split('\x01')) {
    const [id, sha, time, subject, body] = rec.replace(/^\n/, '').split('\0');
    if (!id) continue;
    const machine = /^machine: (.*)$/m.exec(body ?? '')?.[1] ?? '?';
    claims.set(id, { id, sha, state: stateOf(subject), machine, time: Number(time) });
  }
  return claims;
}

// A song set aside is recorded as `done <id> (set aside)`: generate.ts versions from before the lyrics check read
// only the first word and know no other state that is never free, so they must not take it either.
const ASIDE_SUBJECT = '(set aside)';
const stateOf = (subject: string): State => subject.endsWith(ASIDE_SUBJECT) ? 'aside' : subject.split(' ')[0] as State;
const subjectOf = (id: string, state: State) => state === 'aside' ? `done ${id} ${ASIDE_SUBJECT}` : `${state} ${id}`;

function isFree(c: Claim | undefined): boolean {
  if (!c || ['failed', 'released', 'rejected', 'retry'].includes(c.state)) return true;
  if (c.state === 'done' || c.state === 'aside') return false;
  return Date.now() / 1000 - c.time > STALE_SECONDS;
}

/** Push a new state for a song on top of `parent` (or as a new lock). Rejected means another machine moved the ref. */
function push(id: string, parent: string | undefined, state: State): { result: 'ok' | 'rejected' | 'error'; sha?: string; detail?: string } {
  const sha = git('commit-tree', EMPTY_TREE, ...(parent ? ['-p', parent] : []), '-m', subjectOf(id, state), '-m', `machine: ${MACHINE}`).trim();
  const r = Bun.spawnSync(['git', 'push', '--porcelain', 'origin', `${sha}:${NS}/${id}`], { cwd: REPO });
  const out = r.stdout.toString() + r.stderr.toString();
  const line = out.split('\n').find((l) => l.includes(`:${NS}/${id}`)) ?? '';
  if (r.exitCode === 0 && /^[ *+=]\t/.test(line)) {
    git('update-ref', `${NS}/${id}`, sha);
    return { result: 'ok', sha };
  }
  return { result: line.startsWith('!') ? 'rejected' : 'error', detail: out.trim() };
}

function order(): string[] {
  const catalog = readdirSync(path.join(REPO, 'catalog')).filter((f) => f.endsWith('.json')).map((f) => f.slice(0, -5));
  const listed = readFileSync(path.join(REPO, 'catalog', 'order.txt'), 'utf8').split('\n').map((l) => l.trim())
    .filter((l) => l && !l.startsWith('#') && catalog.includes(l));
  return [...listed, ...catalog.filter((id) => !listed.includes(id)).sort()];
}

function isComplete(id: string): boolean {
  const result = path.join(OUTPUTS, id, 'result.json');
  return existsSync(result) && statSync(result).mtime >= TORCH_FIX
    && JSON.parse(readFileSync(result, 'utf8')).status === 'complete';
}

function run(cmd: string[], cwd: string, logFile: string, env: Record<string, string> = {}) {
  const fd = openSync(logFile, 'a');
  return Bun.spawn(cmd, { cwd, stdout: fd, stderr: fd, env: { ...process.env, ...env } });
}

// On a Mac with only two efficiency cores (M1 Max), Whisper under `taskpolicy -b` shares them with YuE and slows
// both down, so it runs at the lowest priority on the other cores instead (README, Sheet music).
const efficiencyCores = Number(Bun.spawnSync(['sysctl', '-n', 'hw.perflevel1.physicalcpu']).stdout.toString()) || 0;
const sheetsPriority = efficiencyCores < 4 ? ['nice', '-n', '20'] : ['taskpolicy', '-b'];

/**
 * For a song whose audio is done: Whisper listens, the lyrics check judges what it heard (or `given`, a verdict
 * already made), and a song that is kept, with its lyrics as written or as sung, gets its sheets, library folder
 * and sheets commit. A broken song is rejected or set aside. With `accept` (remake), a take that passes but that
 * `accept` finds worse than the one it replaces gets no library folder or commit: 'worse'.
 */
async function finish(id: string, fresh: boolean, given?: Verdict): Promise<Outcome>;
async function finish(id: string, fresh: boolean, given: Verdict | undefined, accept: (v: Verdict) => boolean): Promise<Outcome | 'worse'>;
async function finish(id: string, fresh: boolean, given?: Verdict, accept?: (v: Verdict) => boolean): Promise<Outcome | 'worse'> {
  const songDir = path.join(OUTPUTS, id);
  const sheets = path.join(REPO, 'sheets', id);
  const logFile = path.join(OUTPUTS, `${id}-run.log`);
  const py = path.join(MAIN, '.venv-sheets', 'bin', 'python');
  if (fresh) for (const f of ['whisper.json', 'alignment.json']) rmSync(path.join(sheets, f), { force: true });
  if (await run([...sheetsPriority, py, 'scripts/song-sheets.py', '--listen-only', songDir], REPO, logFile).exited !== 0) {
    log(`WHISPER FAILED ${id} (see ${logFile})`);
    return 'failed';
  }
  const lyrics = JSON.parse(readFileSync(path.join(songDir, 'request.json'), 'utf8')).lyrics;
  const verdict = given ?? await judge(lyrics, JSON.parse(readFileSync(path.join(sheets, 'whisper.json'), 'utf8')));
  writeFileSync(path.join(songDir, 'lyrics-check.json'), JSON.stringify({ model: JUDGE_MODEL, ...verdict }, null, 1));
  const result = outcome(verdict);
  if (result === 'reject') return reject(id, verdict);
  const sung = path.join(songDir, SUNG_LYRICS);
  if (result === 'adopt') {
    // The song is kept, and its sheets and library show the lyrics as sung (song-sheets.py and build-library.py
    // read lyrics-sung.txt before request.json); request.json keeps what was asked for.
    writeFileSync(sung, verdict.sung_lyrics!.trim() + '\n');
    log(`LYRICS ADOPTED ${id}: ${verdict.summary}`);
  } else {
    rmSync(sung, { force: true });
    log(`LYRICS OK ${id}`);
  }
  if (fresh || result === 'adopt' || !existsSync(path.join(sheets, `${id}-lead-sheet.pdf`))) {
    if (await run([...sheetsPriority, py, 'scripts/song-sheets.py', songDir], REPO, logFile).exited !== 0) {
      log(`SHEETS FAILED ${id} (see ${logFile})`);
      return 'failed';
    }
  }
  if (accept && !accept(verdict)) return 'worse';
  const env = { MUSIC_MACHINE: MACHINE, FREE_BIBLE: process.env.FREE_BIBLE ?? path.join(path.dirname(MAIN), 'free-bible') };
  if (await run(['python3', 'scripts/build-library.py', songDir], REPO, logFile, env).exited !== 0) {
    log(`LIBRARY FAILED ${id} (see ${logFile})`);
    return 'failed';
  }
  commitAndPush(path.join('sheets', id), `${id} generated on ${MACHINE}, with chord and lead sheets`);
  return 'done';
}

// Sheets go to this branch, and the machine runs its code: main, from a detached worktree (README, Generate).
const BRANCH = process.env.MUSIC_SHEETS_BRANCH || git('branch', '--show-current').trim() || 'main';
// The code this run loaded; when the branch brings another version, the run stops and launchd starts the new one.
const codeVersion = () => git('rev-parse', 'HEAD:scripts');
const LOADED = codeVersion();

/** Brings in what other machines and sessions pushed to the branch, with this checkout's own commits on top. */
function pull(): boolean {
  const r = Bun.spawnSync(['git', 'pull', '-q', '--rebase', '--autostash', 'origin', BRANCH], { cwd: REPO });
  if (r.exitCode === 0) return true;
  Bun.spawnSync(['git', 'rebase', '--abort'], { cwd: REPO });
  log(`PULL FAILED from ${BRANCH}: ${r.stderr.toString().trim()}`);
  return false;
}

/**
 * The branch brought another version of the code this run loaded (pulled with a song's sheets): stop between
 * songs, once `pending` sheets are done, and launchd starts the new version.
 */
async function stopForNewCode(pending: Promise<void>) {
  if (codeVersion() === LOADED) return;
  await pending;
  log(`RUN RESTART: ${BRANCH} has new code in scripts/; launchd starts it again within a minute`);
  process.exit(0);
}

/**
 * How good a kept take is, for `remake`: its lyrics check (a take from before the check counts as correct) and
 * the share of its lines Whisper found on their notes (sheets/<id>/alignment.json).
 */
function takeQuality(verdict: Verdict | undefined, alignment: string) {
  const rank = !verdict || outcome(verdict) === 'ok' ? 2 : outcome(verdict) === 'adopt' ? 1 : 0;
  let lines: { uncertain?: boolean }[] = [];
  try {
    lines = JSON.parse(alignment).lines ?? [];
  } catch {}
  const onNotes = lines.filter((l) => !l.uncertain).length;
  const share = lines.length ? onNotes / lines.length : 0;
  return { rank, share, text: `${['wrong', 'adopt', 'correct'][rank]}, ${onNotes} of ${lines.length} lines on their notes` };
}

function commitAndPush(paths: string, subject: string) {
  git('add', '-A', paths);
  if (!git('diff', '--cached', '--name-only').trim()) return;
  git('commit', '-q', '-m', subject);
  // Another machine may push in between: pull and push again.
  let detail = '';
  for (let attempt = 0; attempt < 3; attempt++) {
    if (!pull()) break;
    const r = Bun.spawnSync(['git', 'push', '-q', 'origin', `HEAD:${BRANCH}`], { cwd: REPO });
    if (r.exitCode === 0) return;
    detail = r.stderr.toString().trim();
  }
  log(`PUSH FAILED ${subject} to ${BRANCH}: ${detail}`);
}

/** Rejections in the song's lock: all of them (each attempt gets its own seed), and since it was last put back or remade. */
function rejections(id: string): { total: number; sinceRetry: number } {
  if (!git('for-each-ref', `${NS}/${id}`).trim()) return { total: 0, sinceRetry: 0 };
  const subjects = git('log', '--format=%s', `${NS}/${id}`).split('\n');
  const retry = subjects.findIndex((s) => s.startsWith('retry ') || s.startsWith('remake '));
  const count = (list: string[]) => list.filter((s) => s.startsWith('rejected ')).length;
  return { total: count(subjects), sinceRetry: count(retry < 0 ? subjects : subjects.slice(0, retry)) };
}

/**
 * The lyrics did not pass. The audio moves to YuE/outputs/catalog/<id>-rejected-<n>/ (with whisper.json and
 * lyrics-check.json, to listen to later), so the song is made again; after MAX_ATTEMPTS it goes in aside/.
 */
function reject(id: string, verdict: Verdict): 'rejected' | 'aside' {
  const { total, sinceRetry } = rejections(id);
  // The take that set a song aside is not a `rejected` commit, so after a retry or remake the next number can
  // already be taken: never reuse a kept take's folder.
  const prefix = `${id}-rejected-`;
  const numbers = readdirSync(OUTPUTS).map((d) => d.startsWith(prefix) ? Number(d.slice(prefix.length)) || 0 : 0);
  const kept = path.join(OUTPUTS, `${id}-rejected-${Math.max(total, ...numbers) + 1}`);
  renameSync(path.join(OUTPUTS, id), kept);
  const sheets = path.join(REPO, 'sheets', id);
  if (existsSync(path.join(sheets, 'whisper.json'))) renameSync(path.join(sheets, 'whisper.json'), path.join(kept, 'whisper.json'));
  if (existsSync(sheets) && !readdirSync(sheets).length) rmSync(sheets, { recursive: true });
  const attempt = sinceRetry + 1;
  log(`LYRICS REJECTED ${id} (attempt ${attempt} of ${MAX_ATTEMPTS}): ${verdict.summary}`);
  if (attempt < MAX_ATTEMPTS) return 'rejected';
  const attempts = readdirSync(OUTPUTS).filter((d) => d.startsWith(`${id}-rejected-`)).sort().map((d) => ({
    folder: path.join(OUTPUTS, d),
    seed: JSON.parse(readFileSync(path.join(OUTPUTS, d, 'request.json'), 'utf8')).seed,
    check: existsSync(path.join(OUTPUTS, d, 'lyrics-check.json')) ? JSON.parse(readFileSync(path.join(OUTPUTS, d, 'lyrics-check.json'), 'utf8')) : null,
  }));
  mkdirSync(ASIDE, { recursive: true });
  writeFileSync(path.join(ASIDE, `${id}.json`), JSON.stringify({ id, machine: MACHINE, date: new Date().toISOString(), attempts }, null, 1) + '\n');
  commitAndPush(path.join('aside', `${id}.json`), `${id} set aside: lyrics wrong in ${attempt} attempts on ${MACHINE}`);
  return 'aside';
}

function record(id: string, tip: string | undefined, state: State) {
  const r = push(id, tip, state);
  log(r.result === 'ok' ? `${state.toUpperCase()} ${id}` : `${state.toUpperCase()} NOT RECORDED ${id}: ${r.detail}`);
}

/** How a finished song ended. Without network it keeps trying, so a rejection is always counted on GitHub. */
async function recordSurely(id: string, tip: string | undefined, state: Outcome) {
  for (let tries = 1; ; tries++) {
    const r = push(id, tip, state);
    if (r.result === 'ok') return log(`${state.toUpperCase()} ${id}`);
    if (r.result === 'rejected' || tries === 60) return log(`${state.toUpperCase()} NOT RECORDED ${id}: ${r.detail}`);
    if (tries === 1) log(`${state.toUpperCase()} NOT RECORDED YET ${id} (no network?), trying every minute`);
    await Bun.sleep(HEARTBEAT_MS);
  }
}

/** A song this machine holds: an `alive` commit every minute until it is done, failed or given back. */
class Lock {
  lost = false;
  private beat: ReturnType<typeof setInterval>;

  constructor(readonly id: string, private tip: string, onLost: () => void) {
    held.add(this);
    this.beat = setInterval(() => {
      const r = push(id, this.tip, 'alive');
      if (r.result === 'ok') this.tip = r.sha!;
      else if (r.result === 'rejected') {
        this.lost = true;
        log(`LOST ${id}: another machine took it, stopping`);
        this.end();
        onLost();
      } else log(`HEARTBEAT FAILED ${id} (no network?), retrying`);
    }, HEARTBEAT_MS);
  }

  end(state?: State) {
    clearInterval(this.beat);
    held.delete(this);
    if (state && !this.lost) record(this.id, this.tip, state);
  }

  async settle(outcome: Outcome) {
    clearInterval(this.beat);
    held.delete(this);
    if (!this.lost) await recordSurely(this.id, this.tip, outcome);
  }
}

const held = new Set<Lock>();
const children = new Set<ReturnType<typeof Bun.spawn>>();

/**
 * Generate one claimed song; its lock comes back while the song still needs its sheets. A failed generation is
 * recorded as `failState`.
 */
async function generate(id: string, tip: string, failState: State = 'failed'): Promise<Lock | undefined> {
  const batch = path.join(YUE, 'requests', `${id}.jsonl`);
  if (Bun.spawnSync(['bun', 'scripts/build-batch.ts', batch, id], { cwd: REPO }).exitCode !== 0) throw new Error(`build-batch ${id}`);
  // The same seed makes the same song, so each attempt after a rejected one gets the next seed.
  const { total } = rejections(id);
  if (total) {
    const request = JSON.parse(readFileSync(batch, 'utf8'));
    request.seed += total;
    writeFileSync(batch, JSON.stringify(request) + '\n');
    log(`ATTEMPT ${total + 1} ${id} with seed ${request.seed}`);
  }
  mkdirSync(OUTPUTS, { recursive: true });
  const logFile = path.join(OUTPUTS, `${id}-run.log`);
  // YuE runs in the background by default; MUSIC_NICE=<n> gives it normal priority at that niceness instead,
  // for a machine where generation should come before other work.
  const yuePriority = process.env.MUSIC_NICE ? ['nice', '-n', process.env.MUSIC_NICE] : ['taskpolicy', '-b'];
  const child = run([...yuePriority, '.venv/bin/yue2', 'batch', '--input', batch, '--output', OUTPUTS,
    '--config', path.join(REPO, 'configs', 'long-12000.json'), '--resume'], YUE, logFile);
  children.add(child);
  // On power, the Mac stays awake while the song generates; asleep, its lock would go stale after 20 minutes.
  Bun.spawn(['caffeinate', '-s', '-w', String(child.pid)]);
  const lock = new Lock(id, tip, () => child.kill());
  const code = await child.exited;
  children.delete(child);
  if (lock.lost) return;
  if (code !== 0 || !isComplete(id)) {
    log(`GENERATION FAILED ${id} (exit ${code}, see ${logFile})`);
    lock.end(failState);
    return;
  }
  const seconds = Math.round(JSON.parse(readFileSync(path.join(OUTPUTS, id, 'result.json'), 'utf8')).audio_seconds);
  log(`SONG DONE ${id} ${Math.floor(seconds / 60)}:${String(seconds % 60).padStart(2, '0')}`);
  return lock;
}

// When fewer songs than this are free, the catalog gets its next portion from free-bible (scripts/catalog-write.ts).
const LOW_WATER = 4;
const PORTION = Number(process.env.MUSIC_CATALOG_PORTION ?? 10);
// Held by the machine writing a portion, so two machines never write the same songs.
const CATALOG_LOCK = '_catalog';

/** Few songs left: one machine writes the next portion of the catalog and pushes it, and every machine pulls it. */
async function refillCatalog(pending: Promise<void>) {
  const claims = readClaims();
  const free = order().filter((id) => isFree(claims.get(id)) && !isComplete(id)).length;
  const c = claims.get(CATALOG_LOCK);
  if (free >= LOW_WATER || !isFree(c)) return;
  const r = push(CATALOG_LOCK, c?.sha, 'claimed');
  if (r.result !== 'ok') return;
  const lock = new Lock(CATALOG_LOCK, r.sha!, () => {});
  try {
    // The last song's sheets commit first, so two commits never share the checkout.
    await pending;
    pull();
    log(`CATALOG ${free} songs free, writing ${PORTION} more`);
    const written = await writeNext(PORTION);
    if (written.length) commitAndPush('catalog', `Catalog: ${written.length} songs from free-bible, written on ${MACHINE}`);
    log(`CATALOG ${written.length} songs written`);
  } catch (e) {
    log(`CATALOG FAILED: ${e}`);
  } finally {
    lock.end('released');
  }
}

// The owner's own GPU jobs go first: no song starts while one runs (MUSIC_YIELD_TO, a pgrep -f pattern). Nor while
// another YuE generation runs on this Mac (a remake started by hand): this run's own has ended when it asks.
const YIELD_TO = process.env.MUSIC_YIELD_TO ?? 'mlx_video|mlx-video|mflux';

async function yieldGpu() {
  let waited = false;
  for (const pattern of [YIELD_TO, 'yue2 batch']) {
    while (Bun.spawnSync(['pgrep', '-f', pattern]).exitCode === 0) {
      if (!waited) log(`WAITING: another GPU job runs (${pattern})`);
      waited = true;
      await Bun.sleep(HEARTBEAT_MS);
    }
  }
}

/** Songs this machine already made (also before the claims existed) are checked, finished and marked. */
async function finishLocal() {
  const claims = readClaims();
  for (const id of order()) {
    const c = claims.get(id);
    if (!isComplete(id) || c?.state === 'done' || (c && c.machine !== MACHINE && !isFree(c))) continue;
    try {
      const outcome = await finish(id, false);
      if (outcome !== 'failed') await recordSurely(id, c?.sha, outcome);
    } catch (e) {
      log(`FINISH FAILED ${id}: ${e}`);
    }
  }
}

/**
 * Pictures for the big screen (scripts/scenes.ts) for the songs in library/ that have none. Songs come first:
 * pictures are made when the run has no song left to take (MUSIC_PICTURES_PER_SONG, default 0, makes them for
 * that many library songs after each song instead), so pictures never hold the next song back. They are extra: a Mac that cannot make them says why once, and a
 * picture that fails is logged, skipped and tried again in the next run.
 */
const PICTURES_PER_SONG = Number(process.env.MUSIC_PICTURES_PER_SONG ?? 0);
let noPictures = false;
async function pictures(songs = Infinity) {
  if (songs <= 0) return;
  try {
    const notReady = await scenesReady();
    if (notReady) {
      if (!noPictures) log(`NO PICTURES: ${notReady}`);
      noPictures = true;
      return;
    }
    await makeAllScenes(undefined, Infinity, songs);
  } catch (e) {
    log(`PICTURES FAILED: ${e}; the run goes on with the next song`);
  }
}

function claimNext(fromEnd: boolean, skip: Set<string>): { id: string; tip: string } | undefined {
  const claims = readClaims();
  const ids = order();
  if (fromEnd) ids.reverse();
  for (const id of ids) {
    const c = claims.get(id);
    if (skip.has(id) || !isFree(c) || isComplete(id)) continue;
    const r = push(id, c?.sha, 'claimed');
    if (r.result === 'ok') return { id, tip: r.sha! };
    if (r.result === 'error') throw new Error(`cannot reach GitHub: ${r.detail}`);
  }
}

/** Without network, wait for it instead of stopping: the last song's sheets may still be in the making. */
async function claimNextWhenOnline(fromEnd: boolean, skip: Set<string>) {
  for (;;) {
    try {
      return claimNext(fromEnd, skip);
    } catch (e) {
      log(`OFFLINE (${String(e).split('\n')[0]}), trying again in a minute`);
      await Bun.sleep(HEARTBEAT_MS);
    }
  }
}

// While a remake runs, stopping puts the song's old take back and leaves it done (set by remake()).
let undoRemake: (() => void) | undefined;

function release() {
  for (const child of children) child.kill();
  undoRemake?.();
  for (const lock of held) lock.end('released');
  process.exit(1);
}

/**
 * Makes a song again the same way as `run`, also one that is done or set aside (after its request changed in the
 * catalog). Its current take is kept beside it; a done song whose new take does not pass, or is not as good, gets
 * that take back and stays done, so what is published never goes away and no other machine makes it again from
 * its own, older catalog. 'taken': another machine holds it.
 */
async function remake(id: string): Promise<'done' | 'kept' | 'failed' | 'taken'> {
  const c = readClaims().get(id);
  if (c && !isFree(c) && c.state !== 'done' && c.state !== 'aside') {
    log(`REMAKE ${id}: ${c.state} by ${c.machine}`);
    return 'taken';
  }
  const r = push(id, c?.sha, 'remake');
  if (r.result !== 'ok') {
    log(`REMAKE ${id}: ${r.result}: ${r.detail}`);
    return 'taken';
  }
  log(`REMAKE ${id} on ${MACHINE}`);
  const request = catalogRequest(id);
  const song = path.join(OUTPUTS, id);
  const previous = c?.state === 'done' && isComplete(id) ? `${song}-replaced` : undefined;
  if (previous) {
    rmSync(previous, { recursive: true, force: true });
    renameSync(song, previous);
  }
  // Put the old take back; a new take still in the song folder moves to <id>-remake-failed.
  const restore = () => {
    if (!previous) return;
    if (existsSync(song)) {
      rmSync(`${song}-remake-failed`, { recursive: true, force: true });
      // Its Whisper pass and alignment go with it, to listen to and compare later.
      for (const f of ['whisper.json', 'alignment.json']) {
        const made = path.join(REPO, 'sheets', id, f);
        if (existsSync(made)) writeFileSync(path.join(song, f), readFileSync(made));
      }
      renameSync(song, `${song}-remake-failed`);
    }
    renameSync(previous, song);
    Bun.spawnSync(['git', 'checkout', 'HEAD', '--', path.join('sheets', id)], { cwd: REPO });
    log(`REMAKE ${id}: the old take is kept (the new one is in ${song}-remake-failed)`);
  };
  undoRemake = () => {
    restore();
    for (const lock of held) lock.end(previous ? 'done' : 'released');
  };
  try {
    const lock = await generate(id, r.sha!, previous ? 'done' : 'failed');
    if (!lock) {
      restore();
      recordRemake(id, request, 'failed');
      return 'failed';
    }
    // The new take replaces the old only when it is at least as good: as good a lyrics check (correct before
    // adopt), and as large a share of its lines on their notes.
    const old = previous && takeQuality(
      existsSync(path.join(previous, 'lyrics-check.json')) ? JSON.parse(readFileSync(path.join(previous, 'lyrics-check.json'), 'utf8')) : undefined,
      Bun.spawnSync(['git', 'show', `HEAD:sheets/${id}/alignment.json`], { cwd: REPO }).stdout.toString(),
    );
    const accept = (v: Verdict) => {
      const now = takeQuality(v, readFileSync(path.join(REPO, 'sheets', id, 'alignment.json'), 'utf8'));
      const better = !old || (now.rank >= old.rank && now.share >= old.share);
      log(`REMAKE ${id}: new take ${now.text}, old take ${old ? old.text : 'none'}: ${better ? 'the new one is kept' : 'the old one is kept'}`);
      return better;
    };
    let result: Outcome | 'worse' = 'failed';
    try {
      result = previous ? await finish(id, true, undefined, accept) : await finish(id, true);
    } catch (e) {
      log(`FINISH FAILED ${id}: ${e}`);
    }
    if (result !== 'done') restore();
    // A done song stays done whatever the new take did ('worse' only comes with a previous take).
    await lock.settle(previous ? 'done' : result as Outcome);
    log(`REMAKE ${id}: ${result}`);
    const ended = result === 'done' ? 'done' : result === 'worse' ? 'kept' : 'failed';
    recordRemake(id, request, ended);
    return ended;
  } finally {
    undoRemake = undefined;
  }
}

// What a take was made from; when the catalog asks for something else, `run` makes this machine's take again.
const REQUESTED = ['style', 'lyrics', 'cot', 'abc'] as const;
const requestKey = (r: Record<string, unknown>) => JSON.stringify(REQUESTED.map((k) => r[k] ?? null));
const catalogRequest = (id: string) => requestKey(JSON.parse(readFileSync(path.join(REPO, 'catalog', `${id}.json`), 'utf8')).request);
// Each song's last remake on this machine: the request it was made for, how many tries, and how it ended.
const REMAKES = path.join(OUTPUTS, 'remakes.json');
type Remade = { request: string; tries: number; result: 'done' | 'kept' | 'failed' };
const remakes = (): Record<string, Remade> => existsSync(REMAKES) ? JSON.parse(readFileSync(REMAKES, 'utf8')) : {};

function recordRemake(id: string, request: string, result: Remade['result']) {
  const all = remakes();
  const tries = all[id]?.request === request ? all[id].tries + 1 : 1;
  writeFileSync(REMAKES, JSON.stringify({ ...all, [id]: { request, tries, result } }, null, 1));
}

/**
 * The next song this machine made whose catalog request changed since. A request is tried until a take passes:
 * a new take kept, or one that passed but was not as good ('kept', made with the same seed it would get again),
 * and at most MAX_ATTEMPTS times when its takes fail.
 */
function changedRequest(skip: Set<string>): string | undefined {
  const done = remakes();
  for (const id of order()) {
    if (skip.has(id) || !isComplete(id)) continue;
    const want = catalogRequest(id);
    if (want === requestKey(JSON.parse(readFileSync(path.join(OUTPUTS, id, 'request.json'), 'utf8')))) continue;
    const last = done[id];
    if (last?.request === want && (last.result !== 'failed' || last.tries >= MAX_ATTEMPTS)) continue;
    return id;
  }
}

const [command, ...args] = process.argv.slice(2);
if (command === 'run') {
  process.on('SIGINT', release);
  process.on('SIGTERM', release);
  const fromEnd = args.includes('--from-end');
  log(`RUN START on ${MACHINE}${fromEnd ? ', from the end of catalog/order.txt' : ''}`);
  const notReady = await judgeReady();
  if (notReady) {
    log(`RUN STOP: the lyrics check cannot run: ${notReady}`);
    process.exit(1);
  }
  pull();
  await stopForNewCode(Promise.resolve());
  await finishLocal();
  // Songs this run does not take again: generation failed here, or set aside. A rejected song is counted here too,
  // so the limit holds in this run even if GitHub missed a rejection.
  const failed = new Set<string>();
  const rejectedHere = new Map<string, number>();
  // A song's sheets are made while the next song generates (Whisper on the CPU, YuE on the GPU), one at a time.
  let sheets = Promise.resolve();
  // Pictures come after a song YuE made in this run, never before the first one.
  let picturesDue = false;
  for (;;) {
    await stopForNewCode(sheets);
    if (picturesDue) {
      picturesDue = false;
      await yieldGpu();
      await pictures(PICTURES_PER_SONG);
      await stopForNewCode(sheets);
    }
    await yieldGpu();
    // New catalog songs first; this machine's songs whose catalog request changed only when none is free.
    await refillCatalog(sheets);
    const next = await claimNextWhenOnline(fromEnd, failed);
    if (!next) {
      const changed = changedRequest(failed);
      if (!changed) break;
      await sheets;
      await remake(changed);
      failed.add(changed);
      picturesDue = true;
      continue;
    }
    log(`CLAIMED ${next.id}`);
    const lock = await generate(next.id, next.tip);
    picturesDue = true;
    if (!lock) {
      failed.add(next.id);
      continue;
    }
    sheets = sheets.then(async () => {
      let outcome: Outcome = 'failed';
      try {
        outcome = await finish(lock.id, true);
      } catch (e) {
        log(`FINISH FAILED ${lock.id}: ${e}`);
      }
      await lock.settle(outcome);
      pull();
      const count = (rejectedHere.get(lock.id) ?? 0) + (outcome === 'rejected' ? 1 : 0);
      rejectedHere.set(lock.id, count);
      if (outcome === 'aside' || count >= MAX_ATTEMPTS) failed.add(lock.id);
    });
  }
  await sheets;
  await pictures();
  log('RUN END: no free songs left');
  // launchd starts run again a minute after it stops (so new code starts at once); with nothing to do, wait
  // here so an idle Mac looks for songs every ten minutes.
  await Bun.sleep(9 * 60_000);
} else if (command === 'status') {
  const claims = readClaims();
  const now = Date.now() / 1000;
  const counts: Record<string, number> = {};
  for (const id of order()) {
    const c = claims.get(id);
    const state = !c ? 'free' : c.state === 'done' || c.state === 'aside' ? c.state : isFree(c) ? (c.state === 'claimed' || c.state === 'alive' ? 'stale' : c.state) : 'generating';
    counts[state] = (counts[state] ?? 0) + 1;
    const age = c ? `${Math.round((now - c.time) / 60)} min ago` : '';
    console.log([id.padEnd(50), state.padEnd(10), c?.machine ?? '', age].join('  ').trimEnd());
  }
  console.log(Object.entries(counts).map(([k, v]) => `${v} ${k}`).join(', '));
} else if (command === 'claim' && args[0]) {
  const id = args[0];
  const c = readClaims().get(id);
  if (!isFree(c)) console.log(`${c!.state} ${id} by ${c!.machine}`);
  else {
    const r = push(id, c?.sha, 'claimed');
    console.log(r.result === 'ok' ? `claimed ${id}` : `${r.result} ${id}: ${r.detail}`);
  }
} else if (command === 'retry' && args[0]) {
  const id = args[0];
  const c = readClaims().get(id);
  if (c?.state !== 'aside') console.log(`${id} is not set aside (${c?.state ?? 'free'})`);
  else {
    const r = push(id, c.sha, 'retry');
    if (r.result !== 'ok') console.log(`${r.result} ${id}: ${r.detail}`);
    else {
      if (existsSync(path.join(ASIDE, `${id}.json`))) {
        rmSync(path.join(ASIDE, `${id}.json`));
        commitAndPush(path.join('aside', `${id}.json`), `${id} put back for ${MAX_ATTEMPTS} more attempts`);
      }
      console.log(`${id} is free again, for ${MAX_ATTEMPTS} more attempts`);
    }
  }
} else if (command === 'rejudge' && args[0]) {
  // A song set aside here: judge its kept takes again under the current rules, and keep the first that passes.
  const id = args[0];
  const c = readClaims().get(id);
  if (c?.state !== 'aside') {
    console.log(`${id} is not set aside (${c?.state ?? 'free'})`);
    process.exit(1);
  }
  const takes = readdirSync(OUTPUTS).filter((d) => d.startsWith(`${id}-rejected-`)).sort();
  if (!takes.length) {
    console.log(`${id}: no kept takes here in ${OUTPUTS}; rejudge it on the machine that set it aside`);
    process.exit(1);
  }
  const notReady = await judgeReady();
  if (notReady) throw new Error(notReady);
  let kept: string | undefined;
  for (const take of takes) {
    const dir = path.join(OUTPUTS, take);
    if (!existsSync(path.join(dir, 'whisper.json'))) continue;
    const lyrics = JSON.parse(readFileSync(path.join(dir, 'request.json'), 'utf8')).lyrics;
    const verdict = await judge(lyrics, JSON.parse(readFileSync(path.join(dir, 'whisper.json'), 'utf8')));
    log(`REJUDGED ${take}: ${outcome(verdict)}: ${verdict.summary}`);
    if (outcome(verdict) === 'reject') continue;
    // Put the take back as the song, with its Whisper pass where finish() looks for it.
    const sheets = path.join(REPO, 'sheets', id);
    mkdirSync(sheets, { recursive: true });
    renameSync(path.join(dir, 'whisper.json'), path.join(sheets, 'whisper.json'));
    rmSync(path.join(OUTPUTS, id), { recursive: true, force: true });
    renameSync(dir, path.join(OUTPUTS, id));
    if (await finish(id, false, verdict) !== 'done') {
      log(`REJUDGE FAILED ${id}: ${take} passed but its sheets or library failed`);
      process.exit(1);
    }
    kept = take;
    break;
  }
  if (!kept) {
    console.log(`${id}: no take passes; it stays set aside`);
    process.exit(2);
  }
  await recordSurely(id, readClaims().get(id)?.sha, 'done');
  if (existsSync(path.join(ASIDE, `${id}.json`))) {
    rmSync(path.join(ASIDE, `${id}.json`));
    commitAndPush(path.join('aside', `${id}.json`), `${id} taken out of aside: ${kept} kept under the current lyrics check`);
  }
  console.log(`${id}: kept ${kept}`);
} else if (command === 'remake' && args[0]) {
  process.on('SIGINT', release);
  process.on('SIGTERM', release);
  const notReady = await judgeReady();
  if (notReady) throw new Error(notReady);
  const result = await remake(args[0]);
  process.exit({ done: 0, taken: 1, failed: 2, kept: 2 }[result]);
} else {
  console.error('Usage: bun scripts/generate.ts run [--from-end] | status | claim <id> | retry <id> | rejudge <id> | remake <id>');
  process.exit(1);
}
