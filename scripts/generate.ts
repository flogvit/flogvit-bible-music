#!/usr/bin/env bun
/**
 * Generate catalog songs on several machines at once without making any song twice.
 *
 * Every song has a lock on GitHub: the ref refs/claims/<id>, a chain of empty commits. Each commit's subject is
 * the song's state (`claimed`, `alive`, `done`, `failed`, `released`) and its body names the machine; its
 * committer date is the last sign of life. Taking a song pushes a commit to that ref without force, so GitHub
 * accepts it only if the ref is still where this machine saw it (missing, or at the stale or released commit it
 * builds on): of two machines that ask at the same time, one push is rejected. While a song generates, the
 * machine adds an `alive` commit every minute; a lock with no sign of life for 20 minutes is free again.
 *
 * Usage:
 *   bun scripts/generate.ts run [--from-end]   finish local songs, then take the next free song, generate it,
 *                                              make its sheets and library folder, mark it done, and repeat
 *   bun scripts/generate.ts status             every song in catalog/order.txt with its state
 *   bun scripts/generate.ts claim <id>         take one song by hand (prints `claimed` or who has it)
 */
import { existsSync, mkdirSync, openSync, readdirSync, readFileSync, rmSync, statSync } from 'fs';
import { hostname } from 'os';
import path from 'path';

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

type State = 'claimed' | 'alive' | 'done' | 'failed' | 'released';
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
    claims.set(id, { id, sha, state: subject.split(' ')[0] as State, machine, time: Number(time) });
  }
  return claims;
}

function isFree(c: Claim | undefined): boolean {
  if (!c || c.state === 'failed' || c.state === 'released') return true;
  if (c.state === 'done') return false;
  return Date.now() / 1000 - c.time > STALE_SECONDS;
}

/** Push a new state for a song on top of `parent` (or as a new lock). Rejected means another machine moved the ref. */
function push(id: string, parent: string | undefined, state: State): { result: 'ok' | 'rejected' | 'error'; sha?: string; detail?: string } {
  const sha = git('commit-tree', EMPTY_TREE, ...(parent ? ['-p', parent] : []), '-m', `${state} ${id}`, '-m', `machine: ${MACHINE}`).trim();
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

/** Sheets, library folder and the sheets commit for a song whose audio is done. */
async function finish(id: string, fresh: boolean): Promise<boolean> {
  const songDir = path.join(OUTPUTS, id);
  const sheets = path.join(REPO, 'sheets', id);
  const logFile = path.join(OUTPUTS, `${id}-run.log`);
  if (fresh) for (const f of ['whisper.json', 'alignment.json']) rmSync(path.join(sheets, f), { force: true });
  if (fresh || !existsSync(path.join(sheets, `${id}-lead-sheet.pdf`))) {
    const py = path.join(MAIN, '.venv-sheets', 'bin', 'python');
    if (await run([...sheetsPriority, py, 'scripts/song-sheets.py', songDir], REPO, logFile).exited !== 0) {
      log(`SHEETS FAILED ${id} (see ${logFile})`);
      return false;
    }
  }
  const env = { MUSIC_MACHINE: MACHINE, FREE_BIBLE: process.env.FREE_BIBLE ?? path.join(path.dirname(MAIN), 'free-bible') };
  if (await run(['python3', 'scripts/build-library.py', songDir], REPO, logFile, env).exited !== 0) {
    log(`LIBRARY FAILED ${id} (see ${logFile})`);
    return false;
  }
  git('add', path.join('sheets', id));
  if (git('diff', '--cached', '--name-only').trim()) {
    git('commit', '-q', '-m', `${id} generated on ${MACHINE}, with chord and lead sheets`, '-m', 'Co-Authored-By: Claude Opus 5.5 <noreply@anthropic.com>');
    const branch = process.env.MUSIC_SHEETS_BRANCH ?? git('branch', '--show-current').trim();
    const r = Bun.spawnSync(['git', 'push', '-q', 'origin', `HEAD:${branch}`], { cwd: REPO });
    if (r.exitCode !== 0) log(`PUSH FAILED ${id} to ${branch}: ${r.stderr.toString().trim()}`);
  }
  return true;
}

function record(id: string, tip: string | undefined, state: State) {
  const r = push(id, tip, state);
  log(r.result === 'ok' ? `${state.toUpperCase()} ${id}` : `${state.toUpperCase()} NOT RECORDED ${id}: ${r.detail}`);
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
}

const held = new Set<Lock>();
const children = new Set<ReturnType<typeof Bun.spawn>>();

/** Generate one claimed song; its lock comes back while the song still needs its sheets. */
async function generate(id: string, tip: string): Promise<Lock | undefined> {
  const batch = path.join(YUE, 'requests', `${id}.jsonl`);
  if (Bun.spawnSync(['bun', 'scripts/build-batch.ts', batch, id], { cwd: REPO }).exitCode !== 0) throw new Error(`build-batch ${id}`);
  mkdirSync(OUTPUTS, { recursive: true });
  const logFile = path.join(OUTPUTS, `${id}-run.log`);
  const child = run(['taskpolicy', '-b', '.venv/bin/yue2', 'batch', '--input', batch, '--output', OUTPUTS,
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

/** Songs this machine already made (also before the claims existed) are finished and marked done. */
async function finishLocal() {
  const claims = readClaims();
  for (const id of order()) {
    const c = claims.get(id);
    if (!isComplete(id) || c?.state === 'done' || (c && c.machine !== MACHINE && !isFree(c))) continue;
    if (await finish(id, false)) record(id, c?.sha, 'done');
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
  await finishLocal();
  const failed = new Set<string>();
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
      let ok = false;
      try {
        ok = await finish(lock.id, true);
      } catch (e) {
        log(`SHEETS FAILED ${lock.id}: ${e}`);
      }
      lock.end(ok ? 'done' : 'failed');
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
    const state = !c ? 'free' : c.state === 'done' ? 'done' : isFree(c) ? (c.state === 'claimed' || c.state === 'alive' ? 'stale' : c.state) : 'generating';
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
} else {
  console.error('Usage: bun scripts/generate.ts run [--from-end] | status | claim <id>');
  process.exit(1);
}
