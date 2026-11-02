\version "2.24.0"
\header {
  title = "Come to Me and Rest"
  subtitle = "Matthew 11:28–30"
  tagline = ##f
  copyright = \markup \small \wordwrap { "Melody" "and" "chords" "from" "the" "score" "YuE2" "generated" "the" "song" "from" "(score.abc)." "Lyrics" "placed" "syllable" "by" "syllable" "against" "the" "recording" "with" "Whisper," "which" "heard" "100" "of" "105" "words." "All" "16" "lyric" "lines" "sit" "on" "their" "notes." "Bible" "text:" "Open" "Source" "English" "(OSEN)," "CC" "BY" "4.0," "from" "SBLGNT" "and" "tanach.us." }
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
  \clef treble \key c \major \tempo 4 = 73
  \time 4/4 \sectionLabel "Intro" R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | \sectionLabel "Verse 1" r2 e''8 e''8 e''16 d''16 d''8 ~ | d''8 e''8 r2. | r2 d''16 e''8 g''8. e''8 ~ | e''8 d''4 r2 r8 | r4. c''16 d''16 e''8 d''16 e''16 e''8 e''8 ~ | e''8 d''8 r8 c''16 d''16 e''8 d''16 c''8. a'16 e''16 ~ | e''2 ~ e''8. r4 r16 | \sectionLabel "Chorus" r2 g''4 a''4 | e''4 r4 e''8 d''8 e''16 g''8 e''16 ~ | e''8 d''8 r4 g''4 a''4 | e''4 r8. d''16 e''8 d''16 e''8 g''8. | e''4 r8 e''8 a''8 g''8 e''8 d''16 c''16 | d''8. e''8. a'4 r4. | r2 e''8 d''16 c''8 a'8. | a'16 r16 c''4 r2 r8 | R1*1 | \sectionLabel "Verse 2" r4 e''8 e''8 e''8 d''16 e''8 g''8. | e''4 r2. | r4 d''16 e''8 g''8. e''4 r8 | bes''8. a''8. g''8 e''8. f''16 d''4 | r4. c''16 d''16 e''8 d''8 e''16 d''8 e''16 ~ | e''8. r4 r16 e''8 d''8 c''8 a'16 c''16 ~ | c''2 ~ c''8. r4 r16 | \sectionLabel "Chorus" r2 g''4 a''4 | e''4 r4 e''8 d''8 e''16 g''8 e''16 ~ | e''8 d''8 r4 g''4 a''4 | e''4 r8. d''16 e''8 d''16 e''8 g''8. | e''4 r8 e''8 a''8 g''8 e''8 d''16 c''16 | d''8. e''8. a'4 r4. | r2 e''8 d''16 c''8. a'8 | a'8 c''4 r2 r8 | R1*1 | \sectionLabel "Outro" R1*1 | R1*1 | R1*1 | R1*1 | R1*1 |
  \bar "|."
}
harmony = \chordmode { s1*7/8 d1*9/8:m7 g1:7 c1:maj7 a1:7 d1:m7 g1:7 c1:maj7 a1:7 d1:m7 g1:7 c1:maj7 a1:7 d1:m7 g1:7 c1:maj7 a1:7 d1:m7 g1:7 c1:maj7 a1:7 d1:m7 g1:7 c1:maj7 a1:7 d1:m7 g1:7 c1:maj7 a1:7 d1:m7 g1:7 c1:maj7 a1:7 d1:m7 g1:7 c1:maj7 a1:7 d1:m7 g1:7 c1:maj7 a1:7 d1:m7 }
words = \lyricmode { "Long" "day," "hea" -- "vy" "shoul" -- "ders" "Too" "much" "on" "my" "mind" "Hear" "a" "voice" "in" -- "side" "the" "qui" -- "et" "Say" -- "ing" "leave" "it" "all" "be" -- "hind" "Come" "to" "me," "all" "you" "who" "are" "wea" -- "ry" "Come" "to" "me" "and" "I" "will" "give" "you" "rest" "My" "yoke" "is" "ea" -- "sy" "and" "my" "bur" -- "den" "light" "Come" "to" "me" "and" "rest" "Take" "my" "yoke" "and" "learn" "from" "me" "I" "am" "gen" -- "tle," "low" -- "ly" "in" "heart" _ _ "You" "will" "find" "rest" "for" "your" "souls" "Right" "here" "where" "you" "are" "Come" "to" "me," "all" "you" "who" "are" "wea" -- "ry" "Come" "to" "me" "and" "I" "will" "give" "you" "rest" "My" "yoke" "is" "ea" -- "sy" "and" "my" "bur" -- "den" "light" "Come" "to" "me" "and" "rest" }
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
