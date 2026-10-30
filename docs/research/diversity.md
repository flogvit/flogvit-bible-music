# More diversity without losing quality

Research for issue #4, 2026-10-30. The question: how do we get more variety into the songs without making them
worse? Every number below says where it comes from. "Not known" means the sources do not say.

## In short

- The songs vary a lot in **style** (16 genres, the largest is 13 % of the catalog) and very little in
  **form**: all 180 catalog songs have a `[Chorus]`, 89 % a `[Bridge]`, 90 % an `[Outro]`, and the most common
  shape, verse–chorus–verse–chorus–bridge–outro, alone is 27 %. **Meter** and **key** barely vary either: 90 % of
  the finished songs are in 4/4 or 2/4, and half are in B♭ or E♭ major.
- YuE2 follows the style line on exactly the axes we vary least: voice setup, tempo and key are dimensions
  the authors test it on. Its section labels come from a fixed list of 23 in which `refrain` and `hook` do not
  appear.
- The quality today: 95 songs have been judged since the lyrics check came in. 77 were `correct`, 18 `adopt`,
  and 13 takes were `wrong`. That is 1.14 tries per song, 86 of 95 passed on the first try, and one song was set
  aside: Psalm 136. The form caused it. Its chorus repeats a refrain that every line already ends with.
- Recommended order, best gain against risk first: **form from the text** (litany, then strophic psalms
  without a bridge), **meter**, **key and mode**, **voice setup**, then **tempo** and **lyrical devices**.
  Each one is tried first on a small group of `remake`s with one change each (see Test plan).
- **Psalm 136 as a litany:** `correct` on the first try, after three wrong takes in the verse–chorus form.
  Every line sits on its notes (27 of 27, against 0 of 29 in the take it replaces). The last section has the
  details.

## 1. What YuE2 handles well

We run YuE2-3B (`YuE/`, upstream commit `1647252` with `patches/yue2-mps.patch`). YuE2 is a different model from the
YuE in arXiv:2503.08638; what that paper and the YuE-v1 README say about tags and reference audio applies only
partly here, and is marked where used.

**What a request can carry.** `style`, `lyrics`, `cot`, `seed`, `abc`, `cfg_scale` and `id`; nothing else.
"There is no request field for `reference_audio`, `phonemes`, `bpm`, `negative_prompt`, an edit interval or a
reference singer" (`YuE/skills/yue2-music/references/generation-and-covers.md`, «Choose the conditioning
mode»). **In-context learning with a reference audio, as YuE 1 had, does not exist in YuE2**: YuE 1 needed
separate `-icl` checkpoints for it, and its README warned that a reference "results in less diversity since the
generated token space is bounded by the ref audio" (YuE-v1 README, «Audio Prompt»). What replaces it in YuE2 is a
score: a melody in ABC (`abc`, with `cot="melody"`), for example transcribed from a recording with SheetSage2
(`YuE/docs/covers.md`).

**Style line.** "Put genre, instruments, vocal character, language, and tempo in `style`" (`YuE/docs/generation.md`).
The authors measure how well the model follows the style line on seven dimensions: "vocal timbre, vocal setup
(solo, duet, group, gender, or instrumental), genre, mood, instrumentation and production, tempo, and key"
(technical report, arXiv:2609.33757, appendix A.1). YuE2 scores 4.68 of 5 there on 192 prompts
(`YuE/docs/benchmark-results.csv`, `control_overall`). Meter is not one of the seven; how well the model
follows "3/4" or "6/8" in the style line is not known from the sources.

**Section tags.** The lyrics take tags such as `[Verse]` and `[Chorus]` (`YuE/docs/generation.md`). The model
learned form from scores made by SheetSage2, whose section labels are a fixed list of 23: silence, intro, outro,
verse, chorus, bridge, pre-chorus, post-chorus, interlude, fade-out, loop, rap, preshot, irregular, instrumental,
intro and verse, pre-chorus and chorus, verse and pre-chorus, solo, theme, development, variation, pre-outro
(`YuE/models/SheetSage2/labels_sheetsage2.py`; the SheetSage2 report, appendix: "Section tokens … select among 23
labels"). **`[Refrain]`, `[Hook]` and `[Break]`, which `validate-catalog` accepts, are not on that list.** How
the lyric-side tags were made in training, the report does not say. What the model writes itself is clear: the
102 scores in `YuE/outputs/catalog/*/score.abc` on the M5 (kept and rejected takes) use only chorus (244), verse
(218), intro (102), outro (81), bridge (45), interlude (36) and pre-chorus (19). So the safe tags are those; a refrain is better written as
lines inside a `[Verse]` than as a tag of its own.

**Planning the score first (`cot: "full"`, what we use)** gives better songs: in a blind expert test, 49.3 %
preferred the planned song for overall quality and 34.6 % the unplanned one (report, §4.2, p = 0.007). The
audio follows the planned form fairly well: form similarity 0.78 and section-boundary F1 0.87 between score
and audio; key agreement 0.93 and tempo within 8 % in 98.7 % (report, §5.1, table 3). YuE2 also writes an intro by itself
(all 102 of those scores open with one), so the catalog's 0 % `[Intro]` costs nothing; YuE 1's README
also found "[intro] label is less stable".

**Seed, CFG, temperature.** The same seed gives the same song on the same runtime; "separate GPUs, runtime
versions, or sampling settings can change a seeded generation" (`YuE/docs/generation.md`). CFG defaults to 1.0
with planning; 1.2 "is not a guaranteed quality improvement", and "changing sampling or guidance may change
quality" (same file and the skill reference). Our `configs/long-12000.json` keeps the default sampling (score
temperature 0.7, audio 1.0, audio repetition penalty 1.2 over a window of 50 tokens = 2 s) and only raises the
length limit. **Sampling and CFG are not a place to look for variety:** the authors give no gain from them, and
they are what quality was tuned on. Variety should come from what the request says.

**Picking among takes.** The benchmark picks the better of two takes by phoneme error rate, and "best-of-8"
from eight (report, §4.1). Our lyrics check does the same job one take at a time: up to three takes, the first
one that passes.

## 2. How diverse we are today

From `catalog/*.json` (180 songs), the 84 finished songs in `library/` on the M5 (`info.json`, `music`: what
YuE2 actually made), and the 167 published songs on media.flogvit.com (both Macs).

| axis | what we have | uniform? |
|---|---|---|
| kind | story 74, verse 54, person 22, chapter 15, theme 15 | no |
| genre (first style tag) | folk 23, gospel 20, orchestral 16, rock 15, children 14, soul 14, ballad 13, celtic 12, country 12, acoustic 8, worship 8, blues 8, pop 6, jazz 4, hymn 4, choral 3 | no |
| form | `[Chorus]` 180 of 180, `[Bridge]` 161 (89 %), `[Outro]` 162 (90 %), `[Pre-Chorus]` 24 (13 %), `[Intro]` 0. 51 distinct section orders, but V-C-V-C-B-O alone is 49 songs (27 %), and 89 (49 %) start V-C-V-C. No song without a chorus. | **yes** |
| meter | style line names a meter in 2 of 180 (12/8, 6/8). Made: 4/4 58, 2/4 18, 3/4 4, 6/8 4 of 84 | **yes**, 90 % duple |
| key | not in the style line. Made: B♭ 28, E♭ 15, D minor 8, C 8, D♯ minor 7, F 4, …; 64 major, 20 minor of 84 | **yes**, 51 % B♭ or E♭ |
| tempo | style line: median 86 BPM; under 70: 23, 70–89: 76, 90–109: 42, 110–129: 34, 130 and up: 5. Made: 63–132, median 85 | somewhat; 42 % in 70–89, almost nothing fast |
| lead voice | male 100, female 70, choir only 10 | no |
| voice setup | choir 62 (34 %), duet 15 (8 %), children's voices 15 (8 %), call and response 8 (4 %), a cappella 1 | **yes**, 92 % one lead singer |
| instruments | bass 96, piano 83, drums 80, acoustic guitar 58, organ 41, fiddle 32, strings 30 | no |
| lyrics mode | mixed 130, thematic 36, verbatim 14 | no |
| person | first person singular (I, my, me) in 150 of 180 (83 %) | **yes** |
| lyrical devices | anaphora (4+ lines opening alike) in 102; a refrain inside the verses in 1 (Psalm 136); quoted speech 0; echo or answer lines 0 | **yes** |
| length | 16–60 lines, median 26; 8 words per line (median); made: 1:43–6:21, median 3:09 | no |

## 3. The quality measure

**Where the numbers come from.** Every take's verdict is a commit in its song's lock (`refs/claims/<id>`:
`rejected`, `done`, `done … (set aside)`), from both Macs. Whether a kept song was `correct` or `adopt` is in
its published `info.json` (`lyricsAdopted`), also from both Macs. The judge's reasons for each wrong take are in
`YuE/outputs/catalog/*/lyrics-check.json`; those were read on the M5 only, because the Home Mac did not answer
over SSH from here. The lyrics check started 2026-10-29 16:14, and `adopt` at 22:02.

| | songs | correct | adopt | wrong takes | tries per song | first try | set aside |
|---|---|---|---|---|---|---|---|
| since the lyrics check, both Macs | 95 | 77 | 18 | 13 | 1.14 | 86 | 1 |
| M5 | 49 | 43 | 6 | 5 | 1.10 | 45 | 0 |
| Home Mac | 45 | 34 | 11 | 5 | 1.11 | 41 | 0 |
| since `adopt` came in | 72 | 55 | 17 | 7 | 1.10 | 67 | 0 |

(The 95th song is Psalm 136, set aside after three takes on the M5 and kept as `adopt` by `rejudge`.)

Also in `info.json`: Whisper finds 82.4 % of the lyric lines on their notes in these 95 songs, and hears 97.3 %
of the words.

**Why takes fail** (the 8 wrong takes made on the M5; the Home Mac's 5 were not readable from here): Psalm 136 three times (a line skipped right before the chorus; a chorus
missing and the next line garbled; the refrain sung as "can do forever"), a proper name sung as other words twice
(theme-bonn-soul: "Hannah" → "And I"), the outro dropped once (theme-glede-pop), a whole fourth verse after the
bridge skipped once (person-jesaja-orchestral), and one `unsure` on a repeated word (verse-40-5-13-children). So
five of eight come from the form: a chorus that repeats the end of a verse, and text placed after the bridge.

**By group,** since the lyrics check (few songs each, so these only show that no group is far off):

| group | songs | adopt | tries per song |
|---|---|---|---|
| duet | 10 | 1 | 1.20 |
| choir | 31 | 6 | 1.26 |
| female lead | 34 | 5 | 1.12 |
| male lead | 39 | 9 | 1.15 |
| 110 BPM and up | 18 | 3 | 1.17 |
| under 75 BPM | 24 | 4 | 1.21 |
| 3/4 or 6/8 | 7 | 1 | 1.29 |
| verbatim | 8 | 2 | 1.50 (Psalm 136 is 3 of the 4 wrong takes) |

**What "no worse" means** for a test group: the same lyrics check, and against the numbers above: no song set
aside, and at most 1.25 tries per song (today 1.10–1.14). The share that is `adopt` (today 24 % since `adopt`)
is watched too, since an adopted song is sung with other words than asked. And the owner listens: each test song
is a `remake` of a song that exists, so the old take lies beside it (`<id>-replaced`) for a direct comparison.

## 4. Axes, ranked by gain against risk

| # | axis | gain | risk to quality | why |
|---|---|---|---|---|
| 1 | **Form from the text**: litany where the text has a refrain (Psalm 136, 118:1–4), strophic psalms and hymns (verses, no chorus, no bridge), ballad for stories (verses that move the story, a short refrain at most) | high: the most uniform axis (100 % chorus) and the one listeners notice first | low to negative: five of eight wrong takes on the M5 come from the form we force today; fewer sections after the bridge removes the place where verses get skipped | Psalm 136 test below |
| 2 | **Meter**: 3/4 and 6/8 in the style line for hymns, celtic, lullabies, gospel 12/8 | high: 90 % duple today | not known: meter is not one of the dimensions YuE2 is tested on. YuE2 did write 3/4 and 6/8 unasked in 8 of 84 songs, and those 7 judged songs needed 1.29 tries | test group needed |
| 3 | **Key and mode**: a key in the style line ("in D minor"), minor for laments and penitential psalms | medium: half the songs sit in B♭ or E♭, 24 % minor | low: key is one of the seven tested dimensions; score key agreement 0.93 | |
| 4 | **Voice setup**: more female leads, duets for dialogues (Ruth and Naomi, the annunciation), call and response for psalms with responses, choir alone for hymns, children's choir | medium | low to medium: voice setup is a tested dimension. Duet and choir songs need 1.20 and 1.26 tries against 1.14 overall (few songs). A duet that swaps lines can read as a repeat to the judge | |
| 5 | **Tempo**: songs at 120–140 for the joyful texts (only 5 at 130 and up) | medium | medium: more words per second; the 18 songs at 110+ needed 1.17 tries | keep lines short when fast |
| 6 | **Lyrical devices**: third person for stories (83 % first person today), quoted speech in stories, answer lines | medium | low for wording; not known for echo lines in parentheses (whether YuE2 sings them, and how the judge counts them) | try parentheses only in a test |
| 7 | **Melody from a score**: a public-domain hymn tune as `abc` with `cot: "melody"`, for strophic hymns | high for hymns: real meters and form | high effort and not known: ABC tooling, syllables fitted to notes, our MPS runtime; no take of ours has used `abc` yet | idea, untested |
| — | sampling, CFG, temperature | not known | the defaults are what quality was tuned on; the authors promise nothing from changing them | not recommended |
| — | `[Refrain]`, `[Hook]`, `[Break]` tags | none | not on SheetSage2's list; the model never writes them | use `[Verse]` and `[Chorus]` |

## 5. Test plan

Each test changes one thing in the catalog entry of a song that already exists, and makes it with
`bun scripts/generate.ts remake <id>`: the same path as production (generation, Whisper, lyrics check, sheets,
library), the old take kept as `<id>-replaced`, and a done song keeps its old take if the new one fails, so
nothing published disappears. Run it on the M5 between the generator's songs, as the Psalm 136 run did:
wait for 25 % CPU idle in `top -l 2 -n 0 -s 2` and no model in `ollama ps`, with its own `MUSIC_MACHINE`. A
branch with the changed entries is enough; production's catalog does not change before a group has passed.

| group | songs (6–8, spread over genres and machines) | change |
|---|---|---|
| A litany | chapter-19-136-gospel (done below). No other catalog song has a refrain on every line; the next litanies are new songs (Psalm 118:1–4, Psalm 136:10–22), made by `run` once the form is in production's catalog | `form: "litany"`, no chorus |
| B strophic | chapter-19-23-worship, chapter-19-1-folk, chapter-19-90-hymn, story-det-siste-maltidet-hymn, chapter-19-121-celtic, verse-40-6-9-choral | verses only, no bridge (needs a `strophic` form in `lyrics-form.ts`) |
| C meter | person-rut-celtic, chapter-19-121-celtic, chapter-19-90-hymn, verse-40-11-28-folk, story-jesu-fodsel-celtic, chapter-19-23-worship | "in 3/4" or "6/8" in the style line |
| D key and mode | chapter-19-139-ballad, person-job-blues, story-korsfestelsen-ballad, verse-19-51-10-ballad, person-elia-blues, story-stefanus-martyrium-hymn | a key in the style line, minor where the text laments |
| E voice setup | person-rut-celtic (duet), story-engelen-gabriel-besoker-maria-celtic (duet), chapter-19-150-jazz (call and response), chapter-19-8-orchestral (choir alone), person-debora-celtic (female lead) | the voice part of the style line |

For each group: the verdicts, the tries, lines on notes from `info.json`, and a listening pass by the owner
with the old take beside the new one. A group passes when it meets the bar in section 3 and the owner prefers
or accepts the new takes. Only then is the change offered for the rest of the catalog, and the owner decides.

## Psalm 136 as a litany

`catalog/chapter-19-136-gospel.json` gets `form: "litany"` and loses its two `[Chorus]` blocks. Style, seed and
verses stay; every line is now answered by "His steadfast love endures forever", as in the psalm, ending with the
outro. `validate-catalog` checks that every line in a litany is answered by its refrain (`scripts/lyrics-form.ts`,
tests in `scripts/lyrics-form.test.ts`); without a form, the chorus rule is as before.

It was made once with `bun scripts/generate.ts remake chapter-19-136-gospel` on the M5 on 2026-10-30, between
the generator's songs (started 10:30 at 58 % CPU idle with no model in Ollama, done 12:07; `MUSIC_MACHINE` "M5
(MacBook Pro, M5 Max, 128 GB), litany test"). The lock shows `remake` 10:30:34 and `done` 12:07:15.

| | verse–chorus form (before) | litany (now) |
|---|---|---|
| takes | 3 wrong (seeds 20131–20133), set aside; take 1 kept later as `adopt` by `rejudge` | 1 (seed 20133) |
| lyrics check | take 1: moon-and-stars line skipped before the chorus; take 2: chorus missing, next line garbled; take 3: refrain heard as "can do forever" | `correct`, no problems ("Every requested line is present … in order"; only "water"/"light" for the plurals, which are fine) |
| lines on their notes (`info.json`, `lyricsOnNotes`) | 0 of 29 (the kept take 1) | 27 of 27 |
| words heard | 171 of 175 | 169 of 169 |
| length | 2:17 | 2:56 |
| key, meter, tempo | E♭, 4/4, 100 | E♭, 4/4, 100 |

YuE2 still gave the plan a shape of its own: its score marks the four `[Verse]` blocks as verse, chorus, verse,
chorus, with an intro and an outro. So the planner makes its own contrast between blocks even when the lyrics
have no chorus. The old take lies in `YuE/outputs/catalog/chapter-19-136-gospel-replaced/` on the M5, for
listening side by side. The new take is in `library/` and goes out with the publisher. One song is not a group:
group A in the test plan needs the further litanies before `litany` counts as no worse than the standard form.

## Form tests, 2026-10-30

The forms `strophic`, `ballad`, `chant` and `call-response` are in `scripts/lyrics-form.ts`. Each was tried on
three songs made on the M5 (a remake must run where the old take is), with `remake` on the M5: the new take is
kept only when its lyrics check is at least as good (`correct` before `adopt`) and at least as large a share of
its lines sits on its notes (`alignment.json`). The groups: strophic Psalm 90, the cross hymn and Psalm 1;
ballad Jonah in Nineveh, Joseph in the well, Cain and Abel; chant Revelation 22:20, Philippians 4:4 and
Psalm 42:2; call-response the dry bones, the Passover and the man born blind.

| song | form | lyrics check | lines on notes, new / old | kept | YuE's plan (score.abc) |
|---|---|---|---|---|---|
| chapter-19-90-hymn | strophic, 5 verses of 4 lines | `correct` (only small words marked (?)) | 11 of 20 / 25 of 25 | old | I-V-C-V-C-O, 4/4, 76 BPM (old take I-V-C-V-C-V-O, 4/4, 70) |

**YuE plans its own form.** Psalm 136 as a litany (4 `[Verse]` blocks) was planned verse-chorus-verse-chorus,
and Psalm 90 as five verses the same: the planner labels every second block a chorus and gives it another
melody, whatever the lyrics' tags say. Verses only in the lyrics do not make a strophic song. Psalm 90's verses
are not metrical (4 to 12 syllables a line), and its new take sang every line, but Whisper found only 11 of 20 of
them on their notes, against all 25 in the verse-chorus take; that take stays.
