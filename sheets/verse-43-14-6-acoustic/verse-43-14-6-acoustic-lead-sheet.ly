\version "2.24.0"
\header {
  title = "Many Rooms"
  subtitle = "John 14:1–6"
  tagline = ##f
  copyright = \markup \small \wordwrap { "Melody" "and" "chords" "from" "the" "score" "YuE2" "generated" "the" "song" "from" "(score.abc)." "Lyrics" "placed" "syllable" "by" "syllable" "against" "the" "recording" "with" "Whisper," "which" "heard" "224" "of" "225" "words." "All" "28" "lyric" "lines" "sit" "on" "their" "notes." "Bible" "text:" "Open" "Source" "English" "(OSEN)," "CC" "BY" "4.0," "from" "SBLGNT" "and" "tanach.us." }
}
\paper {
  #(set-paper-size "a4")
  top-margin = 12\mm
  bottom-margin = 12\mm
  left-margin = 14\mm
  right-margin = 14\mm
  system-system-spacing.basic-distance = #14
  markup-system-spacing.basic-distance = #8
}
melody = {
  \clef treble \key es \major \tempo 4 = 75
  \partial 2 r4. r8 | \time 4/4 R1*1 | R1*1 | R1*1 | \sectionLabel "Verse 1" r2 r8. bes16 es'8 f'8 | g'4 r4 r8 f'16 g'16 f'8 es'8 | es'8 r4. r8. es'16 g'8 bes'8 | c''8. bes'8. r8 r8 es'16 es'8 g'8. ~ | g'16 r16 g'8 r4 r8. bes16 es'16 g'8. | g'4 r4 r8 f'16 g'16 f'8. es'16 | es'8 r4. r8. bes16 es'8 d'8 | c'8. es'8 g'8. f'4 es'8. es'16 | \sectionLabel "Chorus" es'16 r4. r16 r4 g'16 bes'8. | c''4 c''4 c''4 bes'8. bes'16 ~ | bes'8 g'8 r4 r4 g'8 bes'8 | c''16 c''16 r4. r8 bes'16 bes'8 g'8 f'16 ~ | f'8 r4. r16 es'16 es'8 g'16 bes'8. | c''4 r4 r16 c''8 c''16 c''16 bes'8 g'16 ~ | g'8. r4 r16 r8 g'8 g'8 f'16 f'16 | es'8. es'8 g'8 f'16 f'8. f'8. es'16 es'16 ~ | es'8 r4. r2 | R1*1 | R1*1 | R1*1 | \sectionLabel "Verse 2" r2 r8. bes16 es'16 g'8 g'16 ~ | g'8 r4. r16 bes16 f'16 g'16 f'16 es'16 es'8 | r2 r8. bes16 g'8 bes'8 | c''8. bes'16 as'8 r8 r8 es'16 es'8 g'8. ~ | g'16 r16 g'4 r8 r4 es'16 es'16 g'8 | g'4 r8. bes16 bes'8 bes'16 bes'16 ~ bes'16 c''8. ~ | c''16 r16 g'4 r8 r8 f'16 g'16 g'16 f'8 es'16 ~ | es'8 r4. r16 bes16 f'16 g'16 f'4 ~ | \sectionLabel "Chorus" f'8 es'4 r8 r4 g'16 bes'8. | c''4 c''4 c''4 bes'8. bes'16 ~ | bes'8 g'8 r4 r4 g'8 bes'8 | c''16 c''16 r4. r8 bes'16 bes'8 g'16 f'16 f'16 ~ | f'8. r4 r16 r16 es'16 es'8 g'16 bes'8. | c''4 r4 r16 c''8 c''16 c''16 bes'8 g'16 ~ | g'8. r4 r16 r8 g'8 g'8 f'16 f'16 | es'8. es'8 g'8 f'16 f'8. f'8. es'16 es'16 ~ | es'8. r4 r16 r2 | \sectionLabel "Verse 3" r8 c''8 c''16 c''8 c''16 ~ c''8 bes'16 bes'8. g'16 g'16 ~ | g'8 r4. r2 | r8 bes'16 c''16 c''16 c''8 c''16 ~ c''8 bes'16 bes'16 bes'16 g'8 g'16 ~ | g'8 r4. r2 | c''8 c''16 c''8 c''8 c''16 ~ c''8 bes'16 bes'8 g'8 g'16 ~ | g'8 f'16 es'8. r8 r2 | r8 g'8 g'8 f'16 f'16 ~ f'4 ~ f'16 r16 es'16 es'16 ~ | \sectionLabel "Bridge" es'8 r4. r8 g'8 g'8 f'16 f'16 | es'8. es'8 g'8. f'8. f'8. es'16 es'16 ~ | es'8 r4. r4 g'16 f'8 f'16 | es'4 es'16 g'8 g'16 ~ g'16 f'16 f'16 f'8 es'8. ~ | \sectionLabel "Chorus" es'16 r16 es'8 r4 r4 g'16 bes'8. | c''4 c''4 c''4 bes'8. bes'16 ~ | bes'8 g'8 r4 r4 g'8 bes'8 | c''2 r16 bes'16 bes'16 bes'8 g'8 f'16 ~ | f'8. r4 r16 r16 es'16 es'8 g'16 bes'8. | c''4 r4 r16 c''8 c''16 c''16 bes'8 g'16 ~ | g'8. r4 r16 r8 g'8 g'8 f'16 f'16 | es'8. es'8 g'8 f'16 f'8. f'8. es'16 es'16 ~ | \sectionLabel "Outro" es'8. r4 r16 r4 g'16 bes'8. | c''4 c''4 c''4 bes'8. bes'16 ~ | bes'8 g'16 f'8. r8 r4 g'8 f'16 f'16 | es'4 r4 r8 g'8 f'8 es'8 ~ | es'8 es'4 r8 r2 | \time 2/4 R1*1/2 |
  \bar "|."
}
harmony = \chordmode { s1*3/8 es1*7/8 bes1*1/4/d c1*3/4:m7 bes1*1/4/d es1*3/4 bes1*1/4/d c1:m7 es1*3/4 bes1*1/4/d c1:m7 as1:maj7 es1*7/4 bes1*1/4/d c1:m7 as1*1/2:maj7 bes1*1/2 es1 as1 es1 c1:m7 bes1 as1 c1:m7 as1*1/2 bes1*1/2 es1*7/4 bes1*1/4/d c1:m7 es1*3/4 bes1*1/4/d c1:m7 es1*3/4 bes1*1/4/d c1:m7 as1 es1*7/4 bes1*1/4/d c1:m7 as1 es1 as1 es1 c1:m7 bes1 as1 c1:m7 as1*1/2 bes1*1/2 es1 as1 c1:m7 as1 c1:m7 as1 c1:m7 as1*1/2 bes1*1/2 es1 as1*1/2 bes1*1/2 c1:m7 as1*1/2 bes1*1/2 es1 as1 es1 c1:m7 bes1 as1 c1:m7 as1*1/2 bes1*1/2 es1 as1 es1 as1*1/2 bes1*1/2 es1*3/2 }
words = \lyricmode { "The" "lamps" "were" "low" "in" "the" "up" -- "per" "room" "The" "bread" "was" "bro" -- "ken," "the" "night" "came" "soon" "He" "told" "his" "friends" "that" "he" "had" "to" "go" "Their" _ "fa" -- "ces" "fell" "and" "their" "hearts" "sank" "low" "Do" "not" "let" "your" "hearts" "be" "trou" -- "bled" "Trust" "in" "God," "and" \skip 1 "trust" "in" "me" "In" "my" "Fa" -- "ther's" "house" "there" "are" "ma" -- "ny" "rooms" "I" _ _ "am" "the" "way" "and" "the" "truth" "and" "the" "life" "I" "go" "a" -- "head" "to" "make" "it" "rea" -- "dy" "there" "A" _ "place" "for" "you," "pre" -- \skip 1 "pared" "with" "care" "I" "will" "come" "back" "and" "take" "you" "to" "my" -- "self" "So" "that" "where" "I" "am," "you" "may" "be" "al" -- "so" "Do" "not" "let" "your" "hearts" "be" "trou" -- "bled" "Trust" _ "in" "God," \skip 1 "and" "trust" "in" "me" "In" "my" "Fa" -- "ther's" "house" "there" "are" "ma" -- "ny" "rooms" "I" _ _ "am" "the" "way" "and" "the" "truth" "and" "the" "life" "Then" "Tho" -- "mas" "spoke" "for" "all" "the" "rest" "With" "a" "wor" -- "ried" "heart" "and" "an" "hon" -- "est" "guess" "Lord," _ "we" "do" "not" "know" "where" "you" "are" "go" -- "ing" "How" "can" "we" "know" "the" "way?" "I" _ "am" "the" "way" "and" "the" "truth" "and" "the" "life" "No" _ "one" "comes" "to" "the" "Fa" -- "ther" "ex" -- "cept" "through" "me" "Do" "not" "let" "your" "hearts" "be" "trou" -- "bled" "Trust" "in" "God," "and" "trust" "in" "me" _ "In" "my" "Fa" -- "ther's" "house" "there" "are" "ma" -- "ny" "rooms" "I" _ _ "am" "the" "way" "and" "the" "truth" "and" "the" "life" "Do" _ "not" "let" "your" "hearts" "be" "trou" -- "bled" "Trust" "in" "God," "and" \skip 1 "trust" "in" "me" }
\score {
  <<
    \new ChordNames \with { majorSevenSymbol = \markup { "maj7" } } \harmony
    \new Staff \new Voice = "melody" \melody
    \new Lyrics \lyricsto "melody" \words
  >>
  \layout {
    indent = 0
    \context { \Lyrics
      \override LyricSpace.minimum-distance = #1.6
      \override LyricHyphen.minimum-distance = #1.4
    }
  }
}
