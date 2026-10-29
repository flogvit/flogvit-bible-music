#!/usr/bin/env bun
/**
 * Generate catalog songs on several machines at once without making any song twice.
 *
 * Every song has a lock on GitHub: the ref refs/claims/<id>, a chain of empty commits. Each commit's subject is
 * the song's state (`claimed`, `alive`, `done`, `failed`, `released`, `rejected`, `aside`, `retry`) and its
 * body names the machine; its committer date is the last sign of life. Taking a song pushes a commit to that ref without force, so GitHub
 * accepts it only if the ref is still where this machine saw it (missing, or at the stale or released commit it
 * builds on): of two machines that ask at the same time, one push is rejected. While a song generates, the
 * machine adds an `alive` commit every minute; a lock with no sign of life for 20 minutes is free again.
 *
 * Usage:
 *   bun scripts/generate.ts run [--from-end]   finish local songs, then take the next free song, generate it,
 *                                              make its sheets and library folder, mark it done, and repeat
 *   bun scripts/generate.ts status             every song in catalog/order.txt with its state
 *   bun scripts/generate.ts claim <id>         take one song by hand (prints `claimed` or who has it)
 *   bun scripts/generate.ts retry <id>         put a song that was set aside back in the queue
 *   bun scripts/generate.ts rejudge <id>       judge a set-aside song's kept takes again, keep the first that passes
 *
 * Before a song gets its sheets, scripts/lyrics-check.ts judges whether the singing delivers its lyrics. A song
 * sung as written is kept; one sung differently but as good lyrics is kept with the lyrics as sung
 * (lyrics-sung.txt in its folder, used by its sheets and library). Only a broken song is made again with the next
 * seed; after MUSIC_MAX_ATTEMPTS (default 3) it is set aside in aside/<id>.json and the run goes on.
 */
import { existsSync, mkdirSync, openSync, readdirSync, readFileSync, renameSync, rmSync, statSync, writeFileSync } from 'fs';
import { hostname } from 'os';
import path from 'path';
import { judge, JUDGE_MODEL, judgeReady, outcome, type Verdict } from './lyrics-check';

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
// retry: put back by hand after being set aside.
type State = 'claimed' | 'alive' | 'done' | 'failed' | 'released' | 'rejected' | 'aside' | 'retry';
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
 * and sheets commit. A broken song is rejected or set aside.
 */
async function finish(id: string, fresh: boolean, given?: Verdict): Promise<Outcome> {
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
  const env = { MUSIC_MACHINE: MACHINE, FREE_BIBLE: process.env.FREE_BIBLE ?? path.join(path.dirname(MAIN), 'free-bible') };
  if (await run(['python3', 'scripts/build-library.py', songDir], REPO, logFile, env).exited !== 0) {
    log(`LIBRARY FAILED ${id} (see ${logFile})`);
    return 'failed';
  }
  commitAndPush(path.join('sheets', id), `${id} generated on ${MACHINE}, with chord and lead sheets`);
  return 'done';
}

function commitAndPush(paths: string, subject: string) {
  git('add', '-A', paths);
  if (!git('diff', '--cached', '--name-only').trim()) return;
  git('commit', '-q', '-m', subject, '-m', 'Co-Authored-By: Claude Opus 5.5 <noreply@anthropic.com>');
  const branch = process.env.MUSIC_SHEETS_BRANCH ?? git('branch', '--show-current').trim();
  const r = Bun.spawnSync(['git', 'push', '-q', 'origin', `HEAD:${branch}`], { cwd: REPO });
  if (r.exitCode !== 0) log(`PUSH FAILED ${subject} to ${branch}: ${r.stderr.toString().trim()}`);
}

/** Rejections in the song's lock: all of them (each attempt gets its own seed), and since it was last put back. */
function rejections(id: string): { total: number; sinceRetry: number } {
  if (!git('for-each-ref', `${NS}/${id}`).trim()) return { total: 0, sinceRetry: 0 };
  const subjects = git('log', '--format=%s', `${NS}/${id}`).split('\n');
  const retry = subjects.findIndex((s) => s.startsWith('retry '));
  const count = (list: string[]) => list.filter((s) => s.startsWith('rejected ')).length;
  return { total: count(subjects), sinceRetry: count(retry < 0 ? subjects : subjects.slice(0, retry)) };
}

/**
 * The lyrics did not pass. The audio moves to YuE/outputs/catalog/<id>-rejected-<n>/ (with whisper.json and
 * lyrics-check.json, to listen to later), so the song is made again; after MAX_ATTEMPTS it goes in aside/.
 */
function reject(id: string, verdict: Verdict): 'rejected' | 'aside' {
  const { total, sinceRetry } = rejections(id);
  const kept = path.join(OUTPUTS, `${id}-rejected-${total + 1}`);
  rmSync(kept, { recursive: true, force: true });
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

/** Generate one claimed song; its lock comes back while the song still needs its sheets. */
async function generate(id: string, tip: string): Promise<Lock | undefined> {
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
    lock.end('failed');
    return;
  }
  const seconds = Math.round(JSON.parse(readFileSync(path.join(OUTPUTS, id, 'result.json'), 'utf8')).audio_seconds);
  log(`SONG DONE ${id} ${Math.floor(seconds / 60)}:${String(seconds % 60).padStart(2, '0')}`);
  return lock;
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

function release() {
  for (const child of children) child.kill();
  for (const lock of held) lock.end('released');
  process.exit(1);
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
  await finishLocal();
  // Songs this run does not take again: generation failed here, or set aside. A rejected song is counted here too,
  // so the limit holds in this run even if GitHub missed a rejection.
  const failed = new Set<string>();
  const rejectedHere = new Map<string, number>();
  // A song's sheets are made while the next song generates (Whisper on the CPU, YuE on the GPU), one at a time.
  let sheets = Promise.resolve();
  for (let next = await claimNextWhenOnline(fromEnd, failed); next; next = await claimNextWhenOnline(fromEnd, failed)) {
    log(`CLAIMED ${next.id}`);
    const lock = await generate(next.id, next.tip);
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
      const count = (rejectedHere.get(lock.id) ?? 0) + (outcome === 'rejected' ? 1 : 0);
      rejectedHere.set(lock.id, count);
      if (outcome === 'aside' || count >= MAX_ATTEMPTS) failed.add(lock.id);
    });
  }
  await sheets;
  log('RUN END: no free songs left');
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
} else {
  console.error('Usage: bun scripts/generate.ts run [--from-end] | status | claim <id> | retry <id> | rejudge <id>');
  process.exit(1);
}
