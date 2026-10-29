/**
 * Search a published music index.
 *
 *   bun scripts/search.ts bread                         # words in title, lyrics, style, passages, tags
 *   bun scripts/search.ts --verse "John 6:35"           # songs on a passage that includes the verse
 *   bun scripts/search.ts --theme salvation --style worship
 *   bun scripts/search.ts --index site/music/index.json --story nehemjas-mur
 *
 * Other filters: --collection, --kind, --sentiment, --liturgy, --person. --json prints the matching songs as
 * JSON with absolute file URLs. The index defaults to https://media.flogvit.com/music/index.json.
 */
import { readFileSync } from "node:fs";
import { parseArgs } from "node:util";
import { search, type MusicIndex, type Query } from "../lib/music";

const filters = ["verse", "collection", "kind", "style", "sentiment", "liturgy", "theme", "story", "person"] as const;
const { values, positionals } = parseArgs({
  allowPositionals: true,
  options: {
    index: { type: "string", default: "https://media.flogvit.com/music/index.json" },
    json: { type: "boolean", default: false },
    ...Object.fromEntries(filters.map((f) => [f, { type: "string" as const }])),
  },
});

const location = values.index as string;
const remote = /^https?:\/\//.test(location);
const index: MusicIndex = remote ? await (await fetch(location)).json() : JSON.parse(readFileSync(location, "utf8"));
const base = remote ? location : new URL(location, `file://${process.cwd()}/`).href;

const query: Query = { text: positionals.join(" ") || undefined };
for (const f of filters) if (values[f]) query[f] = values[f] as string;
const songs = search(index, query);

if (values.json) {
  const absolute = songs.map((s) => ({
    ...s, files: Object.fromEntries(Object.entries(s.files).map(([k, v]) => [k, new URL(v, base).href])),
  }));
  console.log(JSON.stringify(absolute, null, 1));
} else {
  for (const s of songs) {
    const where = s.references.map((r) => r.label).filter(Boolean).join("; ");
    console.log(`${s.title}  [${s.collection} · ${s.style.join(", ")}]  ${where}\n  ${new URL(s.files.mp3, base).href}`);
  }
  console.log(`${songs.length} of ${index.songs.length} songs`);
}
