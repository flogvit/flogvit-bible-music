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
import { mkdirSync, readdirSync, readFileSync, writeFileSync, existsSync } from "node:fs";
import { hostname } from "node:os";
import { dirname, join } from "node:path";
import { parseArgs } from "node:util";
import { buildIndex, LEGACY_SOURCE, mergeSources, type MusicIndex, type Song, type Source } from "../lib/music";

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
  collections(): Promise<string[]>;
  /** The files directly under a folder, with a tag that changes whenever a file's content does. */
  list(folder: string): Promise<{ name: string; tag: string }[]>;
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
    async collections() {
      const list = await client.list({ prefix, delimiter: "/" });
      return (list.commonPrefixes ?? []).map((p) => p.prefix.slice(prefix.length).replace(/\/$/, ""));
    },
    async list(folder) {
      const list = await client.list({ prefix: `${prefix}${folder}/`, delimiter: "/" });
      return (list.contents ?? []).map((c) => ({ name: c.key.slice(prefix.length + folder.length + 1), tag: String(c.eTag ?? c.lastModified) }));
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
    async collections() {
      return existsSync(root) ? readdirSync(root, { withFileTypes: true }).filter((d) => d.isDirectory()).map((d) => d.name) : [];
    },
    async list(folder) {
      const path = join(root, folder);
      if (!existsSync(path)) return [];
      return readdirSync(path, { withFileTypes: true }).filter((d) => d.isFile())
        .map((d) => ({ name: d.name, tag: md5(readFileSync(join(path, d.name))) }));
    },
  };
}

const sink = opt.out ? dirSink(opt.out) : s3Sink();
const json = (value: unknown) => new TextEncoder().encode(JSON.stringify(value, null, 1) + "\n");
const songs: Song[] = [];
let written = 0;

for (const dir of readdirSync(opt.library!, { withFileTypes: true }).filter((d) => d.isDirectory()).map((d) => d.name).sort()) {
  const folder = join(opt.library!, dir);
  if (!existsSync(join(folder, "info.json")) || !existsSync(join(folder, "audio.mp3"))) continue;
  const info = JSON.parse(readFileSync(join(folder, "info.json"), "utf8"));
  const base = `${collection}/${info.id}`;
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
    music: info.music, files,
  });
}

// Several machines publish into the same collection, each with only its own songs in library/. Each one
// writes only its own list, <collection>/sources/<machine>.json, so no machine can drop another's songs;
// songs.json and index.json are rebuilt from all the lists. Songs published before there were lists are
// kept once as the legacy list.
const machine = (process.env.MUSIC_MACHINE ?? hostname()).toLowerCase().replace(/[^a-z0-9]+/g, "-").replace(/^-|-$/g, "");
const sources = `${collection}/sources`;
if (!(await sink.list(sources)).length && !opt["dry-run"]) {
  const before = await sink.read(`${collection}/songs.json`);
  if (before) await sink.put(`${sources}/${LEGACY_SOURCE}.json`, json(JSON.parse(before)), "application/json");
}
if (await sink.put(`${sources}/${machine}.json`, json(songs), "application/json")) written++;

/** Reads every machine's list of every collection, with the tags of the lists it read. */
async function readAll() {
  const all: Record<string, Song[]> = {};
  const tags: string[] = [];
  for (const name of new Set([collection, ...(await sink.collections())])) {
    const lists = (await sink.list(`${name}/sources`)).filter((f) => f.name.endsWith(".json"));
    if (!lists.length) {
      const text = await sink.read(`${name}/songs.json`); // a collection published before there were lists
      if (text) all[name] = JSON.parse(text);
      continue;
    }
    const read: Source[] = [];
    for (const f of lists) {
      const text = await sink.read(`${name}/sources/${f.name}`);
      if (text) read.push({ name: f.name.replace(/\.json$/, ""), songs: JSON.parse(text) });
      tags.push(`${name}/${f.name}:${f.tag}`);
    }
    if (opt["dry-run"] && name === collection) read.push({ name: machine, songs }); // what this run would write
    all[name] = mergeSources(read);
  }
  return { all, tags: tags.sort().join("\n") };
}

// Another machine may write its list between our read and our write of the index. So after writing, check
// whether any list changed since we read it, and rebuild if so: the last writer then always saw every list.
let index: MusicIndex;
for (let attempt = 1; ; attempt++) {
  const { all, tags } = await readAll();
  for (const [name, list] of Object.entries(all)) {
    if (await sink.put(`${name}/songs.json`, json(list), "application/json")) written++;
  }
  index = buildIndex(all);
  const previous = await sink.read("index.json");
  const unchanged = previous && JSON.stringify({ ...JSON.parse(previous), generated: "" }) === JSON.stringify({ ...index, generated: "" });
  if (!unchanged && await sink.put("index.json", json(index), "application/json")) written++;
  if (opt["dry-run"] || (await readAll()).tags === tags) break;
  if (attempt === 5) throw new Error("the song lists kept changing while publishing; run again");
}

const inCollection = index.songs.filter((s) => s.collection === collection).length;
console.log(`${opt["dry-run"] ? "would write" : "wrote"} ${written} files; ${songs.length} songs from here (${machine}), ` +
  `${inCollection} in ${collection}, ${index.songs.length} in the index (${index.collections.join(", ")})`);
