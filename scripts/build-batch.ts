#!/usr/bin/env bun
/**
 * Turn catalog/*.json songs into a JSONL batch for `yue2 batch`.
 *
 * Usage: bun scripts/build-batch.ts <output.jsonl> [song-id ...]
 * Without ids, every catalog song is included; `yue2 batch --resume` skips finished ones.
 * With ids, the batch keeps their order.
 */
import { readdirSync, readFileSync, writeFileSync } from 'fs';
import path from 'path';

const root = path.join(import.meta.dir, '..');
const [output, ...ids] = process.argv.slice(2);
if (!output) {
  console.error('Usage: bun scripts/build-batch.ts <output.jsonl> [song-id ...]');
  process.exit(1);
}

const catalog = path.join(root, 'catalog');
const songs = readdirSync(catalog)
  .filter((f) => f.endsWith('.json'))
  .map((f) => JSON.parse(readFileSync(path.join(catalog, f), 'utf8')))
  .filter((s) => ids.length === 0 || ids.includes(s.id))
  .sort((a, b) => ids.indexOf(a.id) - ids.indexOf(b.id));
const missing = ids.filter((id) => !songs.some((s) => s.id === id));
if (missing.length) {
  console.error(`Not in catalog: ${missing.join(', ')}`);
  process.exit(1);
}

const lines = songs.map((s) => JSON.stringify({ id: s.id, ...s.request }));
writeFileSync(output, lines.join('\n') + '\n');
console.log(`${lines.length} songs → ${output}`);
