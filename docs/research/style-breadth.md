# Style breadth

The owner's order, 2026-11-01: the songs are pleasant and stay as they are, but Christian music comes in far more
styles than the catalog has. Widen it to as many styles as possible, and make just enough songs per style to cover
it well, no more.

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
house), rap, and old, raw voices (lament, kveding). Tempo: 50 to 160 BPM. Language: Norwegian (prayer house,
kveding, chorale; quotes from `osnb`) and Latin (Gregorian, polyphony, one Taizé chant; quotes from the
Clementine Vulgate, `vulgate`).

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
all 139 songs: 36 probes and 103 more.

## Probe results

<!-- filled in as the probes finish -->

## Instrumental pieces

<!-- filled in after the YuE test -->
