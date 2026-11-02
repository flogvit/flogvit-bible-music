\version "2.24.0"
\header {
  title = "Kom til meg"
  subtitle = "Matthew 11:28–30"
  tagline = ##f
  copyright = \markup \small \wordwrap { "Melody" "and" "chords" "from" "the" "score" "YuE2" "generated" "the" "song" "from" "(score.abc)." "Lyrics" "placed" "syllable" "by" "syllable" "against" "the" "recording" "with" "Whisper," "which" "heard" "100" "of" "100" "words." "15" "of" "16" "lyric" "lines" "sit" "clearly" "on" "their" "notes;" "1" "are" "uncertain" "and" "printed" "in" "grey" "italics." "Bible" "text:" "Open" "Source" "English" "(OSEN)," "CC" "BY" "4.0," "from" "SBLGNT" "and" "tanach.us." }
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
  \clef treble \key g \major \tempo 4 = 87
  \time 6/8 R1*3/4 | R1*3/4 | R1*3/4 | R1*3/4 | R1*3/4 | R1*3/4 | R1*3/4 | R1*3/4 | R1*3/4 | R1*3/4 | \sectionLabel "Verse 1" r4. d''4 d''8 | d''4 d''8 g''4 fis''8 | e''8 d''4 r8 b'8 d''8 | e''4 e''4 d''8 c''8 | b'4 r4 b'8 d''8 | e''4 e''8 g''4 fis''8 | e''8 d''4 r8 b'8 d''8 | d''4 c''8 b'4 a'8 | g'4. r4. | \sectionLabel "Chorus" r4. b'4 d''8 | d''2 r8 d''8 | g''4. g''4 fis''8 | fis''8 e''4 r4 e''8 | a''4 a''8 a''4 g''8 | fis''4. r4 d''8 | b''4 c'''8 b''4 a''8 | g''4. r4. | r4. b''4 a''16 g''16 | g''2 r4 | \sectionLabel "Verse 2" r2 b'8 d''8 | d''4 d''8 g''4 fis''8 | d''4 r8 b'8 b'8 d''8 | e''8 e''8 e''8 e''8 d''8 c''8 | b'4 r4. d''8 | e''8 e''8 e''8 g''8 g''8 fis''16 e''16 | d''4 r16 b'16 b'8 b'8 d''8 | d''8 c''16 c''16 c''8 b'8. a'16 a'8 | g'2 r4 | \sectionLabel "Chorus" r4. b'4 d''8 | d''2 r8 d''8 | g''4. g''4 fis''8 | fis''8 e''4 r4 e''8 | a''4 a''8 a''4 g''8 | fis''4. r4 d''8 | b''4 c'''8 b''4 a''8 | g''2 r4 | r4. b''4 a''16 g''16 | g''2 r4 | R1*3/4 | \sectionLabel "Interlude" R1*3/4 | R1*3/4 | R1*3/4 | R1*3/4 | R1*3/4 | R1*3/4 | R1*3/4 | r4. b'4 d''8 | \sectionLabel "Chorus" d''2 r8 d''8 | g''4. g''4 fis''8 | fis''8 e''4 r4 e''8 | a''4 a''8 a''4 g''8 | fis''4. r4 d''8 | b''4 c'''8 b''4 a''8 | g''2 r4 | r4. b''4 a''8 | g''2 r4 | R1*3/4 | R1*3/4 |
  \bar "|."
}
harmony = \chordmode { s1*5/8 g1*25/8 c1*3/2 d1*3/2:7 g1*3/4 g1*9/4 c1*3/4 g1*3/4 c1*3/4 g1*3/4 d1*3/4:7 g1*3/4 g1*9/4 c1*3/2 d1*3/2:7 g1*9/4 g1*9/4 c1*3/4 g1*3/4 c1*3/4 g1*3/4 d1*3/4:7 g1*3/4 g1*9/4 c1*3/2 d1*3/2:7 g1*3 g1*3/2 c1*3/2 d1*3/2:7 g1*3/2 g1*3/2 c1*3/2 d1*3/2:7 g1*15/4 }
words = \lyricmode { "You" "who" "strug" -- "gle," "you" "who" "car" -- "ry" "Hea" -- "vy" "bur" -- "dens" "day" "and" "night" "Hear" "how" "Je" -- "sus" "calls" "you" "to" "him" "You" "are" "not" "for" -- "got" -- "ten" "here" "Come" "to" "me," "all" "you" "who" "are" "wea" -- "ry" "And" "bur" -- "dened," "come" "to" "me" "And" "I" "will" "give" "you" "rest" "Come" "to" "me" _ "Take" "my" "yoke" "and" "learn" "from" "me" "For" "I" "am" "gen" -- "tle" "and" "hum" -- "ble" "in" "heart" "And" _ "you" "will" "find" "rest" "for" "your" "souls" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "For" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "my" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "yoke" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "is" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "ea" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "sy" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "and" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "my" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "bur" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "den" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "is" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "light" "Come" "to" "me," "all" "you" "who" "are" "wea" -- "ry" "And" "bur" -- "dened," "come" "to" "me" "And" "I" "will" "give" "you" "rest" "Come" "to" "me" _ \skip 1 \skip 1 \skip 1 \skip 1 \skip 1 \skip 1 \skip 1 \skip 1 \skip 1 \skip 1 \skip 1 \skip 1 \skip 1 \skip 1 \skip 1 \skip 1 \skip 1 \skip 1 \skip 1 \skip 1 \skip 1 \skip 1 \skip 1 \skip 1 }
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
