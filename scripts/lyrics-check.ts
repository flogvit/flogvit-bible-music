#!/usr/bin/env bun
/**
 * Did the singing deliver the lyrics the song asked for? A local LLM (Ollama) compares the requested lyrics,
 * with their sections, against what Whisper heard in the song (whisper.json from song-sheets.py, with times).
 * Three outcomes: "correct" (sung as written), "adopt" (sung differently but as good, singable lyrics: the song
 * is kept and its lyrics become what was sung, in `sung_lyrics`), and "wrong" (broken: garbled, content lost,
 * an unintended repeat, or a meaning that misrepresents the passage), which generate.ts makes again.
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
export type Verdict = {
  verdict: 'correct' | 'adopt' | 'wrong' | 'unsure';
  problems: Problem[];
  summary: string;
  /** With "adopt": the lyrics as sung, in the requested section layout. */
  sung_lyrics?: string;
};

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
down what was actually sung, in phrases with start–end seconds. Decide which of three outcomes fits.

"correct": every requested line is sung as written, apart from what is FINE below.

"adopt": the singing differs from the requested lyrics, but what was sung is itself good, coherent, singable
lyrics that still say what the requested lyrics say about their Bible passage: a line reworded, a word sung
as another word that makes sense, an outro or ad-lib sung in other words, a line left out of a list where the
song still holds together, sections in a slightly different order. The song is kept and its published lyrics
become what was sung. Prefer "adopt" over "wrong" whenever the sung words make sense. Then write the lyrics
as sung in "sung_lyrics": the requested lyrics with every line changed to what was actually sung, in the same
section layout ([Verse], [Chorus], ... on their own lines, a blank line between sections), with normal
capitals and punctuation, keeping the requested wording wherever the difference is only what is FINE below.

"wrong": only for a song that is broken:
- garbled or unintelligible singing: words that are not words, or that make no sense in the line;
- content lost: a verse, chorus or several lines not sung at all, so that the song no longer says what it is
  about (one line left out of a list is "adopt");
- an unintended repeat: a verse line or a whole verse sung again where the structure does not repeat it, in
  place of the next requested line;
- sung words that change the meaning so that the song misrepresents its Bible passage.
Before calling a line missing, look at the times: Whisper often writes nothing for a line sung right after the
same words (a chorus that repeats the end of a verse, a refrain sung twice). When there is a gap in what was
heard long enough for the missing line, the line was most likely sung there and only not written down: that is
FINE.

It is FINE, and not a problem to report, when:
- the chorus, or part of it, is sung more times than written: an extra chorus at the end, a chorus line or
  hook repeated (a hook sung three times where the lyrics write it twice);
- the title line or a hook is echoed as a tag or an ending;
- Whisper misses or swaps a small word (in, the, a, and, of, to, it/he, him/them), a plural or a contraction,
  or gets punctuation and capital letters wrong;
- Whisper wrote a word that sounds almost the same as the requested one (this/theirs, Lot/God, eagle's/eagles),
  most of all when it is marked (?);
- a word or short phrase the lyrics repeat in a row (shine, shine, shine; holy, holy, holy) is written down
  fewer times: Whisper often writes such a run only once;
- "Thank you", "Thanks for watching", "Amen" or a word or two is heard in silence or after the singing ends:
  Whisper invents such words on quiet audio;
- there are wordless vocals (ooh, ah, la) or instrumental parts.
Words marked (?) were heard with low confidence. Phrases from a "second listen" cover a stretch the first
pass missed; use them in place of that stretch.

- Whisper hears a long or drawn-out sung word as other words that sound alike when sung (endures -> can do),
  most of all when the same line is heard right elsewhere in the song.

Go through the requested lyrics line by line and find each line in what was heard, in order. List each
difference you found with the time it is heard at, also for "adopt". Answer "unsure" only when you cannot tell
at all.`;

const SCHEMA = {
  type: 'object',
  properties: {
    verdict: { type: 'string', enum: ['correct', 'adopt', 'wrong', 'unsure'] },
    sung_lyrics: { type: 'string' },
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
    // Bun gives up on a response after 5 minutes; on a busy Mac, or queued behind another Ollama request, the
    // judge can take longer.
    timeout: false,
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

/** Lyrics in the catalog's layout: section tags on their own lines and at least one line of text. */
export const wellFormed = (lyrics: string | undefined) =>
  !!lyrics && /^\[[A-Za-z -]+\]$/m.test(lyrics) && lyrics.split('\n').some((l) => l.trim() && !l.startsWith('['));

/**
 * What to do with the song: keep it as it is, keep it with the sung lyrics, or make it again. The judge lists
 * every difference it found, the fine ones too, so "correct" keeps the song whatever it lists; "adopt" without
 * usable sung lyrics, "unsure" and "wrong" are made again.
 */
export function outcome(v: Verdict): 'ok' | 'adopt' | 'reject' {
  if (v.verdict === 'correct') return 'ok';
  if (v.verdict === 'adopt' && wellFormed(v.sung_lyrics)) return 'adopt';
  return 'reject';
}

/** The song is kept, as it is or with its sung lyrics. */
export const passes = (v: Verdict) => outcome(v) !== 'reject';

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
  process.exit({ ok: 0, adopt: 3, reject: 2 }[outcome(v)]);
}
