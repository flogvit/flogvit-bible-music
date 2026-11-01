\version "2.24.0"
\header {
  title = "My Strength"
  subtitle = "Psalms 18:1–2"
  tagline = ##f
  copyright = \markup \small \wordwrap { "Melody" "and" "chords" "from" "the" "score" "YuE2" "generated" "the" "song" "from" "(score.abc)." "Lyrics" "placed" "syllable" "by" "syllable" "against" "the" "recording" "with" "Whisper," "which" "heard" "177" "of" "179" "words." "24" "of" "26" "lyric" "lines" "sit" "clearly" "on" "their" "notes;" "2" "are" "uncertain" "and" "printed" "in" "grey" "italics." "Bible" "text:" "Open" "Source" "English" "(OSEN)," "CC" "BY" "4.0," "from" "SBLGNT" "and" "tanach.us." }
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
  \clef treble \key d \minor \tempo 4 = 80
  \time 4/4 \sectionLabel "Intro" R1*1 | R1*1 | R1*1 | \time 7/8 R1*7/8 | \time 4/4 R1*1 | R1*1 | R1*1 | R1*1 | \sectionLabel "Verse 1" r4 a'4 a'4 f'4 | bes'4. a'8 a'4 r4 | r8. d'16 f'8 f'8 f'8. g'8. a'8 | a'2 g'4 r4 | r4 a'8 a'8 d''8 d''8 e''8 f''8 | e''4 d''4 a'4 r8 d'8 | bes'4. a'8 g'8. f'8. d'8 | f'4. g'16 f'16 e'4 r8 d'8 | \sectionLabel "Chorus" d'4 r8 e'8 f'4 r8 g'8 | a'2 g'4 r8 f'16 e'16 | d'4 d''4 d''8. c''8. bes'16 c''16 | c''2 ~ c''4 r8 d''8 | d''4. f''8 f''4 r8 c''8 | a''4 f''4 g''4 r16 f''16 f''16 e''16 | d''4. f''8 e''8 c''8 c''8 d''8 ~ | d''8 d''2. ~ d''8 ~ | d''1 ~ | \sectionLabel "Verse 2" d''8 d'8 d'8 e'8 f'4 g'8 a'8 | bes'4. a'8 a'4 r4 | r8 d'16 d'16 d'8 e'8 f'4 g'4 | a'4 bes'16 a'16 g'8 g'2 | r8 d''8 d''8 e''8 f''4 g''8 a''8 | bes''4. a''8 a''4 r16 f''16 f''16 e''16 | d''4. f''8 e''16 d''8 c''8. d''8 ~ | d''8 d''2 ~ d''8. e''16 c''16 d''16 | \sectionLabel "Chorus" e''2. r8 e''8 | d''4 r8 e''8 f''4 r8 g''8 | a''2 g''4 r8 f''16 e''16 | d''4 d'''4 d'''8. c'''8. bes''16 c'''16 | c'''2 ~ c'''4 r8 d''8 | d''4. e''8 f''4 r8 c''8 | a''4 f''4 g''4 r16 f''16 f''16 e''16 | d''4. f''8 e''8 c''8 c''8 d''8 ~ | d''8 d''2. ~ d''8 ~ | \sectionLabel "Verse 3" d''2 ~ d''8 r4 d''8 | d''4. d''8 e''4. d''16 e''16 | f''4 r16 e''16 d''8 d''4 r8. a'16 | d''8 d''8 d''8 f''8 e''8 d''8 c''8 bes'8 | bes'4. a'8 a'2 | r8. d''16 d''16 f''8. g''4. f''8 | a''4 f''4 d''4 r8 d''8 | d''4 f''4 g''4. f''8 | a''2 g''2 | g''1 ~ | \sectionLabel "Chorus" g''2. ~ g''8 e''8 | d''4 r8 e''8 f''4 r8 g''8 | a''2 g''4 r8 f''16 e''16 | d''4 d'''4 d'''8. c'''8. bes''16 c'''16 | c'''2 ~ c'''4 r8 d''8 | d''4. e''8 f''4 r8 c''8 | a''4 f''4 g''4 r16 f''8 e''16 | d''4. f''8 e''8 c''8 c''8 d''8 ~ | d''8 d''2. ~ d''8 ~ | d''2 ~ d''8 r4. | \sectionLabel "Outro" r4 a'4 a'4 f'4 | bes'4. a'8 a'4 r4 | r4. d'8 d'4 r8 f'8 | \time 9/8 e'8. d'8. d'8 c'8 c'16 c'16 d'8 d'16 r8. | \time 4/4 R1*1 | R1*1 |
  \bar "|."
}
harmony = \chordmode { d1*63/8:m d1:m bes1*1/2 d1*1/2:m bes1 f1*1/2 c1*1/2 d1:m bes1*1/2 f1*1/2 g1:m a1 d1*1/2:m bes1*1/2 f1*1/2 c1*1/2 d1*1/2:m bes1*1/2 f1*1/2 c1*1/2 d1*1/2:m bes1*1/2 f1*1/2 c1*1/2 bes1*1/2 c1*1/2 d1*2:m d1:m bes1*1/2 d1*3/2:m f1*1/2 c1*1/2 d1:m bes1*1/2 d1*1/2:m g1*1/2:m a1*1/2:m bes1 c1 d1*1/2:m bes1*1/2 f1*1/2 c1*1/2 d1*1/2:m bes1*1/2 f1*1/2 c1*1/2 d1*1/2:m bes1*1/2 f1*1/2 c1*1/2 bes1*1/2 c1*1/2 d1:m d1:m bes1*1/2 c1*1/2 d1:m bes1*1/2 c1*1/2 f1 bes1*1/2 c1*1/2 d1:m g1*1/2:m a1*1/2:m7 bes1 c1 c1 d1*1/2:m bes1*1/2 f1*1/2 c1*1/2 d1*1/2:m bes1*1/2 f1*1/2 c1*1/2 d1*1/2:m bes1*1/2 f1*1/2 c1*1/2 bes1*1/2 c1*1/2 d1*2:m d1:m bes1*1/2 d1*1/2:m bes1 c1*7/8 d1*9/4:m }
words = \lyricmode { \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "I" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "love" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "you" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "Lord" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "my" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "strength" "The" _ _ "LORD" "is" "my" "rock" "and" \skip 1 "for" -- "tress" "My" "de" -- "liv" -- "er" -- "er" "my" "God" "my" "crag" "My" "shield" "and" "horn" "of" "sal" -- "va" -- "tion" _ "My" "strength" "my" "strength" "my" "strength" _ _ "The" "LORD" "is" "wor" -- "thy" "of" "praise" _ "I" "call" "on" "Him" "and" "I" "am" "saved" _ "From" "the" "grasp" "of" "all" "my" "en" -- "e" -- "mies" "He" "res" -- "cued" "me" "from" "the" "hand" "of" "Saul" "From" "the" "grip" "of" "all" "who" "sought" "my" "fall" "I" _ _ "sing" "this" "song" "on" "the" "day" "of" "grace" _ "When" "the" "LORD" "de" -- "liv" -- "ered" "me" "from" "death" _ _ "My" _ "strength" "my" "strength" "my" "strength" "The" _ _ "LORD" "is" "wor" -- "thy" "of" "praise" "I" _ "call" "on" "Him" "and" "I" "am" "saved" "From" "the" "grasp" "of" "all" "my" "en" -- "e" -- "mies" "The" "cords" "of" _ "death" "wound" "round" "me" _ _ "The" "tor" -- "rents" "of" "de" -- "struc" -- "tion" "ter" -- "ri" -- "fied" "me" _ "But" "in" "His" "hand" "I" "find" "my" "rest" "My" "strong" -- "hold" "in" "the" "storm" "of" "life" "My" "strength" "my" "strength" "my" "strength" _ "The" "LORD" "is" "wor" -- "thy" "of" "praise" _ _ "I" "call" "on" "Him" "and" "I" "am" "saved" "From" "the" "grasp" "of" "all" "my" "en" -- "e" -- "mies" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "I" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "love" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "you" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "Lord" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "my" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "strength" "My" "rock" "my" "for" -- "tress" "my" "de" -- "liv" -- "er" -- "er" _ }
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
