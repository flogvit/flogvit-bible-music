# Bible songs

Songs generated locally with [YuE2](https://github.com/multimodal-art-projection/YuE) (cloned in `YuE/`),
each linked to a verse, chapter, story, theme or person on bible.flogvit.com.

## Catalog

One file per song in `catalog/<id>.json`:

| field | meaning |
|---|---|
| `kind` | `verse`, `chapter`, `story`, `theme` or `person` |
| `anchor` | what the song is about: `{bookId, chapter, verseStart, verseEnd}`, `{bookId, chapter}`, `{story}`, `{theme}` or `{person}` |
| `references` | every passage the song draws on, in the same shape as `free-bible/generate/songs/*.json` |
| `tags.style` | musical style (folk, soul, children, country, celtic, gospel, …) |
| `tags.sentiment`, `tags.liturgy`, `tags.theme` | ids from `free-bible/generate/tags/en/<category>/` |
| `tags.themes`, `tags.stories`, `tags.persons` | slugs from `free-bible/generate/{themes,stories,persons}/en/` |
| `lyricsMode` | `verbatim`, `mixed` (quotes the verse) or `thematic` |
| `textSource` | `osen`; quotes come from `free-bible/generate/bibles_raw/osen` (CC BY 4.0, credit SBLGNT and tanach.us) |
| `request` | what YuE2 gets: `style`, `lyrics`, `cot`, `seed` |

## Generate

```bash
bun scripts/build-batch.ts YuE/requests/<batch>.jsonl [song-id ...]
cd YuE
.venv/bin/yue2 batch --input requests/<batch>.jsonl --output outputs/<batch> --resume
```

Each song lands in `YuE/outputs/<batch>/<id>/audio.flac` with its score (`score.abc`).
`--resume` skips songs that are already finished, so an interrupted batch continues where it stopped.
A song takes 6–12 minutes on the M5 Max (Apple GPU).

## YuE2 setup

`YuE/` is not part of this repo (see `.gitignore`). On a new machine, from the repo root:

```bash
git clone https://github.com/multimodal-art-projection/YuE.git YuE
cd YuE
git checkout 1647252
git apply ../patches/yue2-mps.patch
uv venv --python 3.12 .venv
uv pip install --python .venv/bin/python .
```

`patches/yue2-mps.patch` holds the two local changes to upstream: `examples/generate.py` uses
`device="auto"`, and `src/yue2/sampling.py` empties the MPS cache every 500 tokens (without it,
songs past ~6000 tokens, about 4 minutes, are killed by macOS when memory runs out). After editing
`src/`, reinstall with `uv pip install --python .venv/bin/python --reinstall-package yue2-infer .`
and refresh the patch with `git -C YuE diff > patches/yue2-mps.patch`.

Model weights download from Hugging Face on first run, into the Hugging Face cache.

## Files that live in the YuE clone

Some request files sit in `YuE/requests/` and are not in this repo:

- `pilot.jsonl`: built from `catalog/` by `scripts/build-batch.ts`; rebuild it rather than copy it.
- `john316-gospel.json` and `jeremiah2911-gospel.json`: single Bible songs written by hand before
  the catalog existed. They belong here; move them into `catalog/` (with anchor and tags) to keep them.
- `grensesnitt-*.json` and the melodies they use in `YuE/edits/*.abc` are unrelated to the Bible
  songs and stay in the clone.
