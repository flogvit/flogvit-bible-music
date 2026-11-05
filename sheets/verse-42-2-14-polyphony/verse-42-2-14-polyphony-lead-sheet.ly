\version "2.24.0"
\header {
  title = "And on Earth Peace"
  subtitle = "Luke 2:14"
  tagline = ##f
  copyright = \markup \small \wordwrap { "Melody" "and" "chords" "from" "the" "score" "YuE2" "generated" "the" "song" "from" "(score.abc)." "Lyrics" "placed" "syllable" "by" "syllable" "against" "the" "recording" "with" "Whisper," "which" "heard" "58" "of" "58" "words." "8" "of" "9" "lyric" "lines" "sit" "clearly" "on" "their" "notes;" "1" "are" "uncertain" "and" "printed" "in" "grey" "italics." "Bible" "text:" "Open" "Source" "English" "(OSEN)," "CC" "BY" "4.0," "from" "SBLGNT" "and" "tanach.us." }
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
  \clef treble \key c \major \tempo 4 = 90
  \time 3/4 \sectionLabel "Intro" R1*3/4 | R1*3/4 | R1*3/4 | R1*3/4 | R1*3/4 | R1*3/4 | R1*3/4 | R1*3/4 | R1*3/4 | c''4 g''4 g''8 e''8 | e''4 f''4 g''4 | c'''4 b''4 a''8 b''16 a''16 | \sectionLabel "Verse 1" g''2 e''8 f''8 | g''4 e''4 d''8 e''16 d''16 | c''4 b'4 a'4 | g'2 c''4 | c''2 r4 | c''4 g''4 g''8 e''8 | e''4 f''4 g''4 | c'''4 b''4 a''8 b''16 a''16 | \sectionLabel "Verse 2" g''2 e''8 f''8 | g''4 e''4 d''8 e''16 d''16 | c''4 b'4 a'4 | g'2 c''4 | c''2 r4 | c'''2 b''8 c'''16 b''16 | a''2 g''8 a''16 g''16 | e''4 f''4 g''4 | \sectionLabel "Verse 3" c'''4 b''4 a''8 b''16 a''16 | g''2 e''8 f''8 | g''4 e''4 d''8 e''16 d''16 | c''4 b'4 a'4 | g'2 c''4 | c''2 r4 | c'''2 b''8 c'''16 b''16 | a''2 g''8 a''16 g''16 | e''4 f''4 g''4 | \sectionLabel "Outro" c'''4 b''4 a''8 b''16 a''16 | g''2 e''8 f''8 | g''4 e''4 d''8 e''16 d''16 | c''4 b'4 a'4 | g'2 c''4 | \sectionLabel "Outro" c''4 g''4 g''8 e''8 | e''4 f''4 g''4 | c'''4 b''4 a''8 b''16 a''16 | g''2 r4 | R1*3/4 | R1*3/4 |
  \bar "|."
}
harmony = \chordmode { s1*5/8 c1*67/8 c1*6 c1*9/2 f1*3/4 c1*3/4 c1*21/4 f1*3/4 c1*3/4 c1*15/4 c1*9/2 }
words = \lyricmode { \skip 1 \skip 1 \skip 1 \skip 1 \skip 1 \skip 1 \skip 1 \skip 1 \skip 1 \skip 1 \skip 1 \skip 1 \skip 1 \skip 1 "Glo" -- "ry" "to" "God" "in" "the" "high" -- "est" "And" "on" "earth" "peace" "To" "those" "on" "whom" "his" "fa" -- "vor" "rests" _ _ _ _ _ _ "Glo" -- "ry" "to" "God" "in" "the" "high" -- "est" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "And" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "on" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "earth" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "peace" "To" "those" "on" "whom" "his" "fa" -- "vor" "rests" _ _ _ _ _ _ _ "Glo" -- "ry," "glo" -- "ry" "to" _ "God" "in" "the" "high" -- "est" "And" "on" "earth" "peace" "to" "all" "who" "miss" "fa" -- "vor" "and" "stress" _ _ _ _ _ _ "Glo" -- "ry" "to" _ "God" "in" "the" "high" -- "est" _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ }
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
