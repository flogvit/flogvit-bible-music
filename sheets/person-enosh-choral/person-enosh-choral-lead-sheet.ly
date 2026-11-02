\version "2.24.0"
\header {
  title = "Calling On The Name"
  subtitle = "Genesis 4:26; 5:6; 5:9–10; Luke 3:38"
  tagline = ##f
  copyright = \markup \small \wordwrap { "Melody" "and" "chords" "from" "the" "score" "YuE2" "generated" "the" "song" "from" "(score.abc)." "Lyrics" "placed" "syllable" "by" "syllable" "against" "the" "recording" "with" "Whisper," "which" "heard" "124" "of" "128" "words." "17" "of" "21" "lyric" "lines" "sit" "clearly" "on" "their" "notes;" "4" "are" "uncertain" "and" "printed" "in" "grey" "italics." }
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
  \clef treble \key bes \major \tempo 4 = 70
  \time 4/4 \sectionLabel "Intro" R1*1 | R1*1 | R1*1 | R1*1 | \sectionLabel "Verse 1" r8 f'8 f'8 f'8 f'8. bes'8. c''8 ~ | c''8 c''4 r2 r8 | r4 bes'8 bes'16 bes'8. a'16 g'8. f'16 f'16 | g'4 r2. | r8. f'16 f'8 f'16 f'8. bes'4 c''8 ~ | c''8 d''4 c''16 bes'16 r2 | r8. bes'16 bes'8 bes'16 bes'8. c''8 d''4 | c''4. r8 r2 | \sectionLabel "Verse 2" r4 g''8 g''16 g''8. a''16 bes''8. c'''8 ~ | c'''8 c'''4 r2 r8 | r8. f''16 f''8 f''16 f''8. a''8 c'''4 | bes''4 r2. | r4 es''8 es''16 es''8. f''16 g''8. f''16 f''16 ~ | f''8. r8. bes'16 c''16 d''4 c''8 bes'16 bes'16 ~ | bes'4. ~ bes'16 r2 r16 | R1*1 | \sectionLabel "Verse 3" r8 f'16 f'16 f'8 f'8 f'8 bes'16 c''16 c''8 c''8 ~ | c''8 r2. r8 | r8. bes'16 bes'8 bes'16 bes'8. a'4 f'8 | g'4 r2. | r8 f'8 f'8 f'16 f'8. bes'8 c''4 ~ | c''8 c''4 r4 d''4 c''16 bes'16 ~ | bes'8 r4 bes'16 bes'16 bes'8. c''8. d''8 | c''4. r2 r8 | \sectionLabel "Verse 4" r4 g''8 g''16 g''8. a''16 bes''8. c'''8 ~ | c'''8 c'''4. r2 | r4 f''8 f''16 f''8. a''16 c'''8. a''16 bes''16 ~ | bes''8. r2. r16 | r8. es''16 es''8 es''16 es''8. f''16 g''8. f''8 ~ | f''8 r8 bes'16 c''8. d''8 c''16 c''8. bes'16 bes'16 ~ | bes'2 ~ bes'8. r4 r16 | R1*1 | \sectionLabel "Verse 5" r4 g''8 g''8 g''8 a''8 bes''8 c'''8 ~ | c'''4. r2 r8 | r8. f''16 f''8 f''16 f''8. a''8 c'''8. a''16 ~ | a''8 bes''4 r2 r8 | r4 es''16 es''8 es''8. f''16 f''16 g''16 f''8 f''16 ~ | f''8 r16 bes'16 bes'8 c''16 d''4 r16 c''16 bes'8. | bes'2 r2 | R1*1 | \sectionLabel "Outro" r4 bes'16 c''16 d''16 es''16 d''4 c''8. bes'16 | bes'2 r2 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 |
  \bar "|."
}
harmony = \chordmode { bes1 f1/a g1:m es1 bes1 f1/a g1:m es1 bes1 f1*1/2/a g1*1/2:m es1 f1*1/2:sus4 f1*1/2 es1 f1 d1:m g1:m es1 f1 bes1 es1/bes bes1 f1/a g1:m es1 bes1 f1/a es1 f1 es1 f1 d1:m7 g1:m es1 f1 bes1 es1/bes es1 f1 d1:m7 g1:m es1 f1 bes1 es1 es1 bes1 es1/bes bes1 es1*5/4/bes bes1*7/4 }
words = \lyricmode { \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "Seth" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "lived" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "one" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "hun" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "dred" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "and" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "five" "Then" _ "he" "saw" "a" "son" "ar" -- "rive" "He" _ "named" "him" "E" -- "nosh," "pure" "and" "true" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "In" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "to" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "the" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "line" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "where" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "faith" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "grew" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "At" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "that" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "time" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "the" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "peo" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "ple" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "found" "A" "way" "to" "make" "their" "hearts" "sound" "They" "be" -- "gan" "to" "call" "a" -- "loud" "On" "the" "name" "of" "the" "Lord" "When" _ "E" -- "nosh" "was" "nine" -- "ty" "years" "old" "He" "fa" -- "thered" "Ke" -- "nan," "as" "told" "Eight" "hun" -- "dred" "and" "fif" -- "teen" "more" "He" "lived," "keep" -- \skip 1 "ing" "faith" "to" "the" "core" "Oth" -- "er" "sons" "and" "daugh" -- "ters" "came" "In" "the" "name" "they" "bore" "the" "same" "From" "A" -- "dam" "down" "to" "Seth’s" "line" "E" -- "nosh" "stands" "in" "grace" "di" -- "vine" "Luke" "lists" "him" "in" "the" "chain" "The" "son" "of" "E" -- "nosh," "plain" "and" "plain" "Son" "of" "Seth," "son" "of" "A" -- "dam’s" "seed" "From" "God," "the" "sto" -- "ry" "is" "read" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "Call" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "ing" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "on" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "the" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "name" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "of" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "the" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "Lord" }
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
