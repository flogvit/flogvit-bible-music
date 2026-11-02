# Style breadth

The owner's order, 2026-11-01: the songs are pleasant and stay as they are, but Christian music comes in far more
styles than the catalog has. Widen it to as many styles as possible, and make just enough songs per style to cover
it well, no more.

**English only (the owner, 2026-11-02):** every song is sung in English. The styles below stay, with their sound,
but are sung in English: the Norwegian and Latin probes (prayer house, kveding, chorale, Gregorian, polyphony, a
Taizé chant) were written again in English, and the generation rejects a song asked for or sung in another
language (README, Catalog and Lyrics check).

## Where the catalog stood

374 songs in 16 styles of about 23 each (folk, gospel, soul, rock, worship, pop, orchestral, jazz, hymn, country,
choral, children, celtic, blues, ballad, acoustic). The sound was narrow inside those labels: 184 of 256 songs
the conductor counted sat at 66–92 BPM, only 26 above 110; 70 had "warm" or "hopeful" in the style line, and the
same shape came back again and again ("warm solo voice, acoustic guitar, piano, cello, hopeful, 80 BPM"). Every
song was in English, nearly always one lead singer with a soft choir.

## The new styles

36 styles, each tried first with one probe song (`catalog/`, ids at the top of `catalog/order.txt`, seeds
30001–30036). Breadth comes from five directions at once:

| direction | what was added |
|---|---|
| tradition | Gregorian chant, Taizé, Byzantine chant with ison drone, Renaissance polyphony, Baroque oratorio, Sacred Harp, Lutheran chorale with congregation and organ, Coptic and Armenian chant |
| region | spirituals, Southern gospel quartet, bluegrass gospel, black gospel mass choir, Norwegian prayer-house revival song (accordion, waltz), Salvation Army brass band, Norwegian kveding with Hardanger fiddle, South African isicathamiya, West African highlife, Latin salsa and bachata, reggae, Indian bhajan, klezmer for Messianic dance, Middle Eastern instruments (oud, darbuka, frame drum) for Old Testament songs |
| modern | hip hop, spoken word, metal, punk, EDM, ambient, lo-fi |
| use | musical with several roles, lullaby, sea shanty, children's choir, triumphant anthem |
| mood after the text | lament without comfort (Job, Lamentations, David over Absalom, Psalm 88, Rachel), dance (Miriam, David before the ark, Psalm 149), triumph (Psalm 24, Revelation 19) |

Voices: choir alone (Gregorian, polyphony, Byzantine, Sacred Harp, isicathamiya, spirituals), children's choir,
a cappella, duets between roles (musical, Song of Songs), lead and congregation (brass band, chorale, prayer
house), rap, and old, raw voices (lament, kveding). Tempo: 50 to 160 BPM. Language: English, for every style (the
owner, 2026-11-02); the first probes of the prayer house, kveding, chorale, Gregorian and polyphony were sung in
Norwegian or Latin and are now in English.

## How many songs per style

**Rule.** A style is covered when a listener who opens it hears it in each of its main uses, and no use twice:

1. each kind of text the tradition actually sings (a psalm or prayer, a Bible story, a feast or theme),
2. each mood the tradition has (praise and lament, or feast and fast),
3. each voice setup it typically uses (solo, choir, duet, congregation),
4. its tempo range, where it has one (bluegrass from waltz to breakdown, gospel from ballad to praise break).

One song per needed cell; a song fills several cells where it can. Three songs at least, since one or two
cannot show what a style holds; six at most, since past that the catalog only gets more of the same. The 16
styles we had keep growing with the catalog (`catalog-write.ts`); the new styles do not, so their number is fixed
here.

| songs | styles | why |
|---|---|---|
| 5 | hip hop, mass choir, lament | hip hop is storytelling, testimony and exhortation, each a different song; mass choir runs from worship ballad to praise break; lament needs the five voices of biblical grief (Job, a city, a father, a psalm, a mother) |
| 4 | Gregorian, Taizé, Byzantine, polyphony, Baroque, Sacred Harp, chorale, kveding, prayer house, brass band, spirituals, Southern gospel, bluegrass, isicathamiya, highlife, salsa, reggae, metal, EDM, ambient, musical, lullaby, Middle Eastern, anthem, children's choir | the main cells: two kinds of text, two moods or feasts, two voice setups or tempos |
| 3 | Coptic, Armenian, bhajan, klezmer, punk, lo-fi, spoken word, shanty | a narrower use: the style is sung for fewer kinds of text or in one mood |

The cells of each style are the songs themselves; their catalog entries say which (style line, kind, mood). In
all 139 songs: 36 probes and 103 more. The probes went first, half at the top of `catalog/order.txt` (the Home Mac's
generator works from the top) and half at the end (the M5's works from the end). Since every style held (below),
the 103 further songs follow them the same way: one half after the top probes, the other at the end, with the
styles interleaved so both Macs make some of each.

## Probe results

All 36 probes were made in the ordinary lane on 2026-11-01, half on the Home Mac (from the top of
`catalog/order.txt`) and half on the M5 (from the end), with the same lyrics check as every other song: Whisper
listens, the judge (`qwen3.8:27b`) compares, and a broken take is made again with the next seed.

**Every style held. None was dropped or moved to a neighbouring style.** 36 of 36 probes passed: 32 on the first
take, four on a later one, 1.14 takes per song (the catalog's rate since the lyrics check came in is 1.14 too,
`docs/research/diversity.md`). 4 were `adopt` (sung with small rewordings, published as sung).

| style | probe | language | made on | takes | lyrics check | lines on their notes | BPM asked → made | meter, key | length |
|---|---|---|---|---|---|---|---|---|---|
| gregorian | `verse-40-6-9-gregorian` | Latin | Home Mac | 1 | correct | 11/12 | 60 → 60 | 2/4, Dm | 2:39 |
| taize | `verse-19-103-1-taize` | English | Home Mac | 1 | correct | 19/25 | 66 → 75 | 4/4, Dm | 3:34 |
| byzantine | `verse-19-141-2-byzantine` | English | Home Mac | 1 | adopt | 9/14 | 56 → 63 | 2/4, Eb | 2:35 |
| polyphony | `verse-19-42-2-polyphony` | Latin | Home Mac | 1 | correct | 1/7 | 64 → 85 | 4/4, Dm | 1:38 |
| baroque | `verse-23-9-5-baroque` | English | Home Mac | 1 | correct | 13/13 | 112 → 120 | 4/4, Bb | 1:24 |
| sacred-harp | `verse-66-21-4-sacred-harp` | English | Home Mac | 1 | correct | 16/16 | 96 → 85 | 2/4, Eb | 1:29 |
| spiritual | `person-moses-spiritual` | English | Home Mac | 1 | correct | 10/24 | 72 → 71 | 2/4, Em | 2:44 |
| southern-gospel | `story-elias-himmelfart-southern-gospel` | English | Home Mac | 1 | correct | 17/18 | 112 → 119 | 4/4, Ab | 1:59 |
| bluegrass | `story-jesus-stiller-stormen-bluegrass` | English | Home Mac | 1 | correct | 24/24 | 132 → 135 | 2/4, Bb | 7:59 |
| mass-choir | `chapter-19-150-mass-choir` | English | Home Mac | 2 | correct | 16/22 | 128 → 125 | 4/4, Eb | 1:49 |
| bedehus | `story-den-fortapte-sonn-bedehus` | Norwegian | Home Mac | 1 | correct | 22/22 | 92 → 94 | 4/4, Dm | 2:34 |
| brass-band | `theme-frelsen-brass-band` | English | Home Mac | 1 | correct | 19/19 | 112 → 118 | 4/4, Dm | 2:14 |
| kveding | `chapter-19-23-kveding` | Norwegian | Home Mac | 1 | correct | 13/13 | 70 → 66 | 2/4, Gm | 2:04 |
| isicathamiya | `story-jesus-gar-pa-vannet-isicathamiya` | English | Home Mac | 1 | correct | 22/22 | 84 → 86 | 2/4, Gm | 3:04 |
| highlife | `story-bryllupet-i-kana-highlife` | English | Home Mac | 1 | correct | 20/22 | 120 → 120 | 4/4, F | 2:36 |
| salsa | `verse-19-30-12-salsa` | English | Home Mac | 1 | correct | 9/22 | 98 → 98 | 2/4, Dm | 2:11 |
| reggae | `story-paulus-og-silas-i-fengsel-reggae` | English | Home Mac | 3 | correct | 16/16 | 76 → 75 | 2/4, F | 2:48 |
| hiphop | `story-daniel-og-vennene-i-babel-hiphop` | English | M5 | 1 | correct | 0/24 | 90 → 87 | 4/4, Dm | 1:50 |
| spoken-word | `chapter-21-3-spoken-word` | English | M5 | 1 | correct | 8/15 | 70 → 70 | 4/4, Bb | 3:02 |
| metal | `story-de-fire-rytterne-metal` | English | M5 | 2 | adopt | 12/22 | 150 → 150 | 4/4, D#m | 4:23 |
| punk | `story-tempelrenselsen-punk` | English | M5 | 1 | correct | 20/20 | 160 → 180 | 4/4, E | 1:37 |
| edm | `theme-den-hellige-and-edm` | English | M5 | 1 | correct | 12/20 | 126 → 128 | 4/4, D#m | 3:34 |
| ambient | `verse-19-46-11-ambient` | English | M5 | 1 | correct | 13/13 | 60 → 70 | 4/4, Eb | 2:14 |
| lofi | `verse-50-4-6-lofi` | English | M5 | 1 | correct | 15/16 | 78 → 82 | 4/4, Bb | 2:09 |
| musical | `story-engelen-gabriel-besoker-maria-musical` | English | M5 | 1 | adopt | 15/20 | 92 → 90 | 4/4, Bb | 2:37 |
| lullaby | `verse-19-4-9-lullaby` | English | M5 | 1 | correct | 2/16 | 56 → 75 | 4/4, Eb | 2:22 |
| shanty | `story-skipbruddet-pa-vei-til-rom-shanty` | English | M5 | 1 | correct | 24/24 | 104 → 105 | 2/4, Dm | 2:10 |
| lament | `person-job-lament` | English | M5 | 1 | correct | 15/21 | 52 → 72 | 4/4, Cm | 3:04 |
| middle-eastern | `story-israelittene-gar-gjennom-rodehavet-middle-eastern` | English | M5 | 1 | correct | 15/16 | 132 → 132 | 4/4, Cm | 2:29 |
| klezmer | `story-david-farer-arken-til-jerusalem-klezmer` | English | M5 | 1 | correct | 17/17 | 140 → 140 | 4/4, Dm | 2:02 |
| coptic | `verse-23-6-3-coptic` | English | M5 | 1 | correct | 5/13 | 70 → 76 | 4/4, Bb | 2:14 |
| armenian | `chapter-19-130-armenian` | English | M5 | 1 | adopt | 13/15 | 58 → 75 | 4/4, Cm | 2:24 |
| anthem | `chapter-19-24-anthem` | English | M5 | 1 | correct | 5/15 | 104 → 100 | 4/4, Bb | 1:59 |
| childrens-choir | `verse-19-8-3-childrens-choir` | English | M5 | 1 | correct | 16/16 | 100 → 102 | 2/4, C | 1:24 |
| chorale | `chapter-19-46-chorale` | Norwegian | M5 | 1 | correct | 0/16 | 72 → 73 | 2/4, Gm | 1:21 |
| bhajan | `theme-bonn-bhajan` | English | Home Mac | 2 | correct | 7/13 | 84 → 85 | 2/4, C | 2:05 |

Lines on their notes: the lines Whisper found where the score puts them (`info.json`, `lyricsOnNotes`); it decides
how good the lead sheet is, not whether the song is kept. Meter and key: what YuE2 wrote in the song's score.

### What the probes showed

- **Norwegian and Latin passed the lyrics check** (the prayer-house song, kveding, the chorale in Norwegian;
  Gregorian chant and polyphony in Latin), but the owner wants every song in English (2026-11-02), so these
  styles are sung in English now and the language support is gone again.
- **The takes that failed** failed on words, never on style: mass choir sang its two-line bridge three times
  (take 1); reggae garbled its opening line "Down in the dungeon, feet in the stocks / Paul and Silas behind the
  locks" twice before the third take sang it; metal and bhajan each needed a second take. Short, plain opening
  lines are safer in fast or loose styles.
- **Meter is not followed.** Every probe asked for 3/4 or 6/8 (Taizé, Sacred Harp, prayer-house waltz, kveding,
  lullaby, Miriam's 6/8 dance) came out in 2/4 or 4/4,: `diversity.md` had it as not known, since meter is not one of the
  dimensions YuE2's authors test the style line on; now it is known not to work. A waltz needs a score (`abc`), as the cross hymn's strophic take did.
- **Tempo is followed** within a few BPM (median +1.5), except at the ends: the slowest asks came out faster
  (lament 52 → 72, lullaby 56 → 75, Armenian 58 → 75, ambient 60 → 70, polyphony 64 → 85) and punk 160 → 180.
  Chant held its slow tempo (Gregorian 60 → 60, Byzantine 56 → 63); songs with a beat drift up.
- **Lead sheets are weak for some styles**: rap (0 of 24 lines on their notes), the chorale (0 of 16),
  polyphony (1 of 7), the lullaby (2 of 16). Rap and counterpoint do not put one syllable on one melody note,
  so the alignment has nothing to follow; the song itself is fine, and the chord sheet is unaffected.
- **Short songs.** Baroque (1:24), Sacred Harp (1:29), polyphony (1:38) and the chorale (1:21) came out short:
  YuE2 sang each section once and added little instrumental time. The lyrics check found every line.

### Style check

`scripts/style-check.py` (CLAP `laion/clap-htsat-unfused`) listened to each probe in six 10-second windows and ranked
the descriptions of all 53 styles (`STYLES` in the script) by how close they are to the audio. The music-trained
model (`laion/larger_clap_music`) turned out not to match text to audio at all (cosine about 0 for every pair, in
transformers 4.46 and 5.22); the general model does.

**What the measure is worth.** The same check on the 187 songs of the 16 styles we had puts their own style at
rank 8 (median) of 53, in the top three for 29 % of them: rock and soul at 1, country at 2, but celtic at 23 and
orchestral at 37, styles we know the songs have. So CLAP hears broad families (rock, rap, electronic, Latin) and
not fine traditions (Sacred Harp, Coptic chant, a brass band), and its rank alone cannot drop a style.

| | own style's rank (median of 53) | own style in the top three | similarity to the nearest old song (median) |
|---|---|---|---|
| the 187 songs we had | 8 | 29 % | 0.971 (to the nearest other old song) |
| the 36 probes | 7.5 | 33 % | 0.950 |

The probes are heard as their own style at least as often as the old songs are, and they sit further from the
catalog than its songs sit from each other: they add sound it did not have. Most distinct from anything we had:
salsa (0.823), brass band (0.881), hip hop (0.908), Byzantine chant (0.898). Closest: punk (0.981, to a rock
song) and polyphony and the chorale (0.979, to an orchestral song).

| style | rank | CLAP's top three | nearest old song |
|---|---|---|---|
| hiphop | 1 | hiphop, lofi, pop | `verse-45-10-17-jazz` (0.908) |
| metal | 1 | metal, rock, country | `verse-19-27-1-rock` (0.976) |
| salsa | 1 | salsa, shanty, middle-eastern | `story-noas-ark-og-syndfloden-children` (0.823) |
| lofi | 1 | lofi, soul, hiphop | `verse-62-4-7-soul` (0.952) |
| anthem | 1 | anthem, shanty, isicathamiya | `verse-44-1-8-choral` (0.956) |
| kveding | 2 | soul, kveding, lament | `story-isaks-binding-folk` (0.956) |
| lament | 2 | soul, lament, kveding | `verse-19-127-1-worship` (0.94) |
| bedehus | 2 | country, bedehus, kveding | `story-den-fortapte-sonn-country` (0.954) |
| byzantine | 2 | isicathamiya, byzantine, lament | `verse-40-6-9-choral` (0.898) |
| isicathamiya | 3 | soul, taize, isicathamiya | `verse-4-6-24-celtic` (0.962) |
| bluegrass | 3 | bedehus, country, bluegrass | `chapter-19-100-country` (0.911) |
| punk | 3 | metal, rock, punk | `verse-19-27-1-rock` (0.981) |
| edm | 4 | soul, worship, ambient | `verse-19-103-19-pop` (0.941) |
| reggae | 5 | country, pop, bedehus | `chapter-19-150-jazz` (0.903) |
| shanty | 5 | country, soul, bedehus | `chapter-19-100-country` (0.937) |
| polyphony | 6 | soul, isicathamiya, taize | `story-skapelsen-av-verden-orchestral` (0.979) |
| middle-eastern | 7 | edm, children, soul | `verse-50-4-13-pop` (0.911) |
| ambient | 7 | soul, ballad, worship | `verse-19-130-7-jazz` (0.957) |
| lullaby | 8 | soul, worship, ballad | `verse-19-44-26-pop` (0.972) |
| southern-gospel | 9 | kveding, soul, country | `verse-40-5-3-folk` (0.961) |
| taize | 9 | isicathamiya, lament, hymn | `verse-19-85-9-celtic` (0.938) |
| bhajan | 9 | soul, armenian, isicathamiya | `verse-4-6-24-celtic` (0.936) |
| coptic | 10 | isicathamiya, gregorian, byzantine | `verse-40-6-9-choral` (0.929) |
| armenian | 12 | choral, isicathamiya, soul | `verse-43-1-1-orchestral` (0.966) |
| baroque | 13 | isicathamiya, choral, kveding | `verse-66-21-3-orchestral` (0.95) |
| childrens-choir | 13 | isicathamiya, shanty, hymn | `story-david-og-goliat-children` (0.923) |
| klezmer | 15 | bedehus, kveding, country | `verse-19-118-24-children` (0.94) |
| mass-choir | 16 | shanty, kveding, isicathamiya | `story-pinsedagen-gospel` (0.95) |
| highlife | 19 | country, children, edm | `chapter-19-100-country` (0.942) |
| gregorian | 20 | lament, kveding, isicathamiya | `verse-19-103-17-choral` (0.931) |
| chorale | 22 | soul, isicathamiya, taize | `story-skapelsen-av-verden-orchestral` (0.979) |
| spiritual | 38 | soul, armenian, isicathamiya | `theme-nade-soul` (0.949) |
| brass-band | 39 | shanty, kveding, salsa | `story-vismennene-fra-osten-orchestral` (0.881) |
| sacred-harp | 39 | kveding, folk, celtic | `verse-45-12-12-choral` (0.964) |
| spoken-word | 41 | soul, lament, worship | `verse-45-5-6-acoustic` (0.96) |
| musical | 42 | soul, lament, gospel | `verse-45-12-14-celtic` (0.965) |

Five probes rank 38 or lower: spiritual, brass band, Sacred Harp, spoken word and the musical, where CLAP hears
soul, shanty, folk or lament. That is the range the old orchestral songs sit in, so it does not drop them, but
they are the ones to listen to first.

**Why it is not a gate in the ordinary lane.** At this precision a style check that decides keep or remake would
reject good songs: with a threshold strict enough to catch a wrong style (say, own style in the top ten), it would have remade more
than half of the orchestral, celtic, jazz and pop songs we had. It
also costs CPU on the Home Mac, where Whisper already waits for CPU. It stays a script for test groups like this
one.

## Instrumental pieces

A raw YuE2 test with the lyrics only `[Intro]`, `[Instrumental]` and `[Outro]` ran at 0.3 tokens per second on
the Home Mac for two and a half hours without finishing (3,163 tokens), while every sung song in this group took
10 to 20 minutes. It was stopped. Without words, the pipeline also has nothing to check: the lyrics check, the
lead sheet and the screen view all hang on the lyrics. Instrumental pieces are left out; the instrumental side
of the breadth lives inside the songs (the brass band, the Hardanger fiddle, the oud, the klezmer clarinet).
