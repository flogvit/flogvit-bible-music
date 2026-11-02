\version "2.24.0"
\header {
  title = "Han skal tørke bort hver tåre"
  subtitle = "Revelation 21:4"
  tagline = ##f
  copyright = \markup \small \wordwrap { "Melody" "and" "chords" "from" "the" "score" "YuE2" "generated" "the" "song" "from" "(score.abc)." "Lyrics" "placed" "syllable" "by" "syllable" "against" "the" "recording" "with" "Whisper," "which" "heard" "99" "of" "99" "words." "14" "of" "16" "lyric" "lines" "sit" "clearly" "on" "their" "notes;" "2" "are" "uncertain" "and" "printed" "in" "grey" "italics." "Bible" "text:" "Open" "Source" "English" "(OSEN)," "CC" "BY" "4.0," "from" "SBLGNT" "and" "tanach.us." }
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
  \clef treble \key g \major \tempo 4 = 82
  \time 3/4 \sectionLabel "Intro" R1*3/4 | R1*3/4 | R1*3/4 | R1*3/4 | R1*3/4 | R1*3/4 | R1*3/4 | R1*3/4 | R1*3/4 | R1*3/4 | R1*3/4 | \sectionLabel "Verse 1" r4 d'8 d'4 d'16 e'16 | e'4 r4 d'8 c'16 b16 | b16 r2 r8. | R1*3/4 | r4. g'8. b'8. | b'16 a'4. r16 g'8 fis'16 e'16 ~ | e'8 r2 r8 | R1*3/4 | r2 c''8 c''8 | c''4 b'16 r16 b'16 a'16 a'4 | b'4 r2 | r2 r8 b8 | b4 d'4 d'8 b8 | a8 a8 r2 | \sectionLabel "Chorus" r2 b'8 d''8 | e''4 e''16 e''8. d''8 c''8 | b'4 r4 a'16 g'8. | a'2 r16 b'8. | b'4 r4. g'8 | e''4 e''8 d''8. c''16 b'8 | b'4 r4 a'8 g'8 | a'4 b'8 b'8 a'16 g'8. | g'4 r2 | R1*3/4 | \sectionLabel "Verse 2" r2 d'16 d'8. | e'4 e'8 d'16 r16 d'8 c'8 | b4 r2 | R1*3/4 | r2 g'16 b'8. | b'8 a'16 a'4 r16 g'8 fis'8 | e'4 r2 | R1*3/4 | r4. c''16 c''8. c''8 | c''8 b'4 b'8 a'8 a'16 b'16 | b'4 r2 | r2 r8 b8 | b4 d'8 d'4 b8 | a4 r2 | \sectionLabel "Chorus" r2 b'8 d''8 | e''4 e''16 e''8. d''8 c''8 | b'4 r4 a'16 g'8. | a'2 r16 b'8. | b'4 r4. g'8 | e''4 e''8 d''8. c''8. | b'4 r4 a'8 g'8 | a'4 b'8 b'8 a'16 g'8. | g'4 r2 | R1*3/4 | \sectionLabel "Outro" R1*3/4 | R1*3/4 | R1*3/4 | R1*3/4 |
  \bar "|."
}
harmony = \chordmode { s1*5/8 g1*19/8 c1*3/4 e1*3/4:m d1*3/4 g1*3/4 c1*3/4 g1*1/4 d1*1/2 g1*3/4 g1*3/4 c1*3/4 g1*9/4 d1*3/4 e1*3/2:m c1*3/2 g1*9/4 d1*3/4 d1*3/4 c1*3/4 g1*3/4 d1*3/4 e1*3/4:m c1*3/4 g1*3/4 d1*3/4 g1*3/2 g1*3/4 c1*3/4 g1*9/4 d1*3/4 e1*3/2:m c1*3/2 g1*9/4 d1*3/4 d1*3/4 c1*3/4 g1*3/4 d1*3/4 e1*3/4:m c1*3/4 g1*3/4 d1*3/4 g1*3/2 g1*3/4 c1*3/4 g1*3/2 }
words = \lyricmode { "I" _ "heard" "a" "voice" "from" "the" "throne" _ "Look," "God's" "d" -- "welling" "is" "with" "us" "He" _ "will" "dwell" "with" "his" "own" _ "And" "they" "will" "be" "his" "peo" -- "ple" "He" "will" "wipe" "a" -- "way" "ev" -- "ery" "tear" "From" "our" "eyes" "up" "there" "And" _ "death" "will" "be" "no" "more" "No" "more" "grief" "or" "cry" -- "ing" "or" "pain" "When" _ "I" "walk" "my" "fi" -- "nal" "road" "And" _ "my" "jour" -- "ney" "here" "is" "done" "Then" _ _ "I" "will" "see" "him" "as" "he" "is" "And" "be" "at" "home" "with" "God" "He" "will" "wipe" "a" -- "way" "ev" -- "ery" "tear" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "From" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "our" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "eyes" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "up" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "there" "And" "death" "will" "be" "no" "more" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "No" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "more" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "grief" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "or" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "cry" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "ing" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "or" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "pain" }
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
