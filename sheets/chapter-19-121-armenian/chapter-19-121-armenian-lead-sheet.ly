\version "2.24.0"
\header {
  title = "My Help Comes from the Lord"
  subtitle = "Psalm 121"
  tagline = ##f
  copyright = \markup \small \wordwrap { "Melody" "and" "chords" "from" "the" "score" "YuE2" "generated" "the" "song" "from" "(score.abc)." "Lyrics" "placed" "syllable" "by" "syllable" "against" "the" "recording" "with" "Whisper," "which" "heard" "86" "of" "86" "words." "11" "of" "13" "lyric" "lines" "sit" "clearly" "on" "their" "notes;" "2" "are" "uncertain" "and" "printed" "in" "grey" "italics." "Bible" "text:" "Open" "Source" "English" "(OSEN)," "CC" "BY" "4.0," "from" "SBLGNT" "and" "tanach.us." }
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
  \clef treble \key c \minor \tempo 4 = 72
  \time 4/4 \sectionLabel "Intro" R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | r2 g''4 bes''4 | c'''2 g''4 bes''4 | f''2 es''8 f''16 es''16 d''8 bes'8 | c''2 r2 | \sectionLabel "Verse 1" c''4 c''8 d''8 es''4 f''8 g''8 | f''4 d''4 r2 | es''4 d''8 c''8 bes'4 bes'4 | c''2 r4. c''8 | g''4. g''8 g''4 bes''4 | f''2 r4 es''8 f''8 | g''4. f''8 f''4 d''8 c''8 | c''2 r2 | \sectionLabel "Chorus" c'''4 c'''4 bes''8 c'''8 bes''8 f''8 | f''4 g''4 r2 | c'''4 c'''4 bes''8 c'''16 bes''16 g''8 f''8 | g''2 b''2 | \sectionLabel "Verse 2" d'''2 r4. c''8 | g''4 g''8 f''8 g''4 g''8 g''8 | f''4 f''8 es''8 f''8 g''8 f''8 es''16 d''16 | c''2 r4. c''8 | g''4 g''8 f''8 g''4 g''8 bes''8 | f''2 r4 es''8 f''8 | g''2 f''4. c''8 | c''2 r2 | \sectionLabel "Chorus" c'''4 c'''4 bes''8 c'''16 bes''16 g''8 f''8 | f''4 g''4 r2 | c'''4 c'''4 bes''8 c'''16 bes''16 g''8 f''8 | g''2 b''2 | \sectionLabel "Outro" d'''2 r4. c''8 | g''4. g''8 f''4 es''8 d''8 | es''8 d''8 c''4 r2 | R1*1 |
  \bar "|."
}
harmony = \chordmode { s1*7/8 c1*49/8:m bes1 c1:m c1:m bes1 as1*1/2 bes1*1/2 c1*2:m bes1 as1*1/2 bes1*1/2 c1:m as1*1/2 bes1*1/2 c1:m as1*1/2 bes1*1/2 g1 g1 c1:m bes1 as1 c1:m bes1 as1*1/2 bes1*1/2 c1:m as1*1/2 bes1*1/2 c1:m as1*1/2 bes1*1/2 g1 g1 c1*1/2:m bes1*1/2 as1*2 }
words = \lyricmode { \skip 1 \skip 1 \skip 1 \skip 1 \skip 1 \skip 1 \skip 1 \skip 1 \skip 1 \skip 1 \skip 1 \skip 1 \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "I" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "lift" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "up" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "my" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "eyes" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "to" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "the" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "moun" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "tains" "Where" "does" "my" "help" "come" "from" "My" "help" "comes" "from" "the" "Lord" _ "Who" "made" "heav" -- "en" "and" "earth" "He" "who" "keeps" "you" "will" "not" "slum" -- "ber" "He" _ "who" "keeps" "Is" -- "rael" "will" "not" "sleep" _ "The" _ "Lord" "is" "your" "keep" -- "er" "The" "Lord" "is" "your" "shade" "at" "your" "right" "hand" "The" "sun" "shall" "not" "strike" "you" "by" "day" "Nor" "the" "moon" "by" "night" _ "He" "who" "keeps" _ "you" "will" "not" "slum" -- "ber" "He" "who" "keeps" "Is" -- "rael" "will" "not" "sleep" _ _ \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "From" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "this" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "time" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "forth" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "and" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "fo" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "re" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "ver" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "more" }
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
