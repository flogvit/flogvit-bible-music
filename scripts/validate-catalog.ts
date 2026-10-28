#!/usr/bin/env bun
/**
 * Check catalog/*.json against the README: required fields, anchors and references that exist in the osen
 * text, and tags that exist in free-bible, so every song points to a real page on bible.flogvit.com.
 *
 * Usage: bun scripts/validate-catalog.ts [song-id ...]
 * free-bible is looked up next to this repo, or at $FREE_BIBLE.
 * Exits 1 if any song has an error.
 */
import { existsSync, readdirSync, readFileSync } from 'fs';
import path from 'path';

const root = path.join(import.meta.dir, '..');
const freeBible = process.env.FREE_BIBLE ?? path.join(root, '..', 'free-bible');
const generate = path.join(freeBible, 'generate');
if (!existsSync(generate)) {
  console.error(`free-bible not found at ${freeBible}; set FREE_BIBLE`);
  process.exit(1);
}

const KINDS = ['verse', 'chapter', 'story', 'theme', 'person'];
const LYRICS_MODES = ['verbatim', 'mixed', 'thematic'];
const TEXT_SOURCES = ['osen', 'kjv'];
const COT = ['full', 'melody', 'off'];
const SECTION = /^\[(Intro|Verse|Pre-Chorus|Chorus|Bridge|Outro|Interlude|Refrain|Hook|Break|Instrumental)\]$/;

const slugs = (dir: string) =>
  new Set(readdirSync(path.join(generate, dir)).filter((f) => f.endsWith('.json')).map((f) => f.slice(0, -5)));
const tagIds = {
  sentiment: slugs('tags/en/sentiment'),
  liturgy: slugs('tags/en/liturgy'),
  theme: slugs('tags/en/theme'),
  themes: slugs('themes/en'),
  stories: slugs('stories/en'),
  persons: slugs('persons/en'),
};

const chapters = new Map<string, Set<number> | null>();
function versesOf(bookId: number, chapter: number): Set<number> | null {
  const key = `${bookId}/${chapter}`;
  if (!chapters.has(key)) {
    const file = path.join(generate, 'bibles_raw', 'osen', String(bookId), `${chapter}.json`);
    chapters.set(key, existsSync(file) ? new Set(JSON.parse(readFileSync(file, 'utf8')).map((v: any) => v.verseId)) : null);
  }
  return chapters.get(key)!;
}

function checkPassage(p: any, where: string, errors: string[], needVerses: boolean) {
  if (!Number.isInteger(p?.bookId) || !Number.isInteger(p?.chapter)) {
    errors.push(`${where}: needs integer bookId and chapter`);
    return;
  }
  const verses = versesOf(p.bookId, p.chapter);
  if (!verses) {
    errors.push(`${where}: ${p.bookId}:${p.chapter} is not in osen`);
    return;
  }
  if (!needVerses && p.verseStart === undefined && p.verseEnd === undefined) return;
  if (!Number.isInteger(p.verseStart) || !Number.isInteger(p.verseEnd) || p.verseEnd < p.verseStart) {
    errors.push(`${where}: needs verseStart <= verseEnd`);
    return;
  }
  for (const v of [p.verseStart, p.verseEnd]) {
    if (!verses.has(v)) errors.push(`${where}: verse ${p.bookId}:${p.chapter}:${v} is not in osen`);
  }
}

const catalog = path.join(root, 'catalog');
const ids = process.argv.slice(2);
const files = readdirSync(catalog).filter((f) => f.endsWith('.json'));
const songs = files.map((f) => ({ file: f, song: JSON.parse(readFileSync(path.join(catalog, f), 'utf8')) }));

const seeds = new Map<number, string>();
for (const { song } of songs) {
  if (Number.isInteger(song.request?.seed)) {
    const other = seeds.get(song.request.seed);
    if (other && other !== song.id) console.warn(`warning: ${song.id} shares seed ${song.request.seed} with ${other}`);
    seeds.set(song.request.seed, song.id);
  }
}

let failed = 0;
for (const { file, song: s } of songs) {
  if (ids.length && !ids.includes(s.id)) continue;
  const errors: string[] = [];
  if (`${s.id}.json` !== file) errors.push(`id ${s.id} does not match file name`);
  if (typeof s.title !== 'string' || !s.title.trim()) errors.push('title missing');
  if (!KINDS.includes(s.kind)) errors.push(`kind must be one of ${KINDS.join(', ')}`);
  if (typeof s.id === 'string' && !s.id.startsWith(`${s.kind}-`)) errors.push(`id should start with "${s.kind}-"`);

  const a = s.anchor ?? {};
  if (s.kind === 'verse') checkPassage(a, 'anchor', errors, true);
  if (s.kind === 'chapter') {
    checkPassage(a, 'anchor', errors, false);
    if ('verseStart' in a) errors.push('anchor: a chapter song has no verses');
  }
  for (const [kind, key, set] of [
    ['story', 'story', tagIds.stories],
    ['theme', 'theme', tagIds.themes],
    ['person', 'person', tagIds.persons],
  ] as const) {
    if (s.kind === kind && !set.has(a[key])) errors.push(`anchor.${key} "${a[key]}" is not in free-bible`);
  }

  if (!Array.isArray(s.references) || s.references.length === 0) errors.push('references missing');
  else s.references.forEach((r: any, i: number) => checkPassage(r, `references[${i}]`, errors, true));

  const t = s.tags ?? {};
  if (!Array.isArray(t.style) || t.style.length === 0) errors.push('tags.style missing');
  for (const key of Object.keys(tagIds) as (keyof typeof tagIds)[]) {
    if (!Array.isArray(t[key])) {
      errors.push(`tags.${key} must be a list`);
      continue;
    }
    for (const v of t[key]) if (!tagIds[key].has(v)) errors.push(`tags.${key} "${v}" is not in free-bible`);
  }
  if (s.kind === 'story' && !t.stories?.includes(a.story)) errors.push('tags.stories should include the anchor story');
  if (s.kind === 'person' && !t.persons?.includes(a.person)) errors.push('tags.persons should include the anchor person');
  if (s.kind === 'theme' && !t.themes?.includes(a.theme)) errors.push('tags.themes should include the anchor theme');

  if (!LYRICS_MODES.includes(s.lyricsMode)) errors.push(`lyricsMode must be one of ${LYRICS_MODES.join(', ')}`);
  if (!TEXT_SOURCES.includes(s.textSource)) errors.push(`textSource must be one of ${TEXT_SOURCES.join(', ')}`);

  const r = s.request ?? {};
  if (typeof r.style !== 'string' || !r.style.startsWith('English')) errors.push('request.style must start with "English"');
  if (!COT.includes(r.cot)) errors.push(`request.cot must be one of ${COT.join(', ')}`);
  if (!Number.isInteger(r.seed)) errors.push('request.seed must be an integer');
  if (typeof r.lyrics !== 'string' || !r.lyrics.trim()) errors.push('request.lyrics missing');
  else {
    const lines = r.lyrics.split('\n');
    if (!SECTION.test(lines[0])) errors.push('request.lyrics must start with a section tag such as [Verse]');
    const tags = lines.filter((l: string) => l.startsWith('['));
    for (const l of tags) if (!SECTION.test(l)) errors.push(`request.lyrics: unknown section tag ${l}`);
    if (!tags.some((l: string) => /Chorus|Refrain/.test(l)) && s.lyricsMode !== 'verbatim')
      errors.push('request.lyrics has no [Chorus]');
  }

  if (errors.length) {
    failed++;
    console.log(`${s.id ?? file}:\n  ${errors.join('\n  ')}`);
  }
}
const checked = ids.length ? ids.length : songs.length;
console.log(failed ? `${failed} of ${checked} songs have errors` : `${checked} songs OK`);
process.exit(failed ? 1 : 0);
