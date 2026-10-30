/**
 * The section and form rules for a catalog song's `request.lyrics` (README, Catalog), used by validate-catalog.ts.
 *
 * Without `form`, a song has a chorus: `[Chorus]` or `[Refrain]` (a verbatim song may go without). The forms
 * (docs/research/diversity.md, section 4):
 * - `litany`: every line is answered by one refrain line, as Psalm 136 does; no chorus.
 * - `strophic`: verses only, as a hymn or a metrical psalm: no chorus, pre-chorus or bridge, at least 3 verses,
 *   all of the same length (one tune for every verse), except in a verbatim song, whose verses follow the text.
 * - `ballad`: a story told in at least 4 verses of the same length, without chorus or bridge; a short refrain at
 *   most, as the last line of every verse.
 * - `chant`: one short text of 2 to 4 lines, sung again and again as every verse (at least 4 times), as in Taizé;
 *   an outro may repeat lines of it.
 * - `call-response`: a lead line answered by a short response (at most 6 words, at most 2 different responses),
 *   in every verse, as in gospel and spirituals; the chorus stays.
 */
export const SECTION = /^\[(Intro|Verse|Pre-Chorus|Chorus|Bridge|Outro|Interlude|Refrain|Hook|Break|Instrumental)\]$/;
export const FORMS = ['litany', 'strophic', 'ballad', 'chant', 'call-response'];

type Section = { tag: string; lines: string[] };

export function lyricsErrors(lyrics: string, lyricsMode: string, form?: string): string[] {
  const errors: string[] = [];
  if (form !== undefined && !FORMS.includes(form)) errors.push(`form must be one of ${FORMS.join(', ')}`);
  const lines = lyrics.split('\n');
  if (!SECTION.test(lines[0])) errors.push('request.lyrics must start with a section tag such as [Verse]');
  const tags = lines.filter((l) => l.startsWith('['));
  for (const l of tags) if (!SECTION.test(l)) errors.push(`request.lyrics: unknown section tag ${l}`);
  const sections = sectionsOf(lines);
  const hasChorus = tags.some((l) => /Chorus|Refrain/.test(l));
  if (form === 'litany') errors.push(...litanyErrors(lines.filter((l) => l.trim() && !l.startsWith('['))));
  else if (form === 'strophic') errors.push(...versesOnly(sections, form, 3, lyricsMode !== 'verbatim'));
  else if (form === 'ballad') errors.push(...versesOnly(sections, form, 4, true), ...balladRefrainErrors(sections));
  else if (form === 'chant') errors.push(...chantErrors(sections));
  else if (form === 'call-response') {
    errors.push(...callResponseErrors(sections));
    if (!hasChorus) errors.push('request.lyrics has no [Chorus]');
  } else if (!hasChorus && lyricsMode !== 'verbatim') errors.push('request.lyrics has no [Chorus]');
  return errors;
}

function sectionsOf(lines: string[]): Section[] {
  const sections: Section[] = [];
  for (const l of lines) {
    if (l.startsWith('[')) sections.push({ tag: l.slice(1, -1), lines: [] });
    else if (l.trim() && sections.length) sections.at(-1)!.lines.push(l.trim());
  }
  return sections;
}

// Sections besides the verses that a form without a chorus may have: an intro, an outro, instrumental parts.
const FRAME = ['Intro', 'Outro', 'Interlude', 'Instrumental'];

/** The refrain is the line sung most often; every other line must be answered by it. */
function litanyErrors(sung: string[]): string[] {
  const counts = new Map<string, number>();
  for (const l of sung) counts.set(l, (counts.get(l) ?? 0) + 1);
  const [refrain, times] = [...counts].sort((a, b) => b[1] - a[1])[0] ?? ['', 0];
  if (times < 2) return ['request.lyrics: a litany needs a refrain line that answers the other lines'];
  return sung.flatMap((l, i) => l !== refrain && sung[i + 1] !== refrain
    ? [`request.lyrics: in a litany every line is answered by the refrain "${refrain}"; "${l}" is not`]
    : []);
}

function versesOnly(sections: Section[], form: string, least: number, sameLength: boolean): string[] {
  const errors = sections.filter((s) => s.tag !== 'Verse' && !FRAME.includes(s.tag))
    .map((s) => `request.lyrics: a ${form} song has verses only, not [${s.tag}]`);
  const verses = sections.filter((s) => s.tag === 'Verse');
  if (verses.length < least) errors.push(`request.lyrics: a ${form} song needs at least ${least} verses, not ${verses.length}`);
  const lengths = new Set(verses.map((v) => v.lines.length));
  if (sameLength && lengths.size > 1) {
    errors.push(`request.lyrics: the verses of a ${form} song are sung to one tune and need the same number of lines, not ${[...lengths].join(', ')}`);
  }
  return errors;
}

/** A ballad's refrain, if it has one, is the last line of every verse. */
function balladRefrainErrors(sections: Section[]): string[] {
  const ends = sections.filter((s) => s.tag === 'Verse').map((v) => v.lines.at(-1));
  const repeated = ends.find((e, i) => ends.indexOf(e) !== i);
  if (!repeated || ends.every((e) => e === repeated)) return [];
  return [`request.lyrics: a ballad's refrain "${repeated}" ends every verse or none`];
}

function chantErrors(sections: Section[]): string[] {
  const errors = sections.filter((s) => s.tag !== 'Verse' && !FRAME.includes(s.tag))
    .map((s) => `request.lyrics: a chant is one text sung again and again, not [${s.tag}]`);
  const verses = sections.filter((s) => s.tag === 'Verse');
  const chant = verses[0]?.lines ?? [];
  if (chant.length < 2 || chant.length > 4) errors.push(`request.lyrics: a chant's text is 2 to 4 lines, not ${chant.length}`);
  if (verses.length < 4) errors.push(`request.lyrics: a chant is sung at least 4 times, not ${verses.length}`);
  if (verses.some((v) => v.lines.join('\n') !== chant.join('\n'))) errors.push('request.lyrics: every verse of a chant is the same text');
  for (const s of sections.filter((s) => s.tag === 'Outro')) {
    for (const l of s.lines) if (!chant.includes(l)) errors.push(`request.lyrics: a chant's outro repeats its lines; "${l}" is not one`);
  }
  return errors;
}

/** In every verse, each lead line is answered by a short response; the same one or two responses throughout. */
function callResponseErrors(sections: Section[]): string[] {
  const verses = sections.filter((s) => s.tag === 'Verse');
  if (!verses.length) return ['request.lyrics: a call-response song needs verses of calls and responses'];
  const errors: string[] = [];
  const responses = new Set<string>();
  for (const v of verses) {
    if (v.lines.length % 2) errors.push(`request.lyrics: a call-response verse is pairs of call and response; "${v.lines[0]}" has ${v.lines.length} lines`);
    for (let i = 1; i < v.lines.length; i += 2) {
      responses.add(v.lines[i]);
      if (v.lines[i].split(/\s+/).length > 6) errors.push(`request.lyrics: a response is at most 6 words; "${v.lines[i]}" is not`);
    }
  }
  if (responses.size > 2) errors.push(`request.lyrics: a call-response song has at most 2 responses, not ${responses.size}: ${[...responses].map((r) => `"${r}"`).join(', ')}`);
  return errors;
}
