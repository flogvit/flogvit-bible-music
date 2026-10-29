/**
 * Publish the finished songs in library/ as a music collection: the MP3s, sheets and timing for each song,
 * the collection's songs.json, and a fresh index.json covering every collection on the host.
 *
 *   bun scripts/publish.ts                     # to the S3 bucket in .env
 *   bun scripts/publish.ts --out site/music    # to a local folder, for any static web host
 *   bun scripts/publish.ts --dry-run           # say what would change, change nothing
 *
 * Options: --library <dir> (default library), --collection <name> (default bible).
 *
 * S3 settings come from the environment (bun reads .env): S3_ENDPOINT, S3_REGION, S3_BUCKET, S3_ACCESS_KEY,
 * S3_SECRET_KEY, and MEDIA_PREFIX (default "system/music/"), the key prefix the public music tree lives under.
 * The FLAC masters go to masters/<collection>/<id>/audio.flac in the same bucket, private, in cold storage;
 * a local --out leaves them out.
 */
import { S3Client } from "bun";
import { createHash } from "node:crypto";
import { mkdirSync, readdirSync, readFileSync, statSync, writeFileSync, existsSync } from "node:fs";
import { dirname, join } from "node:path";
import { parseArgs } from "node:util";
import { buildIndex, type Song } from "../lib/music";

const { values: opt } = parseArgs({
  options: {
    library: { type: "string", default: "library" },
    collection: { type: "string", default: "bible" },
    out: { type: "string" },
    "dry-run": { type: "boolean", default: false },
  },
});
const collection = opt.collection!;
if (!/^[a-z0-9][a-z0-9-]*$/.test(collection)) throw new Error(`collection must be a lowercase slug: ${collection}`);

// The files a library song folder may have, and what they are called once published.
const PUBLIC: [string, keyof Song["files"], string][] = [
  ["audio.mp3", "mp3", "audio/mpeg"],
  ["alignment.json", "alignment", "application/json"],
  ["chords.pdf", "chordSheet", "application/pdf"],
  ["chords.cho", "chordPro", "text/plain; charset=utf-8"],
  ["leadsheet.pdf", "leadSheet", "application/pdf"],
];

interface Sink {
  /** Writes the file unless an identical one is already there; returns whether it wrote. */
  put(key: string, body: Uint8Array, type: string, options?: { cold?: boolean }): Promise<boolean>;
  read(key: string): Promise<string | null>;
  /** When the file was last written (ISO 8601), or null when it is not there. */
  modified(key: string): Promise<string | null>;
  collections(): Promise<string[]>;
}

const md5 = (b: Uint8Array) => createHash("md5").update(b).digest("hex");

function s3Sink(): Sink {
  const need = ["S3_ENDPOINT", "S3_REGION", "S3_BUCKET", "S3_ACCESS_KEY", "S3_SECRET_KEY"];
  const missing = need.filter((k) => !process.env[k]);
  if (missing.length) throw new Error(`missing ${missing.join(", ")} (put them in .env, or use --out <dir>)`);
  const client = new S3Client({
    endpoint: process.env.S3_ENDPOINT, region: process.env.S3_REGION, bucket: process.env.S3_BUCKET,
    accessKeyId: process.env.S3_ACCESS_KEY, secretAccessKey: process.env.S3_SECRET_KEY,
  });
  const prefix = process.env.MEDIA_PREFIX ?? "system/music/";
  return {
    async put(key, body, type, options = {}) {
      const full = options.cold ? key : prefix + key;
      const stat = await client.stat(full).catch(() => null);
      if (stat && stat.etag.replaceAll('"', "") === md5(body)) return false;
      if (!opt["dry-run"]) {
        await client.write(full, body, {
          type, acl: options.cold ? "private" : "public-read",
          ...(options.cold ? { storageClass: "GLACIER" as const } : {}),
        });
      }
      return true;
    },
    async read(key) {
      const file = client.file(prefix + key);
      return (await file.exists()) ? await file.text() : null;
    },
    async modified(key) {
      const stat = await client.stat(prefix + key).catch(() => null);
      return stat ? stat.lastModified.toISOString() : null;
    },
    async collections() {
      const list = await client.list({ prefix, delimiter: "/" });
      return (list.commonPrefixes ?? []).map((p) => p.prefix.slice(prefix.length).replace(/\/$/, ""));
    },
  };
}

function dirSink(root: string): Sink {
  return {
    async put(key, body) {
      const path = join(root, key);
      if (existsSync(path) && md5(readFileSync(path)) === md5(body)) return false;
      if (!opt["dry-run"]) {
        mkdirSync(dirname(path), { recursive: true });
        writeFileSync(path, body);
      }
      return true;
    },
    async read(key) {
      const path = join(root, key);
      return existsSync(path) ? readFileSync(path, "utf8") : null;
    },
    async modified(key) {
      const path = join(root, key);
      return existsSync(path) ? statSync(path).mtime.toISOString() : null;
    },
    async collections() {
      return existsSync(root) ? readdirSync(root, { withFileTypes: true }).filter((d) => d.isDirectory()).map((d) => d.name) : [];
    },
  };
}

const sink = opt.out ? dirSink(opt.out) : s3Sink();
const json = (value: unknown) => new TextEncoder().encode(JSON.stringify(value, null, 1) + "\n");
const songs: Song[] = [];
let written = 0;
const now = new Date().toISOString();

// What the collection already has, published from here or from other machines.
const published: Song[] = JSON.parse((await sink.read(`${collection}/songs.json`)) ?? "[]");
const before = new Map(published.map((s) => [s.id, s]));
// A song keeps the date it first came out. One published before songs had dates gets the time its MP3
// landed, read before this run can write the MP3 again.
const firstOut = async (s: Pick<Song, "id" | "collection">) =>
  before.get(s.id)?.published ?? (await sink.modified(`${s.collection}/${s.id}/audio.mp3`)) ?? now;

for (const dir of readdirSync(opt.library!, { withFileTypes: true }).filter((d) => d.isDirectory()).map((d) => d.name).sort()) {
  const folder = join(opt.library!, dir);
  if (!existsSync(join(folder, "info.json")) || !existsSync(join(folder, "audio.mp3"))) continue;
  const info = JSON.parse(readFileSync(join(folder, "info.json"), "utf8"));
  const base = `${collection}/${info.id}`;
  const out = await firstOut({ id: info.id, collection });
  const files = { info: `${base}/info.json` } as Song["files"];
  for (const [name, field, type] of PUBLIC) {
    if (!existsSync(join(folder, name))) continue;
    let body: Uint8Array = readFileSync(join(folder, name));
    if (name === "alignment.json") {
      const alignment = JSON.parse(new TextDecoder().decode(body));
      delete alignment.song; // the song folder on the publisher's disk
      body = json(alignment);
    }
    if (await sink.put(`${base}/${name}`, body, type)) written++;
    files[field] = `${base}/${name}`;
  }
  if (!opt.out && existsSync(join(folder, "audio.flac"))) {
    if (await sink.put(`masters/${base}/audio.flac`, readFileSync(join(folder, "audio.flac")), "audio/flac", { cold: true })) written++;
  }
  // Where the song was made on the publisher's disk is nobody else's business.
  if (info.generated) delete info.generated.source;
  info.collection = collection;
  info.files = Object.fromEntries(Object.entries(files).map(([k, v]) => [k, v.slice(base.length + 1)]));
  if (await sink.put(`${base}/info.json`, json(info), "application/json")) written++;
  songs.push({
    id: info.id, collection, title: info.title, kind: info.kind, anchor: info.anchor, references: info.references ?? [],
    style: info.style ?? [], styleDescription: info.styleDescription, tags: info.tags ?? {},
    lyrics: info.lyrics?.text, lyricsMode: info.lyricsMode, textSource: info.textSource, textCredit: info.textCredit,
    music: info.music, published: out, files,
  });
}

// Several machines publish into the same collection, each with only its own songs in library/: keep the
// songs already published from elsewhere, and let this machine's copy win for the songs it has.
const local = new Set(songs.map((s) => s.id));
const others = await Promise.all(published.filter((s) => !local.has(s.id)).map(async (s) => ({ ...s, published: await firstOut(s) })));
const merged = [...others, ...songs].sort((a, b) => a.id.localeCompare(b.id));
if (await sink.put(`${collection}/songs.json`, json(merged), "application/json")) written++;

// The index covers every collection on the host, not just this one.
const all: Record<string, Song[]> = { [collection]: merged };
for (const name of await sink.collections()) {
  if (name === collection) continue;
  const text = await sink.read(`${name}/songs.json`);
  if (text) all[name] = JSON.parse(text);
}
const index = buildIndex(all);
const previous = await sink.read("index.json");
const unchanged = previous && JSON.stringify({ ...JSON.parse(previous), generated: "" }) === JSON.stringify({ ...index, generated: "" });
if (!unchanged && await sink.put("index.json", json(index), "application/json")) written++;

console.log(`${opt["dry-run"] ? "would write" : "wrote"} ${written} files; ${songs.length} songs from here, ` +
  `${merged.length} in ${collection}, ${index.songs.length} in the index (${index.collections.join(", ")})`);
