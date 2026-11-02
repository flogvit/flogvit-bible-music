\version "2.24.0"
\header {
  title = "I dag er det født dere en frelser"
  subtitle = "Luke 2:11"
  tagline = ##f
  copyright = \markup \small \wordwrap { "Melody" "and" "chords" "from" "the" "score" "YuE2" "generated" "the" "song" "from" "(score.abc)." "Lyrics" "placed" "syllable" "by" "syllable" "against" "the" "recording" "with" "Whisper," "which" "heard" "95" "of" "100" "words." "All" "16" "lyric" "lines" "sit" "on" "their" "notes." "Bibeltekst:" "Open" "Source" "Norsk" "Bokmål" "(OSNB)," "CC" "BY" "4.0," "fra" "SBLGNT" "og" "tanach.us." }
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
  \clef treble \key f \major \tempo 4 = 85
  \time 4/4 R1*1 | R1*1 | R1*1 | R1*1 | \time 9/8 \sectionLabel "Verse 1" r2 r4. c''8 c''8 | \time 4/4 a''4. a''8 g''8 a''8 g''8 f''8 | f''4 d''4 r8 d''8 e''8 f''8 | d''4 bes''4 a''4. f''16 g''16 | g''4 r4. c''8 c''8 c''8 | a''4 a''4 g''8 a''8 g''8 f''8 | d''4 r4. d''8 e''8 f''8 | d''4 bes''4 a''4. f''16 g''16 | \sectionLabel "Verse 2" g''4 r4. c'''8 c'''8 c'''8 | d'''4 f''4 e''4 c'''4 | c'''4 a''4 r8 f''8 g''8 a''8 | bes''4 d''4 c''4 bes''4 | a''2 r8 c'''8 c'''8 c'''8 | d'''4 f''4 e''4 c'''4 | a''2 r8 f''8 g''8 a''8 | bes''4 d''4 e''4 g''4 | \sectionLabel "Verse 3" f''2 r8 c'''8 c'''8 c'''8 | d'''4 f''4 e''8 f''8 g''8 c'''8 | c'''4 a''4 r8 f''8 g''8 a''8 | bes''4 d''4 c''8 c''8 bes''8 bes''8 | a''2 r8 c'''8 c'''8 c'''8 | d'''4 f''4 e''8 f''8 g''8 c'''8 | c'''8. a''16 a''4 r8 f''8 g''8 a''8 | bes''4 d''4 e''4 g''4 | g''4 f''4 r2 | \sectionLabel "Verse 4" a''8 a''8 a''8 a''8 g''4 g''8 f''8 | f''8 d''8 d''4 r8 d''8 e''8 f''8 | d''4 bes''4 a''4. f''16 g''16 | g''2 r4. c''8 | a''8 a''8 a''8 a''8 g''4 g''8 f''8 | f''4 d''4 r4 e''8 f''8 | d''4 bes''4 a''4. f''16 f''16 | \time 9/8 g''2 f''2 ~ f''8 ~ | \time 4/4 f''2 r2 |
  \bar "|."
}
harmony = \chordmode { s1*7/8 f1*5/8 c1*1/2/e d1*1/2:m c1*1/2:6 bes1*1/2 f1*1/2/a g1*1/2:m7 c1*5/8 f1*1/2 c1*1/2/e d1:m bes1*1/2 f1*1/2/a c1 f1*1/2 c1*1/2/e d1:m bes1*1/2 f1*1/2/a c1 bes1*1/2 c1*1/2 f1*1/2 d1*1/2:m g1*1/2:m c1*1/2 f1 bes1*1/2 c1*1/2 d1:m bes1*1/2 c1*1/2 f1 bes1*1/2 c1*1/2 f1 g1*1/2:m c1*1/2 f1 bes1*1/2 c1*1/2 d1:m bes1*1/2 c1*1/2 f1 f1*1/2 c1*1/2/e d1:m bes1*1/2 f1*1/2 c1 f1*1/2 c1*1/2/e d1:m bes1*1/2 c1 f1*13/8 }
words = \lyricmode { "Det" _ "var" "noen" "gje" -- "te" -- "re" "på" "mar" -- "ken" "som" _ "vok" -- "tet" "flok" -- "ken" "sin" "om" "natt" "Da" "sto" "en" "Her" -- "rens" "en" -- "gel" "fo" -- "ran" "dem" "og" _ "ly" -- "set" "strål" -- "te" "o" -- "ve" -- "ralt" "Frykt" "ik" -- "ke," "se," "jeg" "brin" -- "ger" "gle" -- "de" "en" "gle" -- "de" "for" "det" "he" -- "le" "folk" "I" "dag" "er" "født" "i" "Da" -- "vids" "by" "en" "frel" -- "ser," "Kris" -- "tus," "Her" -- "ren" "vår" "Og" "det" -- "te" "skal" "for" "de" -- "re" "væ" -- "re" "teg" -- "net" "et" "barn" "som" "lig" -- "ger" "i" "en" "kryb" -- "be" "svøpt" "Og" "him" -- "me" -- "lens" "hær" "sang" "sam" -- "men" "med" "en" -- "ge" -- "len" "med" "lov" -- "sang" "o" -- "ver" "jor" -- "den" "løf" -- "tet" "Æ" -- "re" _ "væ" -- "re" "Gud" "i" "det" "høyes" -- "te" "og" "fred" "på" "jor" -- "den," "fred" "i" "kveld" _ "blant" "men" -- "nes" -- "ker" "som" "Gud" "har" "be" -- "hag" "i" "syng" "med," "al" -- "le," "syng" "i" "kveld" _ _ }
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
