\version "2.24.0"
\header {
  title = "Ave Gratia Plena"
  subtitle = "Luke 1:28"
  tagline = ##f
  copyright = \markup \small \wordwrap { "Melody" "and" "chords" "from" "the" "score" "YuE2" "generated" "the" "song" "from" "(score.abc)." "Lyrics" "placed" "syllable" "by" "syllable" "against" "the" "recording" "with" "Whisper," "which" "heard" "41" "of" "48" "words." "5" "of" "9" "lyric" "lines" "sit" "clearly" "on" "their" "notes;" "4" "are" "uncertain" "and" "printed" "in" "grey" "italics." "Bible" "text:" "Open" "Source" "English" "(OSEN)," "CC" "BY" "4.0," "from" "SBLGNT" "and" "tanach.us." }
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
  \clef treble \key bes \major \tempo 4 = 68
  \time 2/4 \sectionLabel "Intro" R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | bes'4 f''4 ~ | \sectionLabel "Verse 1" f''4 d''8 es''8 | d''8 c''8 d''4 | bes'4 r8 bes'8 | es''4 d''8 c''8 | d''4 bes'4 | R1*1/2 | bes'8 c''8 d''8 f''8 ~ | f''4 d''8 c''8 | c''16 bes'8. r4 | R1*1/2 | \sectionLabel "Verse 2" bes''4 f'''4 | d'''8 es'''8 d'''8 c'''8 | d'''4 bes''4 | r8 bes''8 es'''4 | d'''8 c'''8 d'''4 | bes''4 r4 | r4 bes''8 c'''8 | d'''8 f'''4. | \time 3/8 d'''8 c'''8 c'''16 bes''16 ~ | \time 2/4 bes''4. r8 | R1*1/2 | \sectionLabel "Verse 3" bes'8 c''8 d''8 f''8 ~ | f''4 d''8 c''8 | c''16 bes'8. r4 | r4. bes'8 | es''8. d''16 c''8. bes'16 | c''8. d''8. c''8 | bes'4 f''4 | bes''4 a''4 | g''2 | f''2 | \sectionLabel "Outro" r4 f''4 | bes''4 a''4 | g''2 | f''2 | \sectionLabel "Outro" r8 bes'8 d''8 f''8 | a''2 | g''2 ~ | g''2 | R1*1/2 | R1*1/2 |
  \bar "|."
}
harmony = \chordmode { bes1*4 es1*7/4 bes1*1/4 bes1*3/2 es1*1/2 bes1*2 es1 bes1*7/4 es1*1/2 bes1 g1*7/8:m7 f1*1/4 es1 es1*1/4 g1*3/4:m7 es1*3/2 f1*1/2 bes1 es1 bes1 es1 g1*1/2:m7 f1*1/2 es1*2 }
words = \lyricmode { \skip 1 \skip 1 "Greet" -- "ings," "you" "who" "are" "fa" -- "vored" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "The" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "Lord" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "is" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "with" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "you" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "Blessed" _ \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "are" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "you" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "a" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "mong" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "wom" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "en" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "Greet" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "ings," \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "you" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "who" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "are" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "fa" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "vored" _ "The" _ "Lord" "is" "with" "you" "Blessed" _ "are" "you" "a" -- "mong" "wom" -- "en" "Blessed" "are" "you" "a" -- "mong" "wom" -- "en" _ "And" "blessed" "is" "the" "fruit" "of" "your" "womb" _ _ _ _ _ _ \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "The" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "Lord" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "is" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "with" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "you" \skip 1 \skip 1 \skip 1 \skip 1 \skip 1 }
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
