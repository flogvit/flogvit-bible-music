# Bible songs

Songs generated locally with [YuE2](https://github.com/multimodal-art-projection/YuE) (cloned in `YuE/`),
each linked to a verse, chapter, story, theme or person on bible.flogvit.com.

## Set up a new machine

Needs an Apple Silicon Mac with macOS 14 or later, [uv](https://docs.astral.sh/uv/) and [bun](https://bun.sh)
(`brew install uv oven-sh/bun/bun`). `YuE/` is not part of this repo (see `.gitignore`); it is the upstream
YuE2 code at a fixed commit plus `patches/yue2-mps.patch`.

```bash
git clone git@github.com:flogvit/flogvit-bible-music.git music
cd music
git clone https://github.com/multimodal-art-projection/YuE.git YuE
cd YuE
git checkout 1647252
git apply ../patches/yue2-mps.patch
uv venv --python 3.12 .venv
uv pip install --python .venv/bin/python .
.venv/bin/yue2 doctor
```

`doctor` should print `"torch": "2.14.1"` and `"mps_available": true`. If it says torch 2.10.0, the patch was
not applied: see below for why that matters.

The first generation downloads the model weights (YuE2-3B 6.8 GB, YuE2-Vae 0.5 GB) into the Hugging Face cache
(`~/.cache/huggingface`). No Hugging Face account is needed.

### What the patch changes

- `pyproject.toml` installs **torch 2.14.1 on macOS** (upstream pins 2.10.0 for everyone). torch 2.10's Apple GPU
  attention writes past its scratch buffers once the KV cache holds 1,024 keys (upstream issue #268): the
  output is wrong (cosine similarity 0.5–0.8 against the CPU result in our tests), the same seed gives different
  songs, and memory grows with every new cache length until macOS kills the process (past 100 GB on a
  six-minute song). torch 2.14.1 fixes all three without code changes, and the audio synthesis step runs about
  4× faster (84 s instead of 319 s for a 3:33 song). Other platforms keep 2.10.0.
- `examples/generate.py` uses `device="auto"` instead of `"cuda"`.

After editing anything under `YuE/`, reinstall with
`uv pip install --python .venv/bin/python --reinstall-package yue2-infer .` and refresh the patch with
`git -C YuE diff > patches/yue2-mps.patch`.

### Songs made with torch 2.10

Everything generated before 2026-10-28 16:20 ran on torch 2.10 and has the attention error described above,
including the audio behind the sheets in `sheets/`. Audio is not in the repo, so on a new machine generate the
whole catalog once and rebuild the sheets from it:

```bash
bun scripts/build-batch.ts YuE/requests/catalog.jsonl
cd YuE
.venv/bin/yue2 batch --input requests/catalog.jsonl --output outputs/catalog --config ../configs/long-12000.json --resume
cd ..
taskpolicy -b .venv-sheets/bin/python scripts/song-sheets.py YuE/outputs/catalog/*/
```

### Memory

A 6:53 song (Psalm 104 with `configs/long-12000.json`) peaked at 12 GB for the whole run, so a 64 GB Mac has
room to spare. Generation runs one song at a time; `yue2 batch` loads the model once for the whole batch.

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

Check new or changed songs before committing them:

```bash
bun scripts/validate-catalog.ts [song-id ...]
```

It checks the fields above, that every anchor and reference exists in the osen text, and that every tag, story,
person and theme exists in free-bible (looked up next to this repo, or at `$FREE_BIBLE`), so each song points
to a real page on bible.flogvit.com.

### Which machine makes which song

Audio is not in git, so `MACHINES.md` lists the songs each machine has taken, in the order it generates them,
and marks them done. Before generating, pull main and skip songs another machine has taken; add your own and
push before you start.

## Generate

```bash
bun scripts/build-batch.ts YuE/requests/<batch>.jsonl [song-id ...]
cd YuE
.venv/bin/yue2 batch --input requests/<batch>.jsonl --output outputs/<batch> --resume
```

Each song lands in `YuE/outputs/<batch>/<id>/audio.flac` with its score (`score.abc`).
`--resume` skips songs that are already finished, so an interrupted batch continues where it stopped.
On an M5 Max a 6:53 song took 12 minutes from request to audio. The GPU sits at 70–90% while the song's audio
tokens are generated (one token at a time, with a round-trip to the CPU for each) and at 100% during the audio
synthesis that follows; both are normal.

YuE2 stops a song at 9,000 audio tokens, about 6 minutes, and marks it `"semantic": true` under `truncated` in
`result.json`. For longer texts (whole long psalms), add `--config ../configs/long-12000.json`, which raises the
cap to 12,000 tokens (about 8 minutes); the model's context leaves room for that.

## Sheet music

`scripts/song-sheets.py` turns finished songs into something people can play and sing from:

```bash
taskpolicy -b .venv-sheets/bin/python scripts/song-sheets.py YuE/outputs/<batch>/<id> [...]
taskpolicy -b .venv-sheets/bin/python scripts/song-sheets.py YuE/outputs/*/*/   # every finished song
```

Each song gets a folder `sheets/<id>/`:

| file | what it is |
|---|---|
| `<id>-chords.pdf` | chord sheet on one page: the lyrics by section with the chords over the syllable where they change, intro and interludes as bars |
| `<id>-chords.cho` | the same in ChordPro, for chord-sheet apps |
| `<id>-lead-sheet.pdf` | lead sheet: the vocal melody with chords above and the lyrics under it, syllable by syllable |
| `<id>-lead-sheet.ly` | the LilyPond source of the lead sheet, to hand-edit and re-render with `lilypond <file>.ly` |
| `alignment.json` | where each syllable landed and how sure the placement is, per line |
| `whisper.json` | the Whisper transcription, kept so a rerun skips it |

Melody and chords come from `score.abc` (the score YuE2 generated the song from); the lyrics from `request.json`.
To put the words on the notes, Whisper `large-v3` (word timestamps, CPU) listens to `audio.flac`; a stretch it
mishears is listened to again with just those lines as the prompt. The script then finds how far the audio is
shifted from the score and lays the syllables on the vocal notes in order, one per note, with line starts on
phrase starts. Lines where Whisper heard too little, or heard them away from their notes, are printed in grey
italics on the lead sheet, and the note at the bottom of the sheet says how many there are. Slow songs that
YuE writes in 2/4 are printed in 4/4 when the chords change every other bar.

The first run of a song takes about 6 minutes (Whisper on the CPU, so the GPU stays free for YuE); a rerun with
`whisper.json` in place takes seconds. `taskpolicy -b` keeps it from slowing down a YuE batch.

When a song has been generated again, delete its old `whisper.json` and `alignment.json` first, or the new sheets
are aligned to what Whisper heard in the old audio.

On an M1 Max (two efficiency cores), run the sheets with `nice -n 20` instead of `taskpolicy -b` while a
`taskpolicy -b` YuE batch is running. Both background jobs land on the same two efficiency cores: Whisper then
takes 20 minutes per song and YuE drops from 7.5 to 2.5 tokens per second. With `nice -n 20`, Whisper runs on
the idle performance cores in about 2 minutes and YuE keeps its speed.

### Setup

```bash
brew install lilypond
uv venv --python 3.12 .venv-sheets
uv pip install --python .venv-sheets/bin/python faster-whisper weasyprint pyphen cmudict
```

WeasyPrint draws the chord sheet with Pango from Homebrew (`cairo` and `pango` formulae); the script points
macOS at `/opt/homebrew/lib` itself. The Whisper model (about 3 GB) downloads to the Hugging Face cache on
the first run.
