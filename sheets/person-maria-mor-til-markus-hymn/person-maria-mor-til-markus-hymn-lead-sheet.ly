\version "2.24.0"
\header {
  title = "Many Had Gathered"
  subtitle = "Acts 12:12–14"
  tagline = ##f
  copyright = \markup \small \wordwrap { "Melody" "and" "chords" "from" "the" "score" "YuE2" "generated" "the" "song" "from" "(score.abc)." "Lyrics" "placed" "syllable" "by" "syllable" "against" "the" "recording" "with" "Whisper," "which" "heard" "81" "of" "83" "words." "13" "of" "18" "lyric" "lines" "sit" "clearly" "on" "their" "notes;" "5" "are" "uncertain" "and" "printed" "in" "grey" "italics." }
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
  \clef treble \key c \major \tempo 4 = 72
  \time 4/4 \sectionLabel "Intro" R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | \sectionLabel "Verse 1" r4 e''8 g''16 a''16 a''4 g''8. f''16 | e''4 r4 r2 | r4 e''8 g''16 a''16 a''4 g''4 | e''4. d''8 d''4 r4 | r8 e''8 e''8 g''8 a''4 g''8 e''8 ~ | e''8 r4 r16 c''16 d''8. c''16 d''8 e''8 ~ | e''8 c''4. ~ c''8 r4. | R1*1 | \sectionLabel "Verse 2" r8. c''16 e''8 g''16 g''16 a''4 g''8 e''8 ~ | e''8 r4. r2 | r8. c''16 e''8 g''8 a''4 g''8 e''8 ~ | e''8 r4. r2 | r8 c'''8 c'''8 b''8 b''8 a''4 r8 | r8 c'''8 c'''8 b''8 b''4 c'''4 | R1*1 | R1*1 | \sectionLabel "Verse 3" e''4 g''4 a''4 c'''8 g''8 ~ | g''4. r2 r8 | r8 c'''8 c'''8 b''8 b''8 a''4 g''16 e''16 ~ | e''8. r2. r16 | r8. c'''16 c'''8 b''8 b''8. a''8 g''8. | r8. c'''16 c'''8 b''8 b''4 c'''4 | R1*1 | R1*1 | \sectionLabel "Verse 4" e''16 g''16 g''16 r8. g''8 a''8 g''8 f''8 e''8 ~ | e''8 r2. r8 | r8. c''16 e''8 g''16 a''16 a''16 r8. g''8 e''8 | R1*1 | r8. c'''16 c'''8 b''8 b''8. a''8. g''8 | c'''8. b''8. a''8 g''2 | R1*1 | \sectionLabel "Outro" c'''4 b''4 a''8. g''8. f''8 | e''4 r2 r8 c''8 | \time 9/8 a''2 g''4. b'4 | \time 4/4 c''4 r2. | R1*1 |
  \bar "|."
}
harmony = \chordmode { s1*1/2 c1 f1*1/2/c c1*1/2 f1*1/2/c c1*1/2 f1*1/2/c c1*1/2 f1*1/2/c c1*1/2 f1*1/2/c c1*1/2 f1*1/2/c c1*1/2 f1*1/2/c c1*1/2 f1*1/2/c c1*1/2 f1*1/2/c a1*1/2:m7 f1*1/2/g c1*1/2 f1*1/2/c c1*1/2 f1*1/2/c c1*1/2 f1*1/2/c c1*1/2 f1*1/2/c c1*1/2 f1*1/2/c c1*1/2 f1*1/2/c c1*1/2 f1*1/2/c a1*1/2:m7 g1*1/2 c1*1/2 f1*1/2/c c1*1/2 f1*1/2/c c1*1/2 f1*1/2 c1 a1*1/2:m f1*1/2 c1*3/2 f1*1/2 a1*1/2:m g1*1/2 c1*1/2 f1*1/2/c c1*1/2 f1*1/2/c c1*1/2 f1*1/2 c1 a1*1/2:m7 f1*1/2 c1*3/2 f1*1/2 a1*1/2:m7 g1*3/2 a1*1/2:m f1*1/2 c1 f1*1/2 g1*5/8 c1*2 }
words = \lyricmode { \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "Pe" -- _ \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "ter" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "walked" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "through" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "the" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "night" "To" _ _ "the" "home" "of" "Ma" -- "ry" "Ma" -- "ny" "had" "gath" -- "ered" "there" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "To" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "pray" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "with" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "out" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "ceas" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "ing" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "He" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "knocked" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "on" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "the" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "out" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "er" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "door" "A" "ser" -- "vant" "girl" "came" _ "Her" "name" "was" "Rho" -- "da" "She" "heard" "his" "voice" "clear" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "She" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "was" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "over" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "jo" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "yed" "She" "did" "not" "o" -- "pen" "the" "gate" "She" "ran" "in" -- "side" "quick" -- "ly" "To" "tell" "them" "all" "true" "Pe" -- "ter" "was" \skip 1 "stan" -- "ding" "out" -- "side" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "The" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "gate" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "re" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "mained" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "shut" \skip 1 \skip 1 "The" "joy" "was" "too" "great" "To" "stop" "at" "the" "door" "Ma" -- "ry's" "house" "was" "the" "place" "Where" "prayer" "did" "not" "end" }
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
