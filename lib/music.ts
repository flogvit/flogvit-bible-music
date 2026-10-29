/**
 * The public music index (music/index.json) and how to search it.
 *
 * A published music tree looks like this, under any static host or bucket prefix:
 *
 *   index.json                    every song of every collection (MusicIndex)
 *   <collection>/songs.json       the songs of one collection, as its publisher wrote them
 *   <collection>/<id>/audio.mp3   and info.json, alignment.json, chords.pdf, chords.cho, leadsheet.pdf
 *
 * File paths in the index are relative to index.json, so the same index works wherever the tree is served.
 */

export interface Passage {
  bookId: number;
  chapter: number;
  verseStart?: number;
  verseEnd?: number;
  label?: string;
  url?: string;
}

export interface Named {
  slug: string;
  title?: string;
  url?: string;
  epithet?: string;
}

export interface SongFiles {
  mp3: string;
  info: string;
  alignment?: string;
  chordSheet?: string;
  chordPro?: string;
  leadSheet?: string;
}

export interface Song {
  id: string;
  collection: string;
  title: string;
  kind?: string;
  anchor?: { label?: string; url?: string; [key: string]: unknown };
  references: Passage[];
  style: string[];
  styleDescription?: string;
  tags: {
    sentiment?: string[];
    liturgy?: string[];
    theme?: string[];
    themes?: Named[];
    stories?: Named[];
    persons?: Named[];
  };
  lyrics?: string;
  lyricsMode?: string;
  textSource?: string;
  textCredit?: string;
  music?: { durationSeconds?: number; duration?: string; key?: string; meter?: string; bpm?: number };
  files: SongFiles;
}

export interface Book {
  name: string;   // "John"
  short?: string; // "joh", as in bible.flogvit.com URLs
}

export interface MusicIndex {
  version: 1;
  generated: string;
  collections: string[];
  books: Record<string, Book>;
  songs: Song[];
}

/** Merges the collections' song lists into one index, with the book names their passages use. */
export function buildIndex(collections: Record<string, Song[]>, generated = new Date().toISOString()): MusicIndex {
  const names = Object.keys(collections).sort();
  const songs = names.flatMap((c) => collections[c]).sort((a, b) => a.title.localeCompare(b.title));
  const books: Record<string, Book> = {};
  for (const ref of songs.flatMap((s) => s.references)) {
    if (books[ref.bookId] || !ref.label) continue;
    const name = ref.label.replace(/\s+\d+(?::[\d\s,–-]+)?$/, "").trim();
    const short = ref.url?.match(/\/[a-z]{2}\/([^/]+)\/\d+/)?.[1];
    books[ref.bookId] = short ? { name, short } : { name };
  }
  return { version: 1, generated, collections: names, books, songs };
}

export interface Query {
  text?: string;        // words that must all occur in the title, lyrics, style, passages or tags
  verse?: string;       // "John 6:35", "joh 6", "1 Corinthians 13:4-7"
  collection?: string;
  kind?: string;        // verse, chapter, story, theme, person
  style?: string;
  sentiment?: string;
  liturgy?: string;
  theme?: string;       // a theme tag id or a theme slug/title
  story?: string;       // slug or title
  person?: string;      // slug or title
}

export interface VerseRange {
  bookId: number;
  chapter: number;
  verseStart?: number;
  verseEnd?: number;
}

const fold = (s: string) => s.toLowerCase().normalize("NFKD").replace(/[̀-ͯ]/g, "");

/** Reads "John 6:35", "joh 6:30-40" or "1 Cor 13" with the index's book names; null when no book matches. */
export function parseVerse(text: string, books: Record<string, Book>): VerseRange | null {
  const m = fold(text.trim()).match(/^(.+?)\.?\s*(\d+)(?::(\d+)(?:\s*[-–]\s*(\d+))?)?$/);
  if (!m) return null;
  const wanted = m[1].replace(/\s+/g, " ").trim();
  const entry = Object.entries(books).find(([, b]) =>
    fold(b.name) === wanted || (b.short && fold(b.short) === wanted.replace(/\s/g, "")));
  const prefix = entry ?? Object.entries(books).find(([, b]) => fold(b.name).startsWith(wanted));
  if (!prefix) return null;
  const verseStart = m[3] ? Number(m[3]) : undefined;
  return { bookId: Number(prefix[0]), chapter: Number(m[2]), verseStart, verseEnd: m[4] ? Number(m[4]) : verseStart };
}

/** Does a song passage share a verse with the range (a passage without verses is the whole chapter)? */
export function overlaps(p: Passage, r: VerseRange): boolean {
  if (p.bookId !== r.bookId || p.chapter !== r.chapter) return false;
  if (r.verseStart === undefined || p.verseStart === undefined) return true;
  return p.verseStart <= (r.verseEnd ?? r.verseStart) && (p.verseEnd ?? p.verseStart) >= r.verseStart;
}

function namedMatch(list: Named[] | undefined, wanted: string): boolean {
  const w = fold(wanted);
  return (list ?? []).some((n) => fold(n.slug) === w || (n.title !== undefined && fold(n.title).includes(w)));
}

/**
 * Songs matching every given part of the query. With text, the best matches come first (a hit in the
 * title counts most); otherwise they keep the index's order (by title).
 */
export function search(index: MusicIndex, query: Query): Song[] {
  const range = query.verse ? parseVerse(query.verse, index.books) : undefined;
  if (query.verse && !range) return [];
  const words = query.text ? fold(query.text).split(/\s+/).filter(Boolean) : [];
  const hits: { song: Song; score: number }[] = [];
  for (const song of index.songs) {
    const t = song.tags;
    if (query.collection && song.collection !== query.collection) continue;
    if (query.kind && song.kind !== query.kind) continue;
    if (query.style && !song.style.some((s) => fold(s) === fold(query.style!))) continue;
    if (query.sentiment && !(t.sentiment ?? []).includes(query.sentiment)) continue;
    if (query.liturgy && !(t.liturgy ?? []).includes(query.liturgy)) continue;
    if (query.theme && !(t.theme ?? []).includes(query.theme) && !namedMatch(t.themes, query.theme)) continue;
    if (query.story && !namedMatch(t.stories, query.story)) continue;
    if (query.person && !namedMatch(t.persons, query.person)) continue;
    if (range && !song.references.some((p) => overlaps(p, range))) continue;
    let score = 0;
    if (words.length) {
      const title = fold(song.title);
      const rest = fold([
        song.styleDescription, song.style.join(" "), song.anchor?.label, song.lyrics,
        ...song.references.map((r) => r.label),
        ...[t.themes, t.stories, t.persons].flatMap((l) => (l ?? []).map((n) => `${n.slug} ${n.title ?? ""}`)),
        ...(t.theme ?? []), ...(t.sentiment ?? []), ...(t.liturgy ?? []),
      ].filter(Boolean).join(" "));
      if (!words.every((w) => title.includes(w) || rest.includes(w))) continue;
      score = words.reduce((s, w) => s + (title.includes(w) ? 3 : 1), 0);
    }
    hits.push({ song, score });
  }
  return hits.sort((a, b) => b.score - a.score).map((h) => h.song);
}
