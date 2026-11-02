\version "2.24.0"
\header {
  title = "He Will Not Sleep"
  subtitle = "Psalms 121:4"
  tagline = ##f
  copyright = \markup \small \wordwrap { "Melody" "and" "chords" "from" "the" "score" "YuE2" "generated" "the" "song" "from" "(score.abc)." "Lyrics" "placed" "syllable" "by" "syllable" "against" "the" "recording" "with" "Whisper," "which" "heard" "109" "of" "109" "words." "13" "of" "16" "lyric" "lines" "sit" "clearly" "on" "their" "notes;" "3" "are" "uncertain" "and" "printed" "in" "grey" "italics." "Bible" "text:" "Open" "Source" "English" "(OSEN)," "CC" "BY" "4.0," "from" "SBLGNT" "and" "tanach.us." }
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
  \clef treble \key d \major \tempo 4 = 69
  \time 2/4 R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | \sectionLabel "Verse 1" r4 fis'8 e'8 | d'4 a'4 | b'4 a'4 | fis'4 r4 | r8. fis'16 fis'8 e'8 | d'4 fis'4 | e'4 d'4 | d'8 r4. | r8. d'16 fis'8 a'8 | b'4. b'16 a'16 | a'4 a'4 | fis'4 r4 | r8. fis'16 fis'8 e'8 | d'4 r4 | r8. d'16 fis'16 e'16 d'8 | e'2 | \sectionLabel "Chorus" r8 fis'8 fis'8 e'8 | d'4 b'4 | r8 b'8 b'8 a'8 | fis'4 r4 | r8. fis'16 fis'8 e'8 | d'4 b'4 ~ | b'4 b'8 a'8 ~ | a'8 e'4 r8 | r8 fis'8 fis'8 e'16 d'16 | d'4 r4 | r8 b'8 b'16 a'8. | fis'4 e'8. fis'16 | d'4 r4 | b4 fis'8. g'16 | e'4 e'8. d'16 | d'4 r4 | R1*1/2 | R1*1/2 | \sectionLabel "Verse 2" r8. d'16 fis'8 e'8 | d'4 a'4 | b'4 a'4 | fis'4 r4 | r8. d'16 fis'8 e'8 | d'4 fis'4 | e'4 d'4 | d'4 r4 | r8. d'16 fis'8 a'8 | b'4 b'8. a'16 | a'4 a'8. fis'16 | fis'4 r4 | r4. r16 d'16 | d'4. fis'8 | e'4. d'8 | d'4 r4 | \sectionLabel "Chorus" r8 fis'8 fis'8 e'8 | d'4 b'4 ~ | b'8 b'8 b'8 a'8 | fis'4 r4 | r8. fis'16 fis'8 e'8 | d'4 b'4 ~ | b'4 b'8 a'8 ~ | a'8 e'4 r8 | r8 fis'8 fis'8 e'8 | d'4 r4 | r8 b'8 b'16 a'8. | fis'4 e'8. fis'16 | d'4 r4 | b4 fis'8. g'16 | e'4 e'8. d'16 | \sectionLabel "Outro" d'4 r4 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 |
  \bar "|."
}
harmony = \chordmode { s1*3/8 d1*29/8 d1 g1*1/2 d1 b1*1/2:m a1*1/2 d1 g1*1/2 a1*1/2 b1:m g1 a1*1/2 a1*1/2 g1 d1 b1:m a1 g1 d1*1/4 a1*1/4/cis b1*1/2:m g1*1/2 a1*1/2 d1*3/2 d1 g1*1/2 d1 b1*1/2:m a1*1/2 d1 g1*1/2 a1*1/2 b1:m g1*1/2 a1*1/2 d1*1/2 d1*1/2 g1 d1 b1:m a1 g1 d1*1/4 a1*1/4/cis b1*1/2:m g1*1/2 a1*1/2 d1*7/2 }
words = \lyricmode { \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "Lay" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "your" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "head" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "down," \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "lit" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "tle" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "one" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "The" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "lamps" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "are" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "low," \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "the" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "day" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "is" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "done" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "The" _ \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "Lord" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "who" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "made" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "the" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "hills" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "and" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "sky" "Is" _ "watch" -- "ing" \skip 1 "you," "and" "so" "am" "I" _ "He" "will" "not" "slum" -- "ber," "he" "will" "not" "sleep" "The" "one" "who" "keeps" "you," "he" "will" "keep" "Your" "go" -- "ing" \skip 1 "out," "your" "com" -- "ing" "in" _ "Sleep" _ _ "now," "sleep" "a" -- "gain" "The" "sun" "won't" "hurt" "you" "through" "the" "day" "The" "moon" "won't" "harm" "you" "on" "your" "way" "The" _ "Lord" "will" "keep" "you" "from" "all" "harm" _ "As" -- "leep" "with" -- "in" "his" "arm" "He" "will" "not" "slum" -- "ber," "he" "will" "not" "sleep" "The" "one" "who" "keeps" "you," "he" "will" "keep" "Your" "go" -- "ing" "out," \skip 1 "your" "com" -- "ing" "in" _ _ "Sleep" "now," _ "sleep" "a" -- "gain" _ }
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
