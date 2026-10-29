// The lyrics check on real songs, with the local judge model (needs Ollama; about a minute per case).
//   bun test scripts
import { beforeAll, describe, expect, test } from 'bun:test';
import { readFileSync } from 'fs';
import path from 'path';
import { judge, judgeReady, passes } from './lyrics-check';

type Heard = { w: string; s: number; e: number; p: number };
type Fixture = { id: string; lyrics: string; whisper: Record<string, Heard[]> };

const fixture = (id: string): Fixture =>
  JSON.parse(readFileSync(path.join(import.meta.dir, 'fixtures', 'lyrics-check', `${id}.json`), 'utf8'));

/** The same recording with the words heard between `from` and `to` sung once more right after. */
function singTwice(f: Fixture, from: number, to: number): Fixture {
  const whisper: Record<string, Heard[]> = {};
  for (const [key, words] of Object.entries(f.whisper)) {
    const line = words.filter((w) => w.s >= from && w.e <= to);
    const shift = to - from;
    whisper[key] = words.flatMap((w) => {
      if (w.s >= to) return [{ ...w, s: w.s + shift, e: w.e + shift }];
      if (w === line.at(-1)) return [w, ...line.map((x) => ({ ...x, s: x.s + shift, e: x.e + shift }))];
      return [w];
    });
  }
  return { ...f, whisper };
}

const MINUTES = 5 * 60_000;
// Moses: both choruses sung as the lyrics write them out. The doubled line is "He saw a bush that burned but
// was not consumed, a great sight", heard from 45.86 to 51.66 s.
const PASSING = { id: 'person-moses-folk', line: [45.86, 51.66] };

describe('lyrics check', () => {
  beforeAll(async () => {
    const notReady = await judgeReady();
    if (notReady) throw new Error(notReady);
  });

  test('a song whose chorus is sung each time the lyrics repeat it passes', async () => {
    const f = fixture(PASSING.id);
    const v = await judge(f.lyrics, f.whisper);
    expect(v.problems).toEqual([]);
    expect(passes(v)).toBe(true);
  }, MINUTES);

  test('the same song with one verse line sung twice is rejected', async () => {
    const f = singTwice(fixture(PASSING.id), PASSING.line[0], PASSING.line[1]);
    const v = await judge(f.lyrics, f.whisper);
    expect(passes(v)).toBe(false);
  }, MINUTES);

  test('Blessed: the mourn line sung twice in place of poor in spirit is rejected', async () => {
    const f = fixture('verse-40-5-3-folk');
    const v = await judge(f.lyrics, f.whisper);
    expect(passes(v)).toBe(false);
    expect(v.problems.some((p) => p.detail.toLowerCase().includes('mourn'))).toBe(true);
  }, MINUTES);
});
