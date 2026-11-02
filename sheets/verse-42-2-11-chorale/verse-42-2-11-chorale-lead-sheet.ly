\version "2.24.0"
\header {
  title = "I dag er det født dere en frelser"
  subtitle = "Luke 2:11"
  tagline = ##f
  copyright = \markup \small \wordwrap { "Melody" "and" "chords" "from" "the" "score" "YuE2" "generated" "the" "song" "from" "(score.abc)." "Lyrics" "placed" "syllable" "by" "syllable" "against" "the" "recording" "with" "Whisper," "which" "heard" "96" "of" "97" "words." "14" "of" "16" "lyric" "lines" "sit" "clearly" "on" "their" "notes;" "2" "are" "uncertain" "and" "printed" "in" "grey" "italics." "Bible" "text:" "Open" "Source" "English" "(OSEN)," "CC" "BY" "4.0," "from" "SBLGNT" "and" "tanach.us." }
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
  \time 4/4 R1*1 | R1*1 | R1*1 | R1*1 | \sectionLabel "Verse 1" r2 r4. c'8 | f'4 f'4 f'8 g'8 a'8 bes'8 | c''2 r4. c''8 | d''4. d''8 d''4 f'4 | g'2 r4. c'8 | d'4 f'4 e'8 f'8 g'8 e'8 | c'2 r4. a'8 | bes'4. a'8 g'4 f'4 | \sectionLabel "Verse 2" g'2 r4 c'8 c'8 | d'8 f'8 f'8 f'8 e'4 g'4 | a'2 ~ a'4 r8 a'8 | bes'4. a'8 g'4 f'4 | a'2 r4. c'8 | d'8 f'8 f'8 f'8 e'4 g'4 | a'2 ~ a'4 r8 a'8 | bes'4 a'4 g'4. f'8 | \sectionLabel "Verse 3" f'2 r4. c''8 | d'''8 d'''8 d'''8 d'''8 e'''4 d'''4 | c'''2 ~ c'''4 r8 c'''8 | bes''4 a''4 g''4 f''4 | a''2 r4. c'''8 | d'''8 d'''8 d'''8 d'''8 e'''4 d'''4 | c'''4 a''4 f''4 r8 a''8 | bes''4 a''4 g''4. f''8 | f''2 r2 | \sectionLabel "Verse 4" d'8 f'4 f'8 e'4 f'8 g'8 | a'4 c''4 ~ c''4 r8 a'8 | bes'4. a'8 g'4. f'8 | a'2 r4. c'8 | d'8 f'8 f'8 f'8 e'4 g'4 | a'2 r2 | \time 3/8 bes'4 a'8 ~ | \time 4/4 a'4 g'4. g'4 f'16 r16 | f'1 | R1*1 | R1*1 |
  \bar "|."
}
harmony = \chordmode { s1*7/8 f1*5/8 d1*1/2:m7 g1*1/2:m7 c1*1/2 f1*1/2 d1*1/2:m7 g1*1/2:m7 c1*1/2 f1*2 bes1 c1 bes1 a1*1/2:m d1*1/2:m7 g1:m7 c1 bes1*1/2 c1*1/2 a1*1/2:m d1*1/2:m g1*1/2:m7 c1*1/2 f1 bes1*1/2 c1*1/2 a1*1/2:m d1*1/2:m g1*1/2:m7 c1*1/2 f1 bes1*1/2 c1*1/2 a1*1/2:m d1*1/2:m g1*1/2:m c1*1/2 f1 bes1*1/2 c1*1/2 a1*1/2:m d1*1/2:m g1*1/2:m7 c1*1/2 f1 bes1*1/2 c1*1/2 a1*1/2:m d1*1/2:m g1*1/2:m7 c1*1/2 f1 bes1*1/2 c1*1/2 a1*1/2:m d1*1/2:m g1*5/8:m7 c1*3/4 f1*3 }
words = \lyricmode { \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "The" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "shep" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "herds" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "watched" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "out" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "in" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "the" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "fields" "Their" "flock" "through" "all" "the" "night" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "An" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "an" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "gel" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "of" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "the" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "Lord" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "ap" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "peared" "And" "glo" -- "ry" "shone" "so" "bright" "Do" "not" "be" "af" -- "raid," "I" "bring" "you" "joy" "Good" "news" "for" "all" "the" "earth" "To" -- "day" "in" "Da" -- "vid's" "town" "is" "born" "A" "Sav" -- "ior," "Christ" "the" "Lord" "And" "this" "will" "be" "the" "sign" "for" "you" "A" "ba" -- "by" "wrapped" "and" "laid" "With" -- _ "in" "a" "man" -- "ger," "and" "the" "host" _ "Of" "heav" -- "en" "sang" "and" "praised" "Glo" -- "ry" "to" "God" "in" "the" "high" -- "est" "And" "peace" "on" "earth" "to" -- "night" "To" "those" "on" "whom" "his" "fa" -- "vor" "rests" "Sing" "all," "sing" "in" "the" "light" }
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
