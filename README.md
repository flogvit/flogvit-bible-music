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

The pictures for the big screen (see Pictures for the big screen) need their own environment with
[mflux](https://github.com/filipstrand/mflux):

```bash
uv venv --python 3.12 .venv-images
uv pip install --python .venv-images/bin/python mflux==0.24.0
```

The first picture downloads Z-Image Turbo (31 GB) into the Hugging Face cache, and Ollama pulls `qwen3-vl:8b`
(6 GB). The pictures run as a launchd agent of their own (see Pictures for the big screen).

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
| `form` | optional. Without it the lyrics need a `[Chorus]` (or `[Refrain]`), unless `lyricsMode` is `verbatim`. `litany`: every line is answered by one refrain line, as in Psalm 136, and no chorus is needed. `strophic`: verses only (a hymn, a metrical psalm), at least 3, of one length unless verbatim. `ballad`: a story in at least 4 verses of one length, no chorus or bridge, a refrain at most as the last line of every verse. `chant`: one text of 2–4 lines sung as every verse, at least 4 times (Taizé). `call-response`: in every verse a lead line answered by a short response (at most 6 words, at most 2 different ones), with a chorus. The rules are in `scripts/lyrics-form.ts`; section 4 of `docs/research/diversity.md` says why |
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

### The catalog grows by itself

Every theme, person and story in free-bible, and every verse of the day (`daily_verse/en`), gets a song, and
`scripts/catalog-write.ts` writes them: the most visited pages on bible.flogvit.com first
(`catalog/popularity.tsv`), then by the Bible data's own weight (themes, then verses of the day, then persons with
many key events and long stories). For each one a local LLM (Ollama, `MUSIC_WRITER_MODEL`, default the lyrics
check's model) gets the free-bible text (a theme's sections, a person's summary and key events, a story's
description) and the osen text of its passages, and writes the title, lyrics, style line and tags; the script
checks them with the same rules as `validate-catalog` and asks again, up to three times. The genre is the one the
catalog has least of among those that suit the song, and the form is the one its kind asks for (stories ballad,
short verses chant) once that form has passed its test (`FORMS_IN_USE` in the script; until then verse-chorus).
A hymn or choral song about a theme, person or story is strophic.

`run` (see Generate) calls it: when fewer than 4 songs are free, the machine that gets the lock
`refs/claims/_catalog` writes the next 10 (`MUSIC_CATALOG_PORTION`), commits them to `main` and pushes them, and
every machine pulls them. By hand:

```bash
bun scripts/catalog-write.ts --list            # every song still missing, in the order it will be written
bun scripts/catalog-write.ts --count 10        # write the next 10
```

`catalog/popularity.tsv` holds how many people opened each page (`visitors<TAB>path`). `scripts/popularity.py`
makes it from the site's Caddy access log, where the log is, so only the counts leave and never an address:
pipe the log (rotated files unpacked) into `python3 popularity.py` on that machine and commit its output here.
Caddy keeps a few days of log, so refresh it now and then.

## Generate

### The whole catalog, on one or more machines

```bash
MUSIC_MACHINE="Home Mac (M1 Max, 64 GB)" bun scripts/generate.ts run              # from the top of catalog/order.txt
MUSIC_MACHINE="M5 (MacBook Pro, M5 Max, 128 GB)" bun scripts/generate.ts run --from-end
bun scripts/generate.ts status                                                     # every song: done, generating, stale or free
```

`run` takes the next free song, generates it with `configs/long-12000.json` under `taskpolicy -b`, checks that
the singing delivers its lyrics (see Lyrics check), makes its sheets and `library/<id>/`, commits the sheets and pushes them to `main` (or the current branch, or
`$MUSIC_SHEETS_BRANCH`), pulling first what other machines pushed, marks the song done and takes the next one. New catalog songs come first: when fewer than 4 songs are
free it writes the next portion of the catalog (see The catalog grows by itself), so it does not run out, and only when no song is free does it remake this machine's songs whose catalog
request changed (see remake below). It starts no song while the owner's own GPU job runs (`MUSIC_YIELD_TO`, a `pgrep -f` pattern, default a Python process running `mlx_video` or `mflux-`: the owner's video and picture jobs, not a shell whose command only names them)
or another YuE generation runs on the Mac (a remake started by hand), and waits a minute at a time; on a Mac with
less than 96 GB, also not while a song's pictures are made (the pictures are a process of their own: see
Pictures for the big screen). It can run
from a worktree; `YuE/`,
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

To keep a machine generating without a terminal, run it as a launchd agent, from a worktree of its own beside
the checkout. Not under `.claude/worktrees/`: Dux's hourly sweep removes idle worktrees there, and with them the
script launchd runs.

```bash
git worktree add --detach ../music-generate origin/main
cd ../music-generate
MUSIC_MACHINE="M5 (MacBook Pro, M5 Max, 128 GB)" scripts/install-generator.sh --from-end
tail -f ~/Library/Logs/music-generate.log
```

The agent `com.flogvit.music-generate` starts at login and again a minute after `run` stops, so a restart,
a crash or a run that found no free song does not stop the machine for good (a run with nothing to do waits nine minutes before it stops). The worktree follows `main`: `run`
pulls it with each song's sheets, and when `main` brings new code in `scripts/`, `run` stops
between songs (`RUN RESTART` in the log) and launchd starts the new code, so code merged to `main` reaches every
generating Mac within a song and a minute. While a song generates, the Mac
does not sleep on power (`caffeinate -s`); on battery it may, and after 20 minutes asleep the song is free for
others. Without network, `run` waits and tries again every minute. Turn it off with
`scripts/install-generator.sh --uninstall`, which gives the song it was making back. Started from a terminal or
an agent session instead, `run` dies with that terminal or session.

### Lyrics check

YuE sometimes sings a line twice where the lyrics ask for two different lines, drops or merges a line, or
garbles the words. Every song is checked before it gets its sheets. A song sung differently from its lyrics is
not thrown away for that: when what was sung is good lyrics too, the song is kept with the lyrics as sung.
Only a broken song is made again.

1. Whisper listens to the song (`song-sheets.py --listen-only`, which writes `sheets/<id>/whisper.json`; the
   sheets reuse it afterwards, so Whisper runs once per song).
2. `scripts/lyrics-check.ts` gives a local LLM the requested lyrics with their sections (`[Verse]`,
   `[Chorus]`, …) and the phrases Whisper heard, with times. It answers one of three, with each difference and
   when it is heard:
   - `correct`: sung as written. A chorus the lyrics repeat, a hook echoed at the end, wordless vocals,
     Whisper's own near-misses (*this* for *theirs*, *can do* for a drawn-out *endures*) and a repeated line
     Whisper did not write down where there is room for it in the timing are fine.
   - `adopt`: sung differently, but as good, singable lyrics that still say what the passage says: a reworded
     line, an outro sung in other words, one line of a list left out. The song is kept, and the judge writes the
     lyrics as sung in the requested sections. They go in `lyrics-sung.txt` in the song's folder; the sheets,
     `alignment.json` and `library/<id>/info.json` use them (`lyricsAdopted`, with the asked-for lyrics in
     `requestedLyrics`). The song's catalog entry, its Bible references and tags stay as they are.
   - `wrong`: broken: garbled or unintelligible singing, verses or several lines not sung, a line or verse sung
     again in place of the next one, or sung words that misrepresent the passage.
3. `wrong` (and `unsure`) rejects the song: its audio moves to
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

When a song's request changes in the catalog (a new form, style or lyrics), `remake` makes it again on this
machine the same way `run` does: generation, lyrics check, sheets, library and the sheets commit. It takes the
song also when it is done or set aside, as a `remake` commit (held like `claimed`, and the attempts count from
there). The current take moves to `YuE/outputs/catalog/<id>-replaced/`, to compare with. The new take replaces it
only when it is at least as good: its lyrics check at least as good (`correct` before `adopt`; a take from before
the check counts as `correct`) and at least as large a share of its lines on their notes (`alignment.json`). The
log line `REMAKE <id>: new take …, old take …` gives both. Otherwise, or if the new take does not pass, a done song
gets its old take back and stays done, the new take lies in `<id>-remake-failed/`, and nothing is committed or
published, so the published song stays and no other machine makes it again from its own catalog.

`run` does this by itself: when no new song is free, it remakes, one at a time, the songs this machine made whose
catalog request (`style`, `lyrics`, `cot` or `abc`) differs from the one in the take's `request.json`. A change
merged to `main` therefore reaches every song on the Mac that made it (a song must be remade where its old take
is, since the published list prefers the Home Mac's take of a song both have). Each request is tried until a take
passes, whether the new take is kept or the old one is better, and at most `MUSIC_MAX_ATTEMPTS` times when its
takes fail; `YuE/outputs/catalog/remakes.json` keeps each song's last remake on the machine. Run it from a checkout with the changed catalog entry, with a `MUSIC_MACHINE` of its
own (a generator on the same machine name would otherwise finish the song too when it restarts). On a Mac that
is also generating, start it when `top -l 2 -n 0 -s 2` shows at least 25 % idle and `ollama ps` shows no model.

```bash
ls aside/                                       # songs set aside
bun scripts/generate.ts retry <id>              # put one back, for 3 more attempts
bun scripts/generate.ts rejudge <id>            # judge its kept takes again under the current rules (on the
                                                # machine that set it aside), keep the first that passes
MUSIC_MACHINE="M5 …, remake" bun scripts/generate.ts remake <id>   # make one song again after its request changed
bun scripts/lyrics-check.ts <id>                # judge sheets/<id>/whisper.json now (exit 0 = correct,
                                                # 3 = adopt, 2 = wrong)
bun test scripts                                # the judge on a real doubled chorus line and a real chorus,
                                                # and the lyrics form rules (lyrics-form.test.ts)
```

`MUSIC_MAX_ATTEMPTS` sets the number of attempts (default 3), and `MUSIC_JUDGE_MODEL` the Ollama model
(default `qwen3.8:27b`). For the launchd agent, set them when installing it, for example
`MUSIC_MAX_ATTEMPTS=5 MUSIC_MACHINE="…" scripts/install-generator.sh --from-end`. The judge takes 1–5 minutes
per song on an M5 Max, more when the Mac is busy; it works while the next song generates. Ollama unloads the
model after each song, so YuE gets the memory back. The judge runs in Ollama's own process, so `taskpolicy -b`
does not reach it.

### Pictures for the big screen

Every song gets pictures for the screen view of music.flogvit.com: one quiet photograph per part of the song,
shown behind the lyrics (`library/<id>/scenes.json` and `scenes/*.webp`; see Library). `scripts/scenes.ts`
makes them in three steps:

1. A local LLM (`qwen3.8:27b`, the judge's model) reads the song's parts with numbered lines and describes one
   photograph per part, from the concrete image in its lines (a mood landscape for abstract ones), and the line
   it begins at. The rules: simple and clean, one subject; the world of the Bible, nothing modern; people and
   animals only where the words call for them, few, at a distance or from behind, never posing or close up;
   never God as a person, and Jesus only from behind or far away; no writing; a chorus that comes back gets the
   same picture; each picture stays up at least two lines. The answer is kept in `scenes/plan.json`.
2. Z-Image Turbo (mflux, 8-bit, 9 steps) makes each picture at 1920×1088 with the same film look, cut to
   1920×1080 WebP. The words lie over the bottom third, so the look puts the subject in the upper middle, on a
   low horizon, and keeps the bottom third empty foreground.
3. A vision model (`qwen3-vl:8b`) looks at each picture: writing, something modern, a broken body or object, or
   someone posing makes it try the next seed, three times at most. So does a picture whose text band (62–91 % of
   the height) has more than twice the detail of the part above it: its subject stands under the words, with
   empty sky or wall above (measured on the picture, not asked). A picture that never passes is left out, and
   the one before it stays up longer.

`scenes.json` is written last, so `publish-auto.sh` sees a new file and publishes the song again with its
pictures. A song made again with other lyrics, or with pictures in an earlier look, gets new pictures
(`scenes/plan.json` keeps the lines and the look it was made with). On an M5 Max one picture takes about a minute and a song 5–8 minutes; on an M1 Max a picture takes
about four minutes and a song about 25 (both measured).

The pictures are not tied to making songs: a launchd agent of their own runs `scenes.ts --watch`, which makes
them for every song in `library/` without them, the newest first, and then for each new song as it comes. It
moves its checkout to the newest origin/main between songs and starts again when the picture code changed. A
song whose pictures fail is logged and tried again when it starts again. On a Mac with 96 GB or more, pictures
run beside YuE. On a smaller one (YuE 12 GB, the picture model 26 GB and the judge 17 GB at once come too close
to 64 GB) they take turns: a song's pictures wait while YuE generates, and `generate.ts run` starts no song while a
song's pictures are being made.

```bash
git worktree add --detach ../music-pictures origin/main
cd ../music-pictures && scripts/install-pictures.sh   # once per machine, beside the generator and the publisher
tail -f ~/Library/Logs/music-pictures.log

bun scripts/scenes.ts library/<id>                    # one song by hand
rm -r library/<id>/scenes library/<id>/scenes.json    # to make a song's pictures again from scratch
```

`MUSIC_SCENES_MODEL` and `MUSIC_LOOK_MODEL` choose other Ollama models.

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
| `scenes.json`, `scenes/*.webp` | optional: the pictures behind the lyrics on a big screen, below |
| `info.json` | everything about the song, below |

### scenes.json

The pictures the screen view of music.flogvit.com shows behind the lyrics: one per part of the song, each
from the line it begins at until the next. A list of `{line, image, alt}`: `line` is the line's index in
`alignment.json` (from 0; the first scene is shown from the start of the song), `image` the file relative to
`scenes.json` (1920×1080 WebP, about 150–500 KB), and `alt` what the picture shows. The same image can come
back, as a chorus does. The player crossfades halfway through the pause before a scene's line, at most three
seconds before it is sung (`sceneStarts` in `lib/music.ts`).

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
published before the lists existed are kept as `sources/legacy.json`. Each song carries when it first came
out (`published`), and keeps that date whichever machine publishes it again. What it publishes:

| path | what it is |
|---|---|
| `index.json` | every song in every collection on the host: title, collection, kind, Bible passages, style, tags (sentiment, liturgy, themes, stories, persons), lyrics, music facts, when it first came out (`published`) and file paths |
| `<collection>/songs.json` | the songs of one collection; `index.json` is built from these |
| `<collection>/sources/<machine>.json` | the songs one machine published; `songs.json` is built from these |
| `<collection>/<id>/audio.mp3` | the song |
| `<collection>/<id>/info.json` | everything about the song, as in `library/` |
| `<collection>/<id>/alignment.json` | when each syllable is sung, for highlighting the lyrics |
| `<collection>/<id>/chords.pdf`, `chords.cho`, `leadsheet.pdf` | chord sheet, ChordPro and lead sheet |
| `<collection>/<id>/scenes.json`, `scenes/*.webp` | the pictures behind the lyrics on a big screen, when the song has them |

File paths in `index.json` are relative to `index.json` itself, so a copy works wherever it is served. In
a bucket, the public tree goes under `MEDIA_PREFIX` (default `system/music/`). The FLAC masters go to
`masters/<collection>/<id>/audio.flac` in the same bucket, private and in cold storage. Serve the public
prefix at a stable hostname, through a redirect or a CDN, so apps never depend on where the files are stored.

### Publish every new song automatically

Each machine that makes songs runs `scripts/publish-auto.sh` on a timer. It does nothing when no song in its
library is new, and otherwise runs `publish.ts`. The S3 key comes from the machine's own `scw` setup
(`~/.config/scw/config.yaml`) on every run and is never stored; bucket and prefix default to flogvit-media
and `system/music/`. Install the timer once per machine, from a worktree of its own beside the checkout (the
timer moves it to the newest `origin/main` before each run; not under `.claude/worktrees/`, which Dux's sweep
removes). `MUSIC_LIBRARY` must be the library this machine's generation writes `library/<id>/` to:

```bash
git worktree add --detach ../music-publisher origin/main
cd ../music-publisher
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
