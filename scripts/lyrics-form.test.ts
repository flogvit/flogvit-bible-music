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
    expect(lyricsErrors(litany, 'verbatim', 'waltz')).toEqual(['form must be one of litany, strophic, ballad, chant, call-response']);
  });
});

const verse = (...lines: string[]) => `[Verse]\n${lines.join('\n')}`;
const song = (...sections: string[]) => sections.join('\n\n');

describe('strophic and ballad', () => {
  const hymn = song(verse('a', 'b', 'c', 'd'), verse('e', 'f', 'g', 'h'), verse('i', 'j', 'k', 'l'), '[Outro]\nAmen');

  test('verses of one length, with an outro, need no chorus', () => {
    expect(lyricsErrors(hymn, 'mixed', 'strophic')).toEqual([]);
  });

  test('a chorus or bridge, too few verses, or verses of other lengths are errors', () => {
    expect(lyricsErrors(song(verse('a', 'b'), '[Chorus]\nc', verse('d', 'e'), '[Bridge]\nf'), 'mixed', 'strophic')).toEqual([
      'request.lyrics: a strophic song has verses only, not [Chorus]',
      'request.lyrics: a strophic song has verses only, not [Bridge]',
      'request.lyrics: a strophic song needs at least 3 verses, not 2',
    ]);
    const uneven = song(verse('a', 'b', 'c', 'd'), verse('e', 'f'), verse('g', 'h', 'i', 'j'));
    expect(lyricsErrors(uneven, 'mixed', 'strophic')).toEqual([
      'request.lyrics: the verses of a strophic song are sung to one tune and need the same number of lines, not 4, 2',
    ]);
    expect(lyricsErrors(uneven, 'verbatim', 'strophic')).toEqual([]);
  });

  test('a ballad has 4 verses or more, and its refrain ends every verse or none', () => {
    const tale = song(verse('a', 'Refrain'), verse('b', 'Refrain'), verse('c', 'Refrain'), verse('d', 'Refrain'));
    expect(lyricsErrors(tale, 'thematic', 'ballad')).toEqual([]);
    expect(lyricsErrors(tale.replace('d\nRefrain', 'd\ne'), 'thematic', 'ballad')).toEqual([
      'request.lyrics: a ballad\'s refrain "Refrain" ends every verse or none',
    ]);
    expect(lyricsErrors(hymn, 'mixed', 'ballad')).toEqual(['request.lyrics: a ballad song needs at least 4 verses, not 3']);
  });
});

describe('chant', () => {
  const text = verse('Bless the Lord, my soul', 'And bless his holy name');
  const chant = song(text, text, '[Interlude]', text, text, '[Outro]\nBless the Lord, my soul');

  test('one short text sung at least 4 times, with an outro of its lines', () => {
    expect(lyricsErrors(chant, 'verbatim', 'chant')).toEqual([]);
  });

  test('a verse with other words, a chorus, an outro of other words or too few times are errors', () => {
    expect(lyricsErrors(chant.replace('[Outro]\nBless the Lord, my soul', '[Chorus]\nSing\n\n[Outro]\nAmen'), 'verbatim', 'chant')).toEqual([
      'request.lyrics: a chant is one text sung again and again, not [Chorus]',
      'request.lyrics: a chant\'s outro repeats its lines; "Amen" is not one',
    ]);
    expect(lyricsErrors(song(text, text, verse('Other', 'words')), 'verbatim', 'chant')).toEqual([
      'request.lyrics: a chant is sung at least 4 times, not 3',
      'request.lyrics: every verse of a chant is the same text',
    ]);
  });
});

describe('call-response', () => {
  const spiritual = song(
    verse('When Israel was in Egypt land', 'Let my people go', 'Oppressed so hard they could not stand', 'Let my people go'),
    '[Chorus]\nGo down, Moses',
    verse('Thus said the Lord, bold Moses said', 'Let my people go', 'If not I\'ll smite your firstborn dead', 'Amen'),
  );

  test('calls answered by one or two short responses, with a chorus', () => {
    expect(lyricsErrors(spiritual, 'thematic', 'call-response')).toEqual([]);
  });

  test('a long response, a third response, an unanswered call or no chorus are errors', () => {
    const broken = spiritual.replace('Amen', 'Way down in Egypt land, tell old Pharaoh').replace('[Chorus]\nGo down, Moses', '[Verse]\nGo down\nYes');
    expect(lyricsErrors(broken, 'thematic', 'call-response')).toEqual([
      'request.lyrics: a response is at most 6 words; "Way down in Egypt land, tell old Pharaoh" is not',
      'request.lyrics: a call-response song has at most 2 responses, not 3: "Let my people go", "Yes", "Way down in Egypt land, tell old Pharaoh"',
      'request.lyrics has no [Chorus]',
    ]);
    expect(lyricsErrors(spiritual.replace('Oppressed so hard they could not stand\nLet my people go', 'Oppressed so hard'), 'thematic', 'call-response')).toEqual([
      'request.lyrics: a call-response verse is pairs of call and response; "When Israel was in Egypt land" has 3 lines',
    ]);
  });
});
