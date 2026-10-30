import { describe, expect, test } from 'bun:test';
import { lyricsErrors } from './lyrics-form';

const refrain = 'His steadfast love endures forever';
const litany = `[Verse]\nGive thanks to the LORD, for he is good\n${refrain}\nGive thanks to the God of gods\n${refrain}\n\n[Outro]\nGive thanks to the God of heaven\n${refrain}\n${refrain}`;

describe('lyricsErrors', () => {
  test('a song without a form still needs a chorus, unless it is verbatim', () => {
    expect(lyricsErrors('[Verse]\nOne line\nTwo lines', 'mixed')).toEqual(['request.lyrics has no [Chorus]']);
    expect(lyricsErrors('[Verse]\nOne line\n\n[Refrain]\nTwo lines', 'mixed')).toEqual([]);
    expect(lyricsErrors('[Verse]\nOne line\nTwo lines', 'verbatim')).toEqual([]);
  });

  test('a litany needs no chorus when every line is answered by its refrain', () => {
    expect(lyricsErrors(litany, 'mixed', 'litany')).toEqual([]);
  });

  test('a litany line the refrain does not answer is an error', () => {
    const broken = litany.replace(`Give thanks to the God of gods\n${refrain}`, `Give thanks to the God of gods\nTo him who alone does great wonders\n${refrain}`);
    expect(lyricsErrors(broken, 'verbatim', 'litany')).toEqual([
      `request.lyrics: in a litany every line is answered by the refrain "${refrain}"; "Give thanks to the God of gods" is not`,
    ]);
  });

  test('a litany without a recurring line, or an unknown form, is an error', () => {
    expect(lyricsErrors('[Verse]\nOne line\nTwo lines', 'verbatim', 'litany')).toEqual([
      'request.lyrics: a litany needs a refrain line that answers the other lines',
    ]);
    expect(lyricsErrors(litany, 'verbatim', 'ballad')).toEqual(['form must be one of litany']);
  });
});
