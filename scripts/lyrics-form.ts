/**
 * The section and form rules for a catalog song's `request.lyrics` (README, Catalog), used by validate-catalog.ts.
 *
 * Without `form`, a song has a chorus: `[Chorus]` or `[Refrain]` (a verbatim song may go without). A song with
 * `form: "litany"` answers every line with one refrain line, as Psalm 136 does, and needs no chorus.
 */
export const SECTION = /^\[(Intro|Verse|Pre-Chorus|Chorus|Bridge|Outro|Interlude|Refrain|Hook|Break|Instrumental)\]$/;
export const FORMS = ['litany'];

export function lyricsErrors(lyrics: string, lyricsMode: string, form?: string): string[] {
  const errors: string[] = [];
  if (form !== undefined && !FORMS.includes(form)) errors.push(`form must be one of ${FORMS.join(', ')}`);
  const lines = lyrics.split('\n');
  if (!SECTION.test(lines[0])) errors.push('request.lyrics must start with a section tag such as [Verse]');
  const tags = lines.filter((l) => l.startsWith('['));
  for (const l of tags) if (!SECTION.test(l)) errors.push(`request.lyrics: unknown section tag ${l}`);
  if (form === 'litany') errors.push(...litanyErrors(lines.filter((l) => l.trim() && !l.startsWith('['))));
  else if (!tags.some((l) => /Chorus|Refrain/.test(l)) && lyricsMode !== 'verbatim') errors.push('request.lyrics has no [Chorus]');
  return errors;
}

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
