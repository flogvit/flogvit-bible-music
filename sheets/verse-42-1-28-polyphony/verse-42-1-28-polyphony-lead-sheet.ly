\version "2.24.0"
\header {
  title = "Ave Gratia Plena"
  subtitle = "Luke 1:28"
  tagline = ##f
  copyright = \markup \small \wordwrap { "Melody" "and" "chords" "from" "the" "score" "YuE2" "generated" "the" "song" "from" "(score.abc)." "Lyrics" "placed" "syllable" "by" "syllable" "against" "the" "recording" "with" "Whisper," "which" "heard" "29" "of" "29" "words." "7" "of" "9" "lyric" "lines" "sit" "clearly" "on" "their" "notes;" "2" "are" "uncertain" "and" "printed" "in" "grey" "italics." "Bible" "text:" "the" "Clementine" "Vulgate" "(public" "domain)." }
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
  \clef treble \key es \major \tempo 4 = 68
  \time 2/4 \sectionLabel "Intro" R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | \sectionLabel "Verse 1" g''4 g''4 | f''8 g''16 as''16 g''8 f''8 | es''8 f''16 g''16 f''8 es''8 | c''4. r8 | bes'8 es''8 es''8 f''16 g''16 | f''4 g''8 as''16 g''16 | f''16 es''16 es''4. ~ | es''4. r8 | \sectionLabel "Verse 2" g''4 g''4 | f''8 g''16 as''16 g''8 f''8 | es''8 f''16 g''16 f''8 es''8 | c''4. r8 | bes'8 es''8 es''8 f''16 g''16 | f''4 g''8 as''16 g''16 | f''16 es''16 es''4. ~ | es''4. r8 | \sectionLabel "Verse 3" c'''8 c'''8 c'''8 d'''16 es'''16 | d'''4 bes''4 | g''8. as''16 g''8 f''8 | es''4 r8 bes''8 | c'''8 c'''8 c'''8 d'''16 es'''16 | d'''4 bes''4 | c'''4 c'''4 | c'''4 c'''8 r8 | \sectionLabel "Outro" as''4 g''4 | f''2 | f''8 es''4. ~ | es''2 ~ | es''2 ~ | es''2 ~ | es''8 r4. | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 |
  \bar "|."
}
harmony = \chordmode { s1*1/4 es1*17/4 es1*1/2 bes1*1/2 c1*1/4:m bes1*1/4:6 as1*1/2 es1*1/2 bes1*1/2 as1 es1*1/2 bes1*1/2 c1*1/4:m bes1*1/4:6 as1*1/2 es1*1/2 bes1*1/2 as1 c1*1/2:m bes1*1/2 es1*1/2 as1*1/2 c1*1/2:m bes1*1/2 as1 as1 es1*11/2 }
words = \lyricmode { "A" -- "ve," _ "gra" -- "ti" -- "a" "ple" -- "na" "Do" -- "mi" -- "nus" "te" -- "cum" "be" -- "ne" -- "dic" -- "ta" _ "tu" "in" "mu" -- "li" -- "e" -- "ri" -- "bus" "A" -- "ve," "gra" -- "ti" -- "a" "ple" -- "na" _ "Do" -- "mi" -- "nus" "te" -- "cum" "be" -- "ne" -- "dic" -- "ta" _ "tu" "in" "mu" -- "li" -- "e" -- "ri" -- "bus" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "Be" -- _ \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "ne" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "dic" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "ta" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "tu" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "in" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "ter" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "mu" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "li" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "e" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "res" "et" _ "be" -- "ne" -- "dic" -- "tus" "fruc" -- "tus" "ven" -- "tris" "tu" -- "i" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "Do" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "mi" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "nus" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "te" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "cum" }
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
