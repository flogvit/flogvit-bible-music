\version "2.24.0"
\header {
  title = "Hosanna in the Temple"
  subtitle = "Matthew 21:15–16"
  tagline = ##f
  copyright = \markup \small \wordwrap { "Melody" "and" "chords" "from" "the" "score" "YuE2" "generated" "the" "song" "from" "(score.abc)." "Lyrics" "placed" "syllable" "by" "syllable" "against" "the" "recording" "with" "Whisper," "which" "heard" "85" "of" "85" "words." "All" "16" "lyric" "lines" "sit" "on" "their" "notes." "Bible" "text:" "Open" "Source" "English" "(OSEN)," "CC" "BY" "4.0," "from" "SBLGNT" "and" "tanach.us." }
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
  \clef treble \key c \major \tempo 4 = 120
  \time 2/4 R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | \sectionLabel "Verse 1" r4. c''8 | c''4 e''8 g''8 | a''4 f''8 e''8 | d''4 e''8 f''8 | e''4 c''4 | r4 c'''8 a''8 | g''4 c''4 | d''2 | r4. c''8 | c''4 e''4 | a''4 r8 f''8 | d''4 e''8 f''8 | e''4 r8 c''16 c''16 | f''4 a''4 | g''4. b'8 | c''2 | \sectionLabel "Chorus" r4. g''8 | g''8. e''8. g''8 | a''8. f''8. a''8 | g''8 g''8 f''8 d''8 | e''8 d''16 c''8 c''16 g''8 | g''8. e''8. g''8 | a''8. f''8. a''8 | g''8 g''8 f''8 d''8 | e''8 d''16 c''8 c''8 r16 | R1*1/2 | \sectionLabel "Verse 2" r4. c''16 c''16 | c''4 e''4 | a''4 f''4 | d''4 g''4 ~ | g''4 r4 | r8 c'''8 c'''8 a''8 | g''4 c''4 | d''2 | r8 e''8 e''8 d''8 | c''4 e''4 | a''8. f''8. f''8 | d''4 f''4 | e''8. c''8. r8 | f''4 a''4 | g''4 b'4 | c''2 ~ | \sectionLabel "Chorus" c''4 r8 g''8 | g''8. e''8. g''8 | a''8. f''8. a''8 | g''8 g''8 f''8 d''8 | e''8 d''16 c''8 c''16 g''8 | g''8. e''8. g''8 | a''8. f''8. a''8 | g''8 g''8 f''8 d''8 | e''8 d''16 c''8 c''16 r8 | R1*1/2 | R1*1/2 |
  \bar "|."
}
harmony = \chordmode { s1*3/8 c1*5/8 f1*1/2 g1*1/2 c1 f1*1/2 g1*1/2 c1*1/2 f1*1/2 c1*1/2 g1 c1*1/2 f1*1/2 g1*1/2 c1*1/2 f1*1/2 g1*1/2 c1*1/2 c1 f1*1/2 g1*1/2 c1 f1*1/2 g1*1/2 c1 c1 f1*1/2 g1 f1*1/2 c1*1/2 g1 c1*1/2 f1*1/2 g1*1/2 c1*1/2 f1*1/2 g1*1/2 c1*1/2 c1 f1*1/2 g1*1/2 c1 f1*1/2 g1*1/2 c1*3/2 }
words = \lyricmode { "The" "blind" "and" "the" "lame" "came" "to" "him" "in" "the" "tem" -- "ple" "And" "he" "healed" "them" "there" "The" "chief" "priests" "saw" "the" "won" -- "der" -- "ful" "things" "And" "the" "chil" -- "dren" "cry" -- "ing" "out" "Ho" -- "san" -- "na," "ho" -- "san" -- "na" "Ho" -- "san" -- "na" "to" "the" "Son" "of" "Da" -- "vid" "Ho" -- "san" -- "na," "ho" -- "san" -- "na" "Ho" -- "san" -- "na" "to" "the" "Son" "of" "Da" -- "vid" "Do" "you" "hear" "what" "these" "are" "say" -- "ing" "Yes," "have" "you" "ne" -- "ver" "read" "Out" "of" "the" "mouth" "of" "in" -- "fants" "and" "nurs" -- "ing" "ba" -- "bies" "You" "have" "pre" -- "pared" "praise" "Ho" -- "san" -- "na," "ho" -- "san" -- "na" "Ho" -- "san" -- "na" "to" "the" "Son" "of" "Da" -- "vid" "Ho" -- "san" -- "na," "ho" -- "san" -- "na" "Ho" -- "san" -- "na" "to" "the" "Son" "of" "Da" -- "vid" }
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
