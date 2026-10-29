#!/usr/bin/env bun
/**
 * Did the singing deliver the lyrics the song asked for? A local LLM (Ollama) compares the requested lyrics,
 * with their sections, against what Whisper heard in the song (whisper.json from song-sheets.py, with times).
 * Only a confident "correct" lets a song through; generate.ts makes the song again otherwise.
 *
 * Usage: bun scripts/lyrics-check.ts <song-id> [whisper.json]   (default sheets/<id>/whisper.json)
 * Environment: MUSIC_JUDGE_MODEL (default qwen3.8:27b), OLLAMA_HOST (default http://localhost:11434).
 */
import { readFileSync } from 'fs';
import path from 'path';

export const JUDGE_MODEL = process.env.MUSIC_JUDGE_MODEL ?? 'qwen3.8:27b';
const OLLAMA = process.env.OLLAMA_HOST ?? 'http://localhost:11434';

type Heard = { w: string; s: number; e: number; p: number };
export type Problem = { time: string; kind: 'wrong words' | 'missing' | 'unrequested repeat' | 'other'; detail: string };
export type Verdict = { verdict: 'correct' | 'wrong' | 'unsure'; problems: Problem[]; summary: string };

/** whisper.json holds one full pass over the song and second listens over stretches the first pass missed. */
export function heardText(whisper: Record<string, Heard[]>): string {
  const fmt = (t: number) => t.toFixed(1);
  const phrases = (words: Heard[]) => {
    const out: string[] = [];
    let line: Heard[] = [];
    const flush = () => {
      if (line.length) out.push(`[${fmt(line[0].s)}–${fmt(line.at(-1)!.e)}] ` + line.map((w) => w.p < 0.5 ? `${w.w}(?)` : w.w).join(' '));
      line = [];
    };
    for (const w of words) {
      if (line.length && w.s - line.at(-1)!.e > 0.7) flush();
      line.push(w);
    }
    flush();
    return out.join('\n');
  };
  const parts: string[] = [];
  for (const [key, words] of Object.entries(whisper)) {
    const [, start, end] = key.split('|');
    parts.push(start === 'None'
      ? `Whole song:\n${phrases(words)}`
      : `Second listen to ${start}–${end} s, which the first pass did not catch:\n${phrases(words)}`);
  }
  return parts.join('\n\n');
}

const RULES = `You check AI-generated songs before they are published. The singer was asked to sing the requested
lyrics below, section by section, in that order. Whisper (speech recognition, prompted with the lyrics) wrote
down what was actually sung, in phrases with start–end seconds. Decide whether the singing delivers the
requested lyrics.

It is WRONG when any of these happen:
- a requested line, or a part of it that carries meaning, is not sung (also a missing ending or outro);
- a line is replaced by another line, or two lines are merged so that part of each is lost;
- a word that carries meaning is sung as a different word that does not sound like it (Bless -> Praise,
  see God -> seek out);
- a verse line or a whole verse is sung again where the structure does not repeat it, or a chorus line is
  sung twice where the next requested line should be.
A repeat is only fine when every requested line is still sung: a repeat that takes the place of a requested
line is wrong.

It is FINE, and not a problem to report, when:
- the chorus, or part of it, is sung more times than written: an extra chorus at the end, a chorus line or
  hook repeated (a hook sung three times where the lyrics write it twice);
- the title line or a hook is echoed as a tag or an ending;
- Whisper misses or swaps a small word (in, the, a, and, of, to, it/he, him/them), a plural or a contraction,
  or gets punctuation and capital letters wrong;
- Whisper wrote a word that sounds almost the same as the requested one (this/theirs, Lot/God, eagle's/eagles),
  most of all when it is marked (?);
- "Thank you", "Thanks for watching", "Amen" or a word or two is heard in silence or after the singing ends:
  Whisper invents such words on quiet audio;
- there are wordless vocals (ooh, ah, la) or instrumental parts.
Words marked (?) were heard with low confidence. Phrases from a "second listen" cover a stretch the first
pass missed; use them in place of that stretch.

Go through the requested lyrics line by line and find each line in what was heard, in order. Answer "correct"
only when you are confident every requested line was sung and nothing was repeated beyond what is fine above.
Answer "wrong" when you found a problem, and "unsure" when you cannot tell. List each problem with the
time it is heard at.`;

const SCHEMA = {
  type: 'object',
  properties: {
    verdict: { type: 'string', enum: ['correct', 'wrong', 'unsure'] },
    problems: {
      type: 'array',
      items: {
        type: 'object',
        properties: {
          time: { type: 'string' },
          kind: { type: 'string', enum: ['wrong words', 'missing', 'unrequested repeat', 'other'] },
          detail: { type: 'string' },
        },
        required: ['time', 'kind', 'detail'],
      },
    },
    summary: { type: 'string' },
  },
  required: ['verdict', 'problems', 'summary'],
};

/** Is the judge model there to ask? Pulls it once when Ollama runs but lacks it. */
export async function judgeReady(): Promise<string | undefined> {
  try {
    const tags = await (await fetch(`${OLLAMA}/api/tags`)).json() as { models: { name: string }[] };
    if (tags.models.some((m) => m.name === JUDGE_MODEL)) return;
    const r = await fetch(`${OLLAMA}/api/pull`, { method: 'POST', body: JSON.stringify({ model: JUDGE_MODEL, stream: false }) });
    if (!r.ok) return `cannot pull ${JUDGE_MODEL}: ${await r.text()}`;
  } catch (e) {
    return `Ollama does not answer at ${OLLAMA} (${e})`;
  }
}

export async function judge(lyrics: string, whisper: Record<string, Heard[]>): Promise<Verdict> {
  const r = await fetch(`${OLLAMA}/api/chat`, {
    method: 'POST',
    body: JSON.stringify({
      model: JUDGE_MODEL,
      stream: false,
      think: true,
      format: SCHEMA,
      keep_alive: 0, // give the memory back to YuE between songs
      options: { temperature: 0, seed: 1, num_ctx: 16384 },
      messages: [
        { role: 'system', content: RULES },
        { role: 'user', content: `Requested lyrics:\n${lyrics.trim()}\n\nWhat Whisper heard:\n${heardText(whisper)}` },
      ],
    }),
  });
  if (!r.ok) throw new Error(`${JUDGE_MODEL}: ${r.status} ${await r.text()}`);
  return JSON.parse((await r.json() as { message: { content: string } }).message.content) as Verdict;
}

/** Only a confident "correct" with nothing found passes. */
export const passes = (v: Verdict) => v.verdict === 'correct' && v.problems.length === 0;

export function catalogLyrics(id: string): string {
  return JSON.parse(readFileSync(path.join(import.meta.dir, '..', 'catalog', `${id}.json`), 'utf8')).request.lyrics;
}

if (import.meta.main) {
  const [id, file] = process.argv.slice(2);
  if (!id) {
    console.error('Usage: bun scripts/lyrics-check.ts <song-id> [whisper.json]');
    process.exit(1);
  }
  const whisper = JSON.parse(readFileSync(file ?? path.join(import.meta.dir, '..', 'sheets', id, 'whisper.json'), 'utf8'));
  const v = await judge(catalogLyrics(id), whisper);
  console.log(JSON.stringify(v, null, 2));
  process.exit(passes(v) ? 0 : 2);
}
