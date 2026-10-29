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

The lyrics check needs [Ollama](https://ollama.com) running (`brew install --cask ollama`, then open it once).
`scripts/generate.ts run` pulls the judge model (`qwen3.8:27b`, 17 GB) the first time, and does not start
without it.

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
including the audio behind the sheets in `sheets/`. `scripts/generate.ts run` (see Generate) does not count
such songs as done and makes them again.

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

`catalog/order.txt` is the order the catalog is generated in, most-known songs first. Add new songs to it where
they belong; a catalog song missing from it comes after the listed ones.

## Generate

### The whole catalog, on one or more machines

```bash
MUSIC_MACHINE="Home Mac (M1 Max, 64 GB)" bun scripts/generate.ts run              # from the top of catalog/order.txt
MUSIC_MACHINE="M5 (MacBook Pro, M5 Max, 128 GB)" bun scripts/generate.ts run --from-end
bun scripts/generate.ts status                                                     # every song: done, generating, stale or free
```

`run` takes the next free song, generates it with `configs/long-12000.json` under `taskpolicy -b`, checks that
the singing delivers its lyrics (see Lyrics check), makes its sheets and `library/<id>/`, commits the sheets and pushes them to the current branch (or `$MUSIC_SHEETS_BRANCH`),
marks the song done and takes the next one, until no song is free. It can run from a worktree; `YuE/`,
`.venv-sheets` and `library/` are found in the main checkout. Before it takes new songs, it finishes the songs
already made on this machine (sheets and library if they are missing) and marks them done. Its log goes to the
terminal, and each song's own output to `YuE/outputs/catalog/<id>-run.log`. Stop it with Ctrl-C (or `kill`):
the song it was making is given back at once.

Two machines never make the same song, also when they are on different networks and ask at the same moment.
Each song has a lock on GitHub, the ref `refs/claims/<id>`: a chain of empty commits whose subject is the
state (`claimed`, `alive`, `done`, `failed`, `released`), whose body names the machine, and whose date is the
last sign of life. A machine takes a song by pushing a commit to that ref without force, built on what it saw
there (nothing, or a lock that is released, failed or stale). GitHub updates the ref only if it is still
unchanged, so when two machines push at once, one gets `reference already exists` or `cannot lock ref` and
moves on to the next song. While a song generates, its machine adds an `alive` commit every minute. A lock
with no sign of life for 20 minutes (a machine that died, slept or lost the network) is free again; if its
machine comes back, its next `alive` push is rejected and it stops that song. A failed song is given back for
other machines to try. The refs are outside branches and tags, so they do not show up in `main`:

```bash
git ls-remote origin 'refs/claims/*'
git fetch origin '+refs/claims/*:refs/claims/*' && git log --format='%ci %s (%b)' refs/claims/<id>
```

To keep a machine generating without a terminal, run it as a launchd agent, from a worktree of its own:

```bash
git worktree add -b <machine>-generate .claude/worktrees/generate origin/main
cd .claude/worktrees/generate
MUSIC_MACHINE="M5 (MacBook Pro, M5 Max, 128 GB)" scripts/install-generator.sh --from-end
tail -f ~/Library/Logs/music-generate.log
```

The agent `com.flogvit.music-generate` starts at login and again 10 minutes after `run` stops, so a restart,
a crash or a run that found no free song does not stop the machine for good. While a song generates, the Mac
does not sleep on power (`caffeinate -s`); on battery it may, and after 20 minutes asleep the song is free for
others. Without network, `run` waits and tries again every minute. Turn it off with
`scripts/install-generator.sh --uninstall`, which gives the song it was making back. Started from a terminal or
an agent session instead, `run` dies with that terminal or session.

### Lyrics check

YuE sometimes sings a line twice where the lyrics ask for two different lines, drops or merges a line, or
garbles the words. Every song is checked before it gets its sheets, and only a song that passes is published.

1. Whisper listens to the song (`song-sheets.py --listen-only`, which writes `sheets/<id>/whisper.json`; the
   sheets reuse it afterwards, so Whisper runs once per song).
2. `scripts/lyrics-check.ts` gives a local LLM the requested lyrics with their sections (`[Verse]`,
   `[Chorus]`, …) and the phrases Whisper heard, with times. It answers `correct`, `wrong` or `unsure`, with each
   problem and when it is heard. Wrong or garbled words, a missing line, two lines merged, and a line or verse
   sung more often than the structure asks for are wrong. A chorus the lyrics repeat, a hook echoed at the end,
   wordless vocals, and Whisper's own near-misses (*this* for *theirs*) are fine.
3. Only `correct` with no problems passes. Anything else, `unsure` too, rejects the song: its audio moves to
   `YuE/outputs/catalog/<id>-rejected-<n>/` (with `whisper.json` and the verdict in `lyrics-check.json`), its
   lock gets the state `rejected`, and the next free machine makes it again with the next seed (the same seed
   would make the same song).
4. After 3 rejections, the song is set aside: its lock gets `done <id> (set aside)`, so no machine takes it
   again, also not one running an older `generate.ts`. `aside/<id>.json` lists each attempt's seed, folder
   and verdict. The run goes on with the next song, and the song stays aside until someone runs `retry`.

The attempts are counted in the song's own lock on GitHub: each rejection is a `rejected` commit in
`refs/claims/<id>`, the same ref every attempt and every machine builds on. A restart, another machine or a new
session therefore goes on counting from where it was. Without network, a rejection is pushed again every
minute until GitHub has it, and a run also counts the rejections it made itself, so it stops at 3 even if
GitHub missed one. `retry` adds a `retry` commit; rejections before it no longer count.

```bash
ls aside/                                       # songs set aside
bun scripts/generate.ts retry <id>              # put one back, for 3 more attempts
bun scripts/lyrics-check.ts <id>                # judge sheets/<id>/whisper.json now (exit 0 = passes)
bun test scripts                                # the judge on a real doubled chorus line and a real chorus
```

`MUSIC_MAX_ATTEMPTS` sets the number of attempts (default 3), and `MUSIC_JUDGE_MODEL` the Ollama model
(default `qwen3.8:27b`). For the launchd agent, add them to `EnvironmentVariables` in
`~/Library/LaunchAgents/com.flogvit.music-generate.plist` and install it again. The judge takes about a minute per song
on an M5 Max. Ollama unloads the model after each song, so YuE gets the memory back. The judge runs in Ollama's
own process, so `taskpolicy -b` does not reach it.

### Single songs or your own batch

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

## Listening app

`player/` is a small native Mac app, Bibelsanger, for listening to the songs in a loop:

```bash
player/build.sh --install     # builds and installs ~/Applications/Bibelsanger.app (needs Xcode)
```

It lists the songs in `library/` on this Mac, then the songs on media.flogvit.com that are not on this Mac
(made on another machine), streamed from there. New songs appear on their own: it looks at `library/` every
15 s and at media.flogvit.com every 5 minutes. Double-click a song to play it; the list as shown (search included) plays in a loop. The bar at the
bottom has shuffle and repeat all / one / off, and the Mac's media keys work. The right side shows the
song's lyrics, its Bible passages (linked to bible.flogvit.com) and its chord and lead sheets. The app
looks for the repo at `~/WebstormProjects/flogvit/music`; pick another folder with ⌘O.

While a song plays, the line being sung lights up and its syllables fill in as they are sung; the lyrics
scroll along, and clicking a line jumps there. The timing comes from the song's `alignment.json` (made by
`scripts/song-sheets.py`), read from `library/<id>/` or else `sheets/<id>/`, or fetched from media.flogvit.com. Lines the sheets mark as
uncertain light up as a whole line; songs without sheets show plain lyrics.

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

## Library

`library/<id>/` holds everything about one finished song in one place: the audio, both sheets, the
syllable timing (`alignment.json`, which the Bibelsanger app uses to light up the words as they are sung)
and an `info.json` with the song's text, tags, links and how it was made. It sits next to `YuE/` and is not in git.

### Build it

`scripts/generate.ts run` does this for each song it makes. By hand, after a song's sheets are made, run on
the machine that generated it:

```bash
MUSIC_MACHINE="Home Mac (M1 Max, 64 GB)" python3 scripts/build-library.py YuE/outputs/<batch>/<id> [...]
MUSIC_MACHINE="..." python3 scripts/build-library.py YuE/outputs/*/*/   # every finished song
```

It needs `ffmpeg` (`brew install ffmpeg`) and free-bible next to this repo (or `$FREE_BIBLE`) for the titles of
stories, persons and themes. A song without sheets is reported and skipped. Running it again replaces the
folder's files, so rebuild after regenerating a song or its sheets.

### What is in a folder

| file | what it is |
|---|---|
| `audio.flac` | the song as YuE2 made it, 48 kHz (a hard link to the file in `YuE/outputs/`, so it takes no extra space) |
| `audio.mp3` | the same as MP3, LAME V0 (about 240 kbit/s), tagged with title, genre and the passage with its link |
| `chords.pdf`, `chords.cho` | the chord sheet, as PDF and ChordPro (see Sheet music) |
| `leadsheet.pdf` | the lead sheet: melody with chords and lyrics |
| `alignment.json` | when each syllable is sung (from the sheets), for highlighting the lyrics |
| `info.json` | everything about the song, below |

### info.json

| field | meaning |
|---|---|
| `id`, `title`, `kind` | from the catalog |
| `anchor`, `url` | what the song is about, with a readable `label` (`Joshua 1:9`, `David and Goliath`) and its page on bible.flogvit.com |
| `references` | every passage the song draws on, each with `label` and `url` |
| `style`, `styleDescription` | the genre tags, and the style line YuE2 got |
| `tags` | `sentiment`, `liturgy` and `theme` ids, and `themes`, `stories`, `persons` as `{slug, title, url}` (persons also have `epithet`) |
| `lyrics` | `sections` (`[{section, lines}]`) and the full `text` as YuE2 got it |
| `lyricsMode`, `textSource`, `textCredit` | how the lyrics use the Bible text, and the credit line for that translation |
| `music` | `duration`, `durationSeconds`, and `key`, `meter`, `bpm` from YuE2's score |
| `seed` | the seed, so the song can be made again |
| `lyricsOnNotes` | how well the words sit on the melody (the Whisper check behind the lead sheet): lines on their notes, the uncertain lines, words heard |
| `generated` | `machine`, `date`, and `yue`: package and torch versions, the YuE commit and whether the patch was applied, model repos with revision and sha256, generation config, whether the song was cut off |
| `files` | the file names in the folder |

## Publish

The songs are free to use. We serve them at **https://media.flogvit.com/music/**, and anyone can publish
their own copy from this repo to any static host or S3-compatible bucket.

`scripts/publish.ts` takes every finished song in `library/` and publishes it as a collection (`bible` by
default; other music gets its own collection with `--collection <name>`):

```bash
bun scripts/publish.ts                    # to the S3 bucket in .env (see .env.example)
bun scripts/publish.ts --out site/music   # to a folder, for any static web host
bun scripts/publish.ts --dry-run          # say what would change, change nothing
```

It only uploads files that changed, so it can run after every new song. Several machines can publish into
the same collection at the same time, each from its own `library/`. Each machine writes only its own song
list, `<collection>/sources/<machine>.json` (named from `MUSIC_MACHINE`, so keep that the same), and
`songs.json` and `index.json` are rebuilt from all the lists. After writing them, the script checks whether
another machine changed its list meanwhile, and rebuilds if so; no machine can drop another's songs. Songs
published before the lists existed are kept as `sources/legacy.json`. What it publishes:

| path | what it is |
|---|---|
| `index.json` | every song in every collection on the host: title, collection, kind, Bible passages, style, tags (sentiment, liturgy, themes, stories, persons), lyrics, music facts and file paths |
| `<collection>/songs.json` | the songs of one collection; `index.json` is built from these |
| `<collection>/sources/<machine>.json` | the songs one machine published; `songs.json` is built from these |
| `<collection>/<id>/audio.mp3` | the song |
| `<collection>/<id>/info.json` | everything about the song, as in `library/` |
| `<collection>/<id>/alignment.json` | when each syllable is sung, for highlighting the lyrics |
| `<collection>/<id>/chords.pdf`, `chords.cho`, `leadsheet.pdf` | chord sheet, ChordPro and lead sheet |

File paths in `index.json` are relative to `index.json` itself, so a copy works wherever it is served. In
a bucket, the public tree goes under `MEDIA_PREFIX` (default `system/music/`). The FLAC masters go to
`masters/<collection>/<id>/audio.flac` in the same bucket, private and in cold storage. Serve the public
prefix at a stable hostname, through a redirect or a CDN, so apps never depend on where the files are stored.

### Publish every new song automatically

Each machine that makes songs runs `scripts/publish-auto.sh` on a timer. It does nothing when no song in its
library is new, and otherwise runs `publish.ts`. The S3 key comes from the machine's own `scw` setup
(`~/.config/scw/config.yaml`) on every run and is never stored; bucket and prefix default to flogvit-media
and `system/music/`. Install the timer once per machine, from a worktree of its own (the timer moves it to the
newest `origin/main` before each run):

```bash
git worktree add --detach .claude/worktrees/publisher origin/main
cd .claude/worktrees/publisher
MUSIC_MACHINE="Home Mac (M1 Max, 64 GB)" MUSIC_LIBRARY=~/WebstormProjects/flogvit/music/library \
  scripts/install-publisher.sh
```

It runs every 10 minutes as the launchd agent `com.flogvit.music-publish` and logs to
`~/Library/Logs/music-publish.log`. Turn it off with `scripts/install-publisher.sh --uninstall`.

## Search

`lib/music.ts` searches `index.json` without a server. Clients load the index and filter it:

```bash
bun scripts/search.ts bread                        # words in title, lyrics, style, passages and tags
bun scripts/search.ts --verse "John 6:35"          # songs on a passage that includes the verse
bun scripts/search.ts --theme salvation --style worship
bun scripts/search.ts --story nehemjas-mur --json  # matching songs as JSON with absolute file URLs
```

Other filters: `--collection`, `--kind`, `--sentiment`, `--liturgy`, `--person`. `--verse` takes book
names as the passages spell them (`John`, `1 Corinthians`), the short names in bible.flogvit.com URLs (`joh`,
`1kor`), or the start of a name (`1 Cor`). The index defaults to `https://media.flogvit.com/music/index.json`;
`--index <file or URL>` points elsewhere. Tests: `bun test lib`.
