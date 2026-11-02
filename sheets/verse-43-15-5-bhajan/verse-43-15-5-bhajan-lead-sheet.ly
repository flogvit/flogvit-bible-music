\version "2.24.0"
\header {
  title = "I Am the Vine"
  subtitle = "John 15:5"
  tagline = ##f
  copyright = \markup \small \wordwrap { "Melody" "and" "chords" "from" "the" "score" "YuE2" "generated" "the" "song" "from" "(score.abc)." "Lyrics" "placed" "syllable" "by" "syllable" "against" "the" "recording" "with" "Whisper," "which" "heard" "90" "of" "92" "words." "12" "of" "16" "lyric" "lines" "sit" "clearly" "on" "their" "notes;" "4" "are" "uncertain" "and" "printed" "in" "grey" "italics." "Bible" "text:" "Open" "Source" "English" "(OSEN)," "CC" "BY" "4.0," "from" "SBLGNT" "and" "tanach.us." }
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
  \clef treble \key c \major \tempo 4 = 75
  \time 4/4 R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | \time 7/8 R1*7/8 | \time 4/4 R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | \sectionLabel "Verse 1" r2 r8 c''8 d''8. e''16 | e''2 r8 d''8 d''8. c''16 | c''4 a'4 r8 c''8 d''8 g''8 | e''2 r8 d''8 d''8. c''16 | c''4 r2 r8. g''16 | g''16 a''8 a''16 a''8 g''8 a''8 a''4 g''8 | e''2 r4. c''16 d''16 | e''8. d''8. d''8 e''8. d''8. c''8 | \sectionLabel "Chorus" c''4 c''4 r8 c''8 d''8 e''8 | e''2 r8 d''8 d''8 c''8 | a'4 r4. c''8 d''8 g''8 | e''4. r16 f''16 d''8 e''8 d''8 c''8 | c''4 r4. c''8 d''8 g''8 | e''2 r8 d''8 d''8 c''8 | a'4 r4. c''8 d''8 g''8 | e''4. r16 f''16 d''8 e''8 d''8 c''8 | c''4 r2. | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | \sectionLabel "Verse 2" r2. g''8 a''8 | c'''8. c'''8. a''8 g''4 e''4 | r8 e''8 d''8 c''8 a'4 c''4 | r8 e''8 d''8 c''8 d''8. d''8. c''8 | d''8 g''16 e''4. r8. d''8 e''8 | g''4. e''16 d''16 d''4 c''4 | \sectionLabel "Chorus" c''2 r8 c''8 d''8 g''8 | e''2 r8 d''8 d''8 c''8 | a'4 r4. c''8 d''8 g''8 | e''2 d''4 d''8 c''8 | c''4 r4. c''8 d''8 g''8 | e''2 r8 d''8 d''8 c''8 | a'4 r4. c''8 d''8 g''8 | e''2 d''4 d''8 c''8 | c''4 r2. | \sectionLabel "Outro" R1*1 | R1*1 | R1*1 |
  \bar "|."
}
harmony = \chordmode { c1*95/8 c1*5 f1 c1 g1 c1*2 a1:m f1*1/2 g1*1/2 c1*2 a1:m f1*1/2 g1*1/2 c1*2 a1:m f1*1/2 g1*1/2 c1*2 a1:m f1*1/2 g1*1/2 c1*2 a1:m f1*1/2 g1*1/2 c1 g1 c1*2 a1:m f1*1/2 g1*1/2 c1*2 a1:m f1*1/2 g1*1/2 c1 c1*3 }
words = \lyricmode { \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "I" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "am" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "the" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "vine," \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "you" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "are" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "the" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "branch" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "es" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "A" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "bide" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "in" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "me," \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "and" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "I" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "in" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "you" "Who" -- "ev" -- "er" "a" -- "bides" "in" "me" "bears" "much" "fruit" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "For" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "a" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "part" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "from" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "me" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "you" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "can" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "do" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "noth" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "ing" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "A" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "bide" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "in" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "me," \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "a" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "bide" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "in" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "me" "A" -- "bide" _ "in" "my" "love" _ _ _ _ "A" -- "bide" "in" "me," "a" -- "bide" "in" "me" "A" -- "bide" "in" "my" "love" _ _ _ _ _ "As" "the" "Fa" -- "ther" "has" "loved" "me" "So" "have" "I" "loved" "you" "By" "this" "my" "Fa" -- "ther" "is" "glo" -- "ri" -- "fied" "That" "you" "bear" "much" "fruit" _ _ _ "A" -- "bide" "in" "me," "a" -- "bide" "in" "me" "A" -- "bide" "in" "my" "love" _ _ _ "A" -- "bide" "in" "me," "a" -- "bide" "in" "me" "A" -- "bide" "in" "my" "love" _ _ _ }
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
