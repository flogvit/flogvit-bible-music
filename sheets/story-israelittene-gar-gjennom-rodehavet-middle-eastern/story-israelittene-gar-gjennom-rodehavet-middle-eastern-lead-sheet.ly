\version "2.24.0"
\header {
  title = "Horse and Rider"
  subtitle = "Exodus 15:1–2; 15:20–21"
  tagline = ##f
  copyright = \markup \small \wordwrap { "Melody" "and" "chords" "from" "the" "score" "YuE2" "generated" "the" "song" "from" "(score.abc)." "Lyrics" "placed" "syllable" "by" "syllable" "against" "the" "recording" "with" "Whisper," "which" "heard" "117" "of" "122" "words." "15" "of" "16" "lyric" "lines" "sit" "clearly" "on" "their" "notes;" "1" "are" "uncertain" "and" "printed" "in" "grey" "italics." "Bible" "text:" "Open" "Source" "English" "(OSEN)," "CC" "BY" "4.0," "from" "SBLGNT" "and" "tanach.us." }
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
  \clef treble \key c \minor \tempo 4 = 132
  \time 4/4 \sectionLabel "Intro" R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | \sectionLabel "Verse 1" c''4 c''4 es''4 f''4 | g''4 g''8 as''8 g''8 f''8 es''8 c''8 | c''4. c''8 es''4 f''4 | g''8 as''8 g''8 f''8 f''4 r4 | c''4. c''8 es''4 f''4 | g''4 g''8 as''8 g''8 f''8 es''8 d''8 | d''4. c''8 bes'4 d''4 | c''4 r2. | \sectionLabel "Chorus" c'''4 c'''8 bes''8 c'''4 g''4 | bes''4. g''8 g''8 f''8 f''8 es''8 | f''4 f''2 r4 | R1*1 | c'''4 c'''8 bes''8 c'''8 g''16 r16 g''4 | bes''4. g''8 g''8 f''8 f''8 es''8 | f''2 r2 | R1*1 | c'''4 c'''8 bes''8 c'''4 g''4 | bes''4. g''8 g''8 f''8 f''8 es''8 | f''4 f''2 r4 | R1*1 | c'''4 c'''8 bes''8 c'''8 g''8 g''4 | bes''4. g''8 g''8 f''8 f''8 es''8 | f''2 r2 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | \sectionLabel "Verse 2" r2. r8 bes'8 | c''4 c''4 es''4 f''4 | g''4 g''8 as''8 g''8 f''8 es''8 c''8 | c''4. c''8 es''4 f''4 | g''8 as''8 g''8 f''8 f''4 r4 | c''4. c''8 es''4 f''4 | g''4 g''8 as''8 g''8 f''8 es''8 d''8 | d''4. c''8 bes'4 d''4 | c''4. bes'8 bes'4 c''4 | R1*1 | R1*1 | \sectionLabel "Chorus" c'''4 c'''8 bes''8 c'''4 g''4 | bes''4. g''8 g''8 f''8 f''8 es''8 | f''4 f''2 r4 | R1*1 | c'''4 c'''8 bes''8 c'''8 g''16 r16 g''4 | bes''4. g''8 g''8 f''8 f''8 es''8 | f''2 r2 | R1*1 | c'''4 c'''8 bes''8 c'''4 g''4 | bes''4. g''8 g''8 f''8 f''8 es''8 | f''4 f''2 r4 | R1*1 | c'''4 c'''8 bes''8 c'''8 g''16 r16 g''4 | bes''4. g''8 g''8 f''8 f''8 es''8 | f''2 r2 | R1*1 | R1*1 | R1*1 |
  \bar "|."
}
harmony = \chordmode { s1*3/4 c1*57/4:m c1*6:m bes1 c1:m c1:m es1 bes1*2 as1 es1 bes1*2 c1:m es1 bes1*2 as1 es1 bes1*2 c1*15:m c1*7:m bes1 c1*3:m c1:m es1 bes1*2 as1 es1 bes1*2 c1:m es1 bes1*2 as1 es1 bes1*2 c1*2:m }
words = \lyricmode { "Miri" -- "am" "took" "the" "tam" -- "bou" -- "rine" _ _ _ "All" "the" "wom" -- "en" "fol" -- "lowed" "her" _ _ _ "Danc" -- "ing" "on" "the" "far" -- "ther" "shore" _ "Where" "the" "sea" "had" "closed" "once" "more" _ "Sing" _ "to" "the" "Lord," "for" "he" "is" "high" -- "ly" "ex" -- "alt" -- "ed" "Horse" _ _ "and" "rid" -- "er" "he" "has" "hurled" "in" -- "to" "the" "sea" "Sing" _ "to" "the" "Lord," "for" "he" "is" "high" -- "ly" "ex" -- "alt" -- "ed" "Horse" _ _ "and" "rid" -- "er" "he" "has" "hurled" "in" -- "to" "the" "sea" "The" "Lord" "is" "my" "strength" "and" "my" "song" _ _ "He" "has" "be" -- "come" "my" "sal" -- "va" -- "tion" _ _ _ \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "He" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "is" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "my" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "God" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "and" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "I" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "will" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "praise" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "him" _ "My" "fa" -- "ther's" "God," "I" "will" "ex" -- "alt" "him" "Sing" "to" _ "the" "Lord," "for" "he" "is" "high" -- "ly" "ex" -- "alt" -- "ed" "Horse" _ _ "and" "rid" -- "er" "he" "has" "hurled" "in" -- "to" "the" "sea" "Sing" _ "to" "the" "Lord," "for" "he" "is" "high" -- "ly" "ex" -- "alt" -- "ed" "Horse" _ _ "and" "rid" -- "er" "he" "has" "hurled" "in" -- "to" "the" "sea" }
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
