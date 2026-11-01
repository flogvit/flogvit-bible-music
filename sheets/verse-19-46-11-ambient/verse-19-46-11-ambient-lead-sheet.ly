\version "2.24.0"
\header {
  title = "Be Still"
  subtitle = "Psalms 46:11"
  tagline = ##f
  copyright = \markup \small \wordwrap { "Melody" "and" "chords" "from" "the" "score" "YuE2" "generated" "the" "song" "from" "(score.abc)." "Lyrics" "placed" "syllable" "by" "syllable" "against" "the" "recording" "with" "Whisper," "which" "heard" "66" "of" "68" "words." "All" "13" "lyric" "lines" "sit" "on" "their" "notes." "Bible" "text:" "Open" "Source" "English" "(OSEN)," "CC" "BY" "4.0," "from" "SBLGNT" "and" "tanach.us." }
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
  \clef treble \key es \major \tempo 4 = 70
  \time 4/4 R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | \sectionLabel "Verse 1" r2. bes'4 | g''4 r2 r8. bes'16 | as''4 g''8 f''4. es''4 ~ | es''8 c''4 r2 r8 | r2. bes'4 | g''4 r2 r8. bes'16 | as''4 g''8 f''4. es''4 ~ | es''8 c''4 r2 r8 | \sectionLabel "Chorus" r2 as''8 g''16 f''8. es''8 | f''4 f''4. es''16 f''8. g''16 g''16 ~ | g''8 c''4 r8 as''8 g''16 f''8. es''8 | f''4 f''4 g''4 es''8 c''8 ~ | c''8 r2. r8 | R1*1 | \sectionLabel "Verse 2" r4. r16 bes'16 bes'8 es''4 f''8 ~ | f''4 es''8 f''4 g''4 r8 | r4. r16 bes'16 bes'8 es''4 f''8 ~ | f''8 es''4 as''4 g''8 f''8 f''8 ~ | f''8 g''2 r4. | r2. bes'4 | g''4 r2 r8. bes'16 | as''4 g''8 f''4. es''4 ~ | es''8 es''2. ~ es''8 ~ | \sectionLabel "Chorus" es''2 as''8 g''16 f''8. es''8 | f''4 f''4. es''16 f''8. g''16 g''16 ~ | g''8 c''4 r8 as''8 g''16 f''8. es''8 | f''4 f''4 g''4 es''8 c''8 ~ | c''4 r2. | R1*1 | R1*1 | \sectionLabel "Outro" r2. bes'4 | g''2 r2 | R1*1 |
  \bar "|."
}
harmony = \chordmode { es1*7 es1*3 as1*2:maj7 es1*2 as1:maj7 as1:maj7 bes1 as1:maj7 bes1 as1*2:maj7 es1 bes1/d c1:m7 as1:maj7 es1 bes1/d c1:m7 as1:maj7 es1 es1 bes1 as1:maj7 bes1 as1*2:maj7 es1 es1*3 }
words = \lyricmode { "Be" "still" "And" "know" "that" "I" "am" "God" "Be" "still" "And" "know" "that" "I" "am" "God" "I" "will" "be" "ex" -- "alt" -- "ed" "a" -- "mong" "the" "na" -- "tions" "I" "will" "be" "ex" -- "alt" -- "ed" "in" "the" "earth" "The" "Lord" "of" "hosts" "is" "with" "us" "The" "God" "of" "Ja" -- "cob" "is" "our" "for" -- "tress" _ "Be" "still" "And" "know" "that" "I" "am" "God" "I" "will" "be" "ex" -- "alt" -- "ed" "a" -- "mong" "the" "na" -- "tions" "I" "will" "be" "ex" -- "alt" -- "ed" "in" "the" "earth" "Be" "still" }
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
