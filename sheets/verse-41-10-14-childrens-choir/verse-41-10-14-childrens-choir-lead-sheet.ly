\version "2.24.0"
\header {
  title = "Let the Children Come"
  subtitle = "Mark 10:14"
  tagline = ##f
  copyright = \markup \small \wordwrap { "Melody" "and" "chords" "from" "the" "score" "YuE2" "generated" "the" "song" "from" "(score.abc)." "Lyrics" "placed" "syllable" "by" "syllable" "against" "the" "recording" "with" "Whisper," "which" "heard" "97" "of" "97" "words." "All" "16" "lyric" "lines" "sit" "on" "their" "notes." "Bible" "text:" "Open" "Source" "English" "(OSEN)," "CC" "BY" "4.0," "from" "SBLGNT" "and" "tanach.us." }
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
  \clef treble \key c \major \tempo 4 = 90
  \time 2/4 R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | \sectionLabel "Verse 1" r4. c''8 | e''8 g''8 g''16 g''16 g''8 | a''8 c'''8 r8 c'''8 | b''8 a''8 g''16 g''16 a''8 | g''4 r8 c''16 c''16 | e''8 g''8 g''16 g''16 g''8 | a''8 c'''16 c'''8. a''8 | g''16 g''16 e''8 d''8 r8 | e''8 d''8 c''8 r8 | \sectionLabel "Chorus" e'''8 e'''8 e'''8 c'''8 | d'''8 g'''16 g''8. r8 | c'''8 c'''8 c'''8 a''16 g''16 ~ | g''8. r8. g''16 g''16 | a''8 b''16 c'''8. a''8 | g''16 g''16 e''8 c''8 r8 | f''4 e''4 | d''8 c''8 c''4 | R1*1/2 | \sectionLabel "Verse 2" r4. c''8 | e''8 g''16 g''8. g''8 | a''8 c'''16 c'''8. c'''8 | b''8 a''16 g''8. a''8 | g''4 r8 c''8 | e''16 e''16 g''8 g''8 g''16 a''16 ~ | a''8 c'''16 c'''8 c'''16 a''16 a''16 | g''8 e''16 e''16 d''8 d''8 | c''4 r4 | \sectionLabel "Chorus" e'''8 e'''8 e'''8 c'''8 | d'''8 g'''16 g''8. r8 | c'''8 c'''8 c'''8 a''16 g''16 ~ | g''8. r8. g''16 g''16 | a''8 b''16 c'''8. a''8 | g''16 g''16 e''8 c''8 r8 | f''4 e''4 | d''8 c''8 c''4 | \sectionLabel "Outro" R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 |
  \bar "|."
}
harmony = \chordmode { c1*1/2 g1*1/2:7 c1*1/2 g1*1/2:7 c1*1/2 f1*1/4 fis1*1/4:m7.5- c1*1/4/g g1*1/4 c1 f1*1/2 g1*1/2 c1 f1*1/2 g1*3/4 c1*1/4 c1*1/2 g1*1/2 a1*1/2:m e1*1/2:m f1*1/2 c1*1/2 d1*1/4:m7 g1*1/4 c1 c1 f1*1/2 g1*1/2 c1 f1*1/2 g1*1/2 c1*1/2 c1*1/2 g1*1/2 a1*1/2:m e1*1/2:m f1*1/2 c1*1/2 d1*1/4:m7 g1*1/4 c1*1/2 c1*1/2 g1*1/2 a1*1/2:m e1*1/2:m f1*1/2 c1*1/2 d1*1/4:m7 g1*1/4 c1 }
words = \lyricmode { "They" "brought" "the" "chil" -- "dren" "to" "Je" -- "sus" "That" "he" "might" "touch" "them" "and" "bless" "The" "dis" -- "ci" -- "ples" "told" "them" "to" "go" "a" -- "way" "But" "Je" -- "sus" "said," "no," "let" "them" "stay" "Let" "the" "chil" -- "dren" "come" "to" "me" "Do" "not" "hin" -- "der" "them" "For" "to" "such" "be" -- "longs" "the" "kin" -- "gdom" "of" "God" "Let" "the" "chil" -- "dren" "come" "He" "took" "them" "up" "in" -- "to" "his" "arms" "And" "laid" "his" "hands" "on" "them" "Who" -- "ev" -- "er" "does" "not" "re" -- "ceive" "the" "kin" -- "gdom" "Like" "a" "child" "shall" "not" "en" -- "ter" "in" "Let" "the" "chil" -- "dren" "come" "to" "me" "Do" "not" "hin" -- "der" "them" "For" "to" "such" "be" -- "longs" "the" "kin" -- "gdom" "of" "God" "Let" "the" "chil" -- "dren" "come" }
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
