#!/usr/bin/env bun
/**
 * Add the next songs to the catalog from free-bible, the data bible.flogvit.com is built from: one song for every
 * theme, person and story without one, and for every verse of the day without one. The pages people visit most
 * on the site come first (catalog/popularity.tsv, from scripts/popularity.py), then the Bible data's own weight.
 * A local LLM (Ollama) writes each song's lyrics, title, style line and tags from the free-bible text and the osen
 * translation; the song gets the form its kind asks for when that form has passed its test (FORMS_IN_USE), and
 * the genre the catalog has least of among those that suit it. Every song is checked as validate-catalog does.
 *
 * Usage:
 *   bun scripts/catalog-write.ts --list          the songs still missing, in the order they will be written
 *   bun scripts/catalog-write.ts [--count 10]    write the next ones to catalog/<id>.json and catalog/order.txt
 * Environment: MUSIC_WRITER_MODEL (default the lyrics check's model), OLLAMA_HOST, FREE_BIBLE.
 */
import { existsSync, readdirSync, readFileSync, writeFileSync, appendFileSync } from 'fs';
import path from 'path';
import { JUDGE_MODEL } from './lyrics-check';
import { lyricsErrors } from './lyrics-form';

const REPO = path.join(import.meta.dir, '..');
const CATALOG = path.join(REPO, 'catalog');
const MAIN = path.dirname(Bun.spawnSync(['git', 'rev-parse', '--path-format=absolute', '--git-common-dir'], { cwd: REPO }).stdout.toString().trim());
const FREE_BIBLE = path.join(process.env.FREE_BIBLE ?? path.join(path.dirname(MAIN), 'free-bible'), 'generate');
const MODEL = process.env.MUSIC_WRITER_MODEL ?? JUDGE_MODEL;
const OLLAMA = process.env.OLLAMA_HOST ?? 'http://localhost:11434';

// Forms that passed their test on a group of songs (docs/research/diversity.md, Form tests); the others stay
// verse-chorus until theirs passes.
export const FORMS_IN_USE = ['strophic'];

// The genres of the catalog, and the forms each can carry.
const GENRES: Record<string, string[]> = {
  folk: ['ballad', 'strophic'], gospel: ['call-response', 'chant'], orchestral: [], rock: [], children: [],
  soul: ['call-response'], ballad: ['ballad'], celtic: ['ballad', 'strophic', 'chant'], country: ['ballad'],
  acoustic: ['ballad', 'chant'], worship: ['chant'], blues: ['ballad', 'call-response'], pop: [], jazz: [],
  hymn: ['strophic'], choral: ['strophic', 'chant'],
};

type Ref = { bookId: number; chapter: number; verseStart: number; verseEnd: number };
type Item = { kind: 'theme' | 'person' | 'story' | 'verse'; slug: string; page: string; title: string; weight: number; data: any; refs: Ref[] };

const json = (file: string) => JSON.parse(readFileSync(file, 'utf8'));
const dir = (sub: string) => readdirSync(path.join(FREE_BIBLE, sub)).filter((f) => f.endsWith('.json') && !f.startsWith('.'));

const osenCache = new Map<string, { verseId: number; text: string }[]>();
function chapterText(bookId: number, chapter: number) {
  const key = `${bookId}/${chapter}`;
  if (!osenCache.has(key)) {
    const file = path.join(FREE_BIBLE, 'bibles_raw', 'osen', String(bookId), `${chapter}.json`);
    osenCache.set(key, existsSync(file) ? json(file) : []);
  }
  return osenCache.get(key)!;
}
const verseText = (r: Ref) => chapterText(r.bookId, r.chapter).filter((v) => v.verseId >= r.verseStart && v.verseId <= r.verseEnd);
const exists = (r: Ref) => verseText(r).length > 0 && chapterText(r.bookId, r.chapter).some((v) => v.verseId === r.verseEnd);

// bookId: the book's short name in bible.flogvit.com URLs and its English name (as in build-library.py).
const BOOKS: Record<number, [string, string]> = Object.fromEntries(Object.entries({
  1: '1mos Genesis', 2: '2mos Exodus', 3: '3mos Leviticus', 4: '4mos Numbers', 5: '5mos Deuteronomy', 6: 'jos Joshua',
  7: 'dom Judges', 8: 'rut Ruth', 9: '1sam 1 Samuel', 10: '2sam 2 Samuel', 11: '1kong 1 Kings', 12: '2kong 2 Kings',
  13: '1krøn 1 Chronicles', 14: '2krøn 2 Chronicles', 15: 'esr Ezra', 16: 'neh Nehemiah', 17: 'est Esther', 18: 'job Job',
  19: 'sal Psalms', 20: 'ord Proverbs', 21: 'fork Ecclesiastes', 22: 'høy Song of Solomon', 23: 'jes Isaiah',
  24: 'jer Jeremiah', 25: 'klag Lamentations', 26: 'esek Ezekiel', 27: 'dan Daniel', 28: 'hos Hosea', 29: 'joel Joel',
  30: 'amos Amos', 31: 'ob Obadiah', 32: 'jona Jonah', 33: 'mika Micah', 34: 'nah Nahum', 35: 'hab Habakkuk',
  36: 'sef Zephaniah', 37: 'hag Haggai', 38: 'sak Zechariah', 39: 'mal Malachi', 40: 'matt Matthew', 41: 'mark Mark',
  42: 'luk Luke', 43: 'joh John', 44: 'apg Acts', 45: 'rom Romans', 46: '1kor 1 Corinthians', 47: '2kor 2 Corinthians',
  48: 'gal Galatians', 49: 'ef Ephesians', 50: 'fil Philippians', 51: 'kol Colossians', 52: '1tess 1 Thessalonians',
  53: '2tess 2 Thessalonians', 54: '1tim 1 Timothy', 55: '2tim 2 Timothy', 56: 'tit Titus', 57: 'filem Philemon',
  58: 'hebr Hebrews', 59: 'jak James', 60: '1pet 1 Peter', 61: '2pet 2 Peter', 62: '1joh 1 John', 63: '2joh 2 John',
  64: '3joh 3 John', 65: 'jud Jude', 66: 'åp Revelation',
}).map(([id, s]) => [Number(id), [s.split(' ')[0], s.slice(s.indexOf(' ') + 1)] as [string, string]]));
const label = (r: Ref) => `${BOOKS[r.bookId][1]} ${r.chapter}:${r.verseStart}${r.verseEnd !== r.verseStart ? `-${r.verseEnd}` : ''}`;
const urlSlug = (s: string) => s.toLowerCase().replace(/å/g, 'a').replace(/ø/g, 'o').replace(/æ/g, 'ae');

/** Visitors per page path (without the language), from catalog/popularity.tsv: `visitors<TAB>/<lang>/<path>`. */
function popularity(): Map<string, number> {
  const out = new Map<string, number>();
  const file = path.join(CATALOG, 'popularity.tsv');
  if (!existsSync(file)) return out;
  for (const line of readFileSync(file, 'utf8').split('\n')) {
    const [n, p] = line.split('\t');
    if (!p) continue;
    const page = decodeURIComponent(p).toLowerCase().split('/').slice(2).join('/');
    out.set(page, (out.get(page) ?? 0) + Number(n));
  }
  return out;
}

/** Up to `max` passages, merged from verse lists. */
function passages(list: { bookId: number; chapter: number; verses: number[] }[], max = 6): Ref[] {
  const out: Ref[] = [];
  for (const v of list) {
    if (!v.verses?.length) continue;
    const r = { bookId: v.bookId, chapter: v.chapter, verseStart: Math.min(...v.verses), verseEnd: Math.max(...v.verses) };
    if (exists(r) && !out.some((o) => o.bookId === r.bookId && o.chapter === r.chapter && o.verseStart === r.verseStart)) out.push(r);
    if (out.length === max) break;
  }
  return out;
}

/** Every theme, person, story and verse of the day without a song, with its page on the site and its weight. */
export function missing(): Item[] {
  const songs = readdirSync(CATALOG).filter((f) => f.endsWith('.json')).map((f) => json(path.join(CATALOG, f)));
  // A theme and a person can share a slug (peter, moses), so the kind is part of the key.
  const key = (kind: string, slug: string) => `${kind}:${slug}`;
  const has = new Set(songs.map((s) => key(s.kind === 'chapter' ? 'verse' : s.kind,
    s.anchor.theme ?? s.anchor.person ?? s.anchor.story ?? `${s.anchor.bookId}:${s.anchor.chapter}:${s.anchor.verseStart ?? 1}`)));
  const items: Item[] = [];
  for (const f of dir('themes/en')) {
    const slug = f.slice(0, -5);
    const t = json(path.join(FREE_BIBLE, 'themes/en', f));
    const verses = t.sections.flatMap((s: any) => s.verses ?? []).map((v: any) => ({ bookId: v.bookId, chapter: v.chapter, verses: [v.verse, v.verseEnd ?? v.verse] }));
    items.push({ kind: 'theme', slug, page: `temaer/${slug}`, title: t.title, weight: 0.9, data: t, refs: passages(verses) });
  }
  for (const f of dir('persons/en')) {
    const p = json(path.join(FREE_BIBLE, 'persons/en', f));
    const events = p.keyEvents ?? [];
    const refs = passages(events.flatMap((e: any) => e.verses ?? []));
    if (!refs.length) refs.push(...(p.references ?? []).slice(0, 3).map((r: any) => ({ bookId: r.bookId, chapter: r.chapterId, verseStart: r.verseId, verseEnd: r.verseId })).filter(exists));
    items.push({ kind: 'person', slug: p.id, page: `personer/${p.id}`, title: p.name, weight: Math.min(events.length, 8) / 10, data: p, refs });
  }
  for (const f of dir('stories/en')) {
    const s = json(path.join(FREE_BIBLE, 'stories/en', f));
    if (!s.slug) continue;
    const refs: Ref[] = [];
    for (const r of s.references ?? []) {
      for (let c = r.startChapter; c <= r.endChapter && refs.length < 6; c++) {
        const last = chapterText(r.bookId, c).at(-1)?.verseId ?? 0;
        const ref = { bookId: r.bookId, chapter: c, verseStart: c === r.startChapter ? r.startVerse : 1, verseEnd: c === r.endChapter ? r.endVerse : last };
        if (exists(ref)) refs.push(ref);
      }
    }
    items.push({ kind: 'story', slug: s.slug, page: `historier/${s.slug}`, title: s.title, weight: Math.min(refs.reduce((n, r) => n + r.verseEnd - r.verseStart + 1, 0), 40) / 100, data: s, refs });
  }
  const seen = new Set<string>();
  for (const f of dir('daily_verse/en')) {
    for (const d of json(path.join(FREE_BIBLE, 'daily_verse/en', f)).verses) {
      const [b, c, v] = d.ref.split(':');
      const [start, end] = v.split('-').map(Number);
      const r = { bookId: Number(b), chapter: Number(c), verseStart: start, verseEnd: end ?? start };
      const key = `${r.bookId}:${r.chapter}:${r.verseStart}`;
      if (seen.has(key) || !exists(r)) continue;
      seen.add(key);
      items.push({ kind: 'verse', slug: key, page: `${urlSlug(BOOKS[r.bookId][0])}/${r.chapter}`, title: d.note, weight: 0.8, data: d, refs: [r] });
    }
  }
  const visits = popularity();
  const order = ['theme', 'verse', 'story', 'person'];
  return items
    .filter((i) => !has.has(key(i.kind, i.slug)) && i.refs.length)
    .map((i) => ({ ...i, weight: (visits.get(i.page) ?? 0) + i.weight }))
    .sort((a, b) => b.weight - a.weight || order.indexOf(a.kind) - order.indexOf(b.kind) || a.slug.localeCompare(b.slug));
}

/** The form an item's kind asks for, if it is in use, and the genre the catalog has least of among those that suit. */
function choose(item: Item, songs: any[]): { form?: string; genre: string } {
  const count = (g: string) => songs.filter((s) => s.tags.style[0] === g).length;
  const short = item.kind === 'verse' && item.refs[0].verseEnd - item.refs[0].verseStart <= 1;
  const wanted = item.kind === 'story' ? 'ballad' : short ? 'chant' : undefined;
  const form = wanted && FORMS_IN_USE.includes(wanted) ? wanted : undefined;
  const genres = Object.keys(GENRES).filter((g) => (form ? GENRES[g].includes(form) : true)
    && (g !== 'children' || item.kind === 'story' || item.kind === 'person'));
  const genre = genres.sort((a, b) => count(a) - count(b))[0];
  // A hymn or choral song about a theme, person or story is sung strophically when that form is in use; one verse
  // is too little text for four or five verses.
  const strophic = ['hymn', 'choral'].includes(genre) && item.kind !== 'verse' && FORMS_IN_USE.includes('strophic');
  return { form: form ?? (strophic ? 'strophic' : undefined), genre };
}

const FORM_RULES: Record<string, string> = {
  none: 'Verse-chorus: two or three [Verse] sections that move forward, a [Chorus] sung the same way each time it comes (two or three times), optionally a [Bridge] and an [Outro] of one or two lines.',
  strophic: 'Strophic, like a hymn: four or five [Verse] sections only, every verse with the same number of lines and the same meter (for example 8.6.8.6), no chorus or bridge; an [Outro] of one line is allowed.',
  ballad: 'A ballad: four to six [Verse] sections that tell the story in order, every verse with the same number of lines, each ending with the same short refrain line; no chorus, pre-chorus or bridge.',
  chant: 'A chant as in Taizé: one short text of two to four lines, sung six times as six identical [Verse] sections, then an [Outro] repeating one of its lines.',
  'call-response': 'Call and response: in every [Verse] each lead line is followed by the same short response line (at most 6 words; at most two different responses in the song), plus a [Chorus] sung the same way each time.',
};

const SCHEMA = {
  type: 'object',
  properties: {
    title: { type: 'string' },
    style: { type: 'string' },
    lyrics: { type: 'string' },
    sentiment: { type: 'array', items: { type: 'string', enum: ['comfort', 'praise', 'promise'] } },
    liturgy: { type: 'array', items: { type: 'string', enum: ['christmas', 'epiphany', 'funeral'] } },
    theme: { type: 'array', items: { type: 'string', enum: ['covenant', 'faith', 'holiness', 'love', 'mercy', 'obedience', 'salvation'] } },
    themes: { type: 'array', items: { type: 'string' } },
  },
  required: ['title', 'style', 'lyrics', 'sentiment', 'liturgy', 'theme', 'themes'],
};

function brief(item: Item): string {
  // A verse song gets the verses around it too, so the song has the passage's setting to draw on.
  const refs = item.kind === 'verse'
    ? item.refs.map((r) => ({ ...r, verseStart: Math.max(1, r.verseStart - 3), verseEnd: Math.min(chapterText(r.bookId, r.chapter).at(-1)!.verseId, r.verseEnd + 3) }))
    : item.refs;
  const text = refs.flatMap((r) => [`${label(r)}:`, ...verseText(r).map((v) => `${v.verseId} ${v.text}`)]).join('\n').slice(0, 6000);
  const d = item.data;
  const about = {
    theme: () => `The theme "${d.title}": ${d.introduction}\n${d.sections.map((s: any) => `- ${s.title}: ${s.description}`).join('\n')}`,
    person: () => `The person ${d.name}, ${d.title} (${d.lifespan ?? d.era}): ${d.summary}\n${(d.keyEvents ?? []).map((e: any) => `- ${e.title}: ${e.description}`).join('\n')}`,
    story: () => `The story "${d.title}": ${d.description}`,
    verse: () => `The verse ${label(item.refs[0])} (${d.note}); the song is about this verse, the others are its setting`,
  }[item.kind]();
  return `${about}\n\nThe Bible text (osen translation):\n${text}`;
}

async function write(item: Item, form: string | undefined, genre: string, themes: string[]): Promise<any> {
  const system = `You write English song lyrics for an AI singer, one song about a Bible ${item.kind}, for bible.flogvit.com.
The song tells what the Bible text says, faithfully: no events, names or claims the text does not give. Use concrete
pictures and words from the text; where you quote it, quote the osen text below word for word. Singable lines of 5
to 12 words, natural rhyme where it comes easily, 16 to 36 sung lines in all. Section tags on their own lines, a
blank line between sections; only [Verse], [Pre-Chorus], [Chorus], [Bridge] and [Outro]. Never write stage
directions, speaker names, parentheses or repeat marks: write every line that is sung.
Form: ${FORM_RULES[form ?? 'none']}
Title: short, a phrase from the chorus or refrain.
Style: one line for the music generator, in the genre "${genre}": the voice (gender, character, solo or with choir),
three to six instruments, the mood, and a tempo in BPM between 60 and 140, separated by commas. No artist names,
and do not start with "English".
Tags: sentiment and theme from their lists where they fit; liturgy only when the text is about Christmas
(christmas), the wise men or the baptism of Jesus (epiphany), or death and burial (funeral), else empty; themes: up
to three of ${themes.join(', ')}.`;
  let feedback = '';
  for (let attempt = 1; attempt <= 3; attempt++) {
    const r = await fetch(`${OLLAMA}/api/chat`, {
      timeout: false,
      method: 'POST',
      body: JSON.stringify({
        model: MODEL, stream: false, think: false, format: SCHEMA, keep_alive: 0,
        options: { temperature: 0.8, num_ctx: 16384 },
        messages: [{ role: 'system', content: system }, { role: 'user', content: brief(item) + feedback }],
      }),
    });
    if (!r.ok) throw new Error(`${MODEL}: ${r.status} ${await r.text()}`);
    const song = JSON.parse((await r.json() as { message: { content: string } }).message.content);
    song.lyrics = song.lyrics.trim().replace(/\n{3,}/g, '\n\n');
    const lines = song.lyrics.split('\n').filter((l: string) => l.trim() && !l.startsWith('['));
    const errors = [
      ...lyricsErrors(song.lyrics, 'mixed', form),
      ...(lines.length < 12 || lines.length > 48 ? [`${lines.length} sung lines; write 16 to 36`] : []),
      ...(/\(|\)|:\s*$/m.test(song.lyrics) ? ['no parentheses or speaker names'] : []),
      ...(!/\d+ BPM/.test(song.style) ? ['the style line needs a tempo as "<number> BPM"'] : []),
    ];
    if (!errors.length) return song;
    feedback = `\n\nYour last answer had these problems; write the song again without them:\n- ${errors.join('\n- ')}`;
    console.error(`  ${item.kind} ${item.slug}: attempt ${attempt}: ${errors.join('; ')}`);
  }
  throw new Error(`${item.kind} ${item.slug}: no valid lyrics in 3 attempts`);
}

export async function writeNext(count: number): Promise<string[]> {
  const songs = readdirSync(CATALOG).filter((f) => f.endsWith('.json')).map((f) => json(path.join(CATALOG, f)));
  let seed = Math.max(...songs.map((s) => s.request.seed)) + 1;
  const themes = dir('themes/en').map((f) => f.slice(0, -5));
  const persons = new Set(dir('persons/en').map((f) => f.slice(0, -5)));
  const written: string[] = [];
  for (const item of missing().slice(0, count)) {
    const { form, genre } = choose(item, songs);
    const slug = item.kind === 'verse' ? item.slug.replace(/:/g, '-') : item.slug;
    const id = `${item.kind}-${slug}-${genre}`;
    try {
      const s = await write(item, form, genre, themes);
      const anchor = item.kind === 'verse' ? item.refs[0] : { [item.kind]: item.slug };
      const related = item.kind === 'person' ? [item.slug, ...(item.data.relatedPersons ?? []).filter((p: string) => persons.has(p)).slice(0, 4)] : [];
      const song = {
        id, title: s.title.trim(), kind: item.kind, anchor, references: item.refs,
        tags: {
          style: [genre], sentiment: [...new Set(s.sentiment)], liturgy: [...new Set(s.liturgy)], theme: [...new Set(s.theme)],
          themes: [...new Set([...(item.kind === 'theme' ? [item.slug] : []), ...s.themes.filter((t: string) => themes.includes(t))])].slice(0, 4),
          stories: item.kind === 'story' ? [item.slug] : [], persons: related,
        },
        lyricsMode: item.kind === 'person' ? 'thematic' : 'mixed', textSource: 'osen', ...(form ? { form } : {}),
        request: { style: `English, ${s.style.replace(/^English,\s*/i, '').trim()}`, lyrics: s.lyrics, cot: 'full', seed: seed++ },
      };
      writeFileSync(path.join(CATALOG, `${id}.json`), JSON.stringify(song, null, 2) + '\n');
      appendFileSync(path.join(CATALOG, 'order.txt'), `${id}\n`);
      songs.push(song);
      written.push(id);
      console.log(`WROTE ${id}${form ? ` (${form})` : ''}: ${song.title}`);
    } catch (e) {
      console.error(`SKIPPED ${id}: ${e}`);
    }
  }
  return written;
}

if (import.meta.main) {
  const args = process.argv.slice(2);
  if (args.includes('--list')) {
    const all = missing();
    for (const i of all) console.log([i.weight.toFixed(2), i.kind.padEnd(6), i.slug.padEnd(40), i.title].join('  '));
    const by = (k: string) => all.filter((i) => i.kind === k).length;
    console.log(`${all.length} songs missing: ${by('theme')} themes, ${by('person')} persons, ${by('story')} stories, ${by('verse')} verses`);
  } else {
    const n = Number(args[args.indexOf('--count') + 1]) || 10;
    const written = await writeNext(args.includes('--count') ? n : 10);
    console.log(`${written.length} songs written`);
  }
}
