\version "2.24.0"
\header {
  title = "Mercy Endures Forever"
  subtitle = "Psalms 107:1"
  tagline = ##f
  copyright = \markup \small \wordwrap { "Melody" "and" "chords" "from" "the" "score" "YuE2" "generated" "the" "song" "from" "(score.abc)." "Lyrics" "placed" "syllable" "by" "syllable" "against" "the" "recording" "with" "Whisper," "which" "heard" "119" "of" "120" "words." "23" "of" "25" "lyric" "lines" "sit" "clearly" "on" "their" "notes;" "2" "are" "uncertain" "and" "printed" "in" "grey" "italics." "Bible" "text:" "Open" "Source" "English" "(OSEN)," "CC" "BY" "4.0," "from" "SBLGNT" "and" "tanach.us." }
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
  \clef treble \key f \major \tempo 4 = 85
  \time 4/4 R1*1 | R1*1 | R1*1 | R1*1 | \sectionLabel "Verse 1" r2. r8 c''8 | c''4 c''8 a'16 c''4 r16 d''8 c''8 ~ | c''8 r2. r16 a'16 | d''4 f''8 f''4 a'4 bes'16 a'16 ~ | a'8. r2 r8. c''8 | d''8 f''8 f''8 f''4. d''8 c''8 ~ | c''8 f''4 r2 r8 | r8 d''8 f''8 d''16 f''8. a''4 g''16 g''16 | R1*1 | \sectionLabel "Chorus" a''8 a''4 a''8 a''4 f''8 g''8 ~ | g''8 g''8 r2. | f''4 f''8 f''4 a'4 d''16 c''16 ~ | c''8. r2 r16 d''8 e''16 f''16 ~ | f''2 ~ f''8. r16 d''8 c''8 | c''4 f''4 r2 | bes'4 a'8 g'8 ~ g'4 f'8 f'8 ~ | \sectionLabel "Verse 2" f'4 r4 r4. a'16 bes'16 | c''4 c''8 a'16 c''8. d''8. c''16 d''16 c''16 ~ | c''8. r2 r8. d''16 e''16 | f''4. g''4 a''4 e''8 ~ | e''16 d''16 c''4. r4. c''8 | d''4 f''8 f''4 a''8 g''8 g''16 f''16 ~ | f''8. r8. c''8 d''8 f''8 a''8 g''8 ~ | g''2 ~ g''8 r8 a''4 | bes''4 c'''4 a''8 g''16 f''16 f''4 | \sectionLabel "Chorus" a''8 a''4 a''8 a''4 f''8 g''8 ~ | g''8 g''8 r2. | f''4 f''8 f''4 a'4 d''16 c''16 ~ | c''8. r2 r16 d''8 e''16 f''16 ~ | f''2 ~ f''8. r16 d''8 c''8 | c''4 f''4 r2 | bes''4 a''8 g''8 ~ g''4 f''8 f''8 ~ | \sectionLabel "Verse 3" f''2 ~ f''8 r4 f''8 | d'''8 d'''4 d'''4. d'''8 c'''8 ~ | c'''8 a''4 g''16 f''4 r8. f''8 | bes''8. bes''8. bes''4 c'''4 c'''16 g''16 | a''2 r2 | d''4 f''4 f''8 g''8 a''8 a''8 ~ | a''8 g''16 f''8. r8 d''8 f''8 a''8 g''8 ~ | g''1 ~ | g''4. r2 r8 | \sectionLabel "Chorus" a''8 a''4 a''8 a''4 f''8 g''8 ~ | g''8 g''8 r2. | f''4 f''8 f''4 a'4 d''16 c''16 ~ | c''8. r2 r16 d''8 e''16 f''16 ~ | f''2 ~ f''8. r16 d''8 c''8 | c''4 f''4 r2 | bes''4 a''8 g''8 ~ g''4 f''8 f''8 ~ | f''4. r2 r8 | \sectionLabel "Outro" a''8 a''4 a''8 a''4 f''8 g''8 | g''8 g''16 r2. r16 | R1*1 | R1*1 | R1*1 |
  \bar "|."
}
harmony = \chordmode { s1*7/8 f1*5/8 c1*1/4/e d1*5/4:m7 bes1*3/4 bes1*1/4/c c1:7sus4 f1 c1/e d1:m7 a1:m7 bes1 f1/a g1:m7 c1:7sus4 f1 c1/e d1:m7 a1:m7 bes1 f1*1/4/a d1*3/4:m7 g1*1/2:m7 c1*1/2:7sus4 f1*1/2 c1*1/2:7sus4 f1 c1/e d1:m7 a1:m7 bes1 f1/a g1:m7 c1:7sus4 f1 c1/e d1:m7 a1:m7 bes1 f1*1/4/a d1*3/4:m7 g1*1/2:m7 c1*1/2:7sus4 f1 bes1 f1:maj7/a g1:m7 f1 bes1 f1*1/2/a d1*1/2:m7 g1:m7 c1:7sus4 f1 c1/e d1:m7 a1:m7 bes1 a1*1/4:m7 d1*3/4:m7 g1*1/2:m7 c1*1/2:7sus4 f1 f1 c1/e d1:m7 bes1*5/4:maj7 f1*3/4 }
words = \lyricmode { "Give" "thanks" "to" "the" "Lord" "to" -- "day" "For" _ "he" "is" "good" "and" "stays" "His" "mer" -- "cy" "en" -- "dures" "for" -- "ev" -- "er" "Let" _ "the" "re" -- "deemed" "say" "so" "Mer" -- "cy" "en" -- "dures" "for" -- "ev" -- "er" "Good" -- "ness" _ "is" "his" "name" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "Praise" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "the" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "Lord" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "for" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "his" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "kind" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "ness" "We" "are" "not" "the" "same" "He" _ _ "re" -- "deemed" "from" "the" "en" -- "e" -- "my" "Gath" -- _ "ered" "out" "of" "the" "lands" _ "From" _ _ "east" "and" "from" "the" "west" "From" "north" "and" "the" "seas" \skip 1 \skip 1 \skip 1 \skip 1 \skip 1 \skip 1 \skip 1 "Mer" -- "cy" "en" -- "dures" "for" -- "ev" -- "er" "Good" -- "ness" "is" "his" "name" _ "Praise" "the" "Lord" "for" "his" "kind" -- "ness" "We" "are" "not" "the" "same" "Some" _ "wan" -- "dered" "in" "the" "wil" -- "der" -- "ness" "A" _ "waste" -- "land" "with" "no" "road" _ "Found" _ "no" "c" -- "ity" "to" "live" "in" "Lost" "in" "the" "cold" "Mer" -- "cy" "en" -- "dures" "for" -- "ev" -- "er" "Good" -- "ness" "is" "his" "name" _ \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "Praise" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "the" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "Lord" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "for" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "his" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "kind" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "ness" "We" "are" "not" "the" "same" "His" "mer" -- "cy" "en" -- "dures" "for" -- "ev" -- "er" }
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
