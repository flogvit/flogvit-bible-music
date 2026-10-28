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

### Setup

```bash
brew install lilypond
uv venv --python 3.12 .venv-sheets
uv pip install --python .venv-sheets/bin/python faster-whisper weasyprint pyphen cmudict
```

WeasyPrint draws the chord sheet with Pango from Homebrew (`cairo` and `pango` formulae); the script points
macOS at `/opt/homebrew/lib` itself. The Whisper model (about 3 GB) downloads to the Hugging Face cache on
the first run.

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

`patches/yue2-mps.patch` holds the local changes to upstream that make YuE2 correct and lean on
Apple GPUs:

- `examples/generate.py` uses `device="auto"` instead of `"cuda"`.
- `src/yue2/modeling_yue2.py` and `src/yue2/nar.py` use native grouped-query attention instead of
  copying K/V with `repeat_interleave` on MPS.
- Each decode step attends over the KV cache padded to a multiple of 512 with a mask
  (`StaticKVCache.bucketed`). On MPS, attention over a slice of the cache without a mask returns
  wrong values (cosine similarity 0.5–0.8 against the CPU result in tests), and a new key length
  every step made the process grow past 100 GB on a six-minute song. With the change a 6:34 song
  peaks at 21 GB.

After editing `src/`, reinstall with `uv pip install --python .venv/bin/python --reinstall-package yue2-infer .`
and refresh the patch with `git -C YuE diff > patches/yue2-mps.patch`.

Model weights download from Hugging Face on first run, into the Hugging Face cache.
