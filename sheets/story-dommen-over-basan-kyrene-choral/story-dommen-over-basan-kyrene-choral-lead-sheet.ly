\version "2.24.0"
\header {
  title = "Cows of Bashan"
  subtitle = "Amos 4:1–3"
  tagline = ##f
  copyright = \markup \small \wordwrap { "Melody" "and" "chords" "from" "the" "score" "YuE2" "generated" "the" "song" "from" "(score.abc)." "Lyrics" "placed" "syllable" "by" "syllable" "against" "the" "recording" "with" "Whisper," "which" "heard" "75" "of" "80" "words." "All" "12" "lyric" "lines" "sit" "on" "their" "notes." "Bible" "text:" "Open" "Source" "English" "(OSEN)," "CC" "BY" "4.0," "from" "SBLGNT" "and" "tanach.us." }
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
  \clef treble \key d \minor \tempo 4 = 71
  \time 2/4 \sectionLabel "Intro" R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | \sectionLabel "Verse 1" r4 a''8 a''8 | a''4 g''16 f''8. | g''4 e''8 c''8 | d''4 r4 | r4 d''8 e''8 | f''4 g''8 a''8 | g''8. f''16 e''8 c''16 d''16 | d''4 r4 | r4 d''8 a''8 | a''4 g''16 f''8. | g''8. g''16 e''8. c''16 | d''16 c''16 bes'8 r4 | r4 d''8 f''8 | g''4 e''4 | r8 e''8 d''8. c''16 | d''2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | \sectionLabel "Verse 2" r4. r16 d''16 | d''4 a''8 a''8 | a''4 g''8 f''8 | g''4 e''16 d''16 c''8 | d''4 r4 | r4 d''8 e''8 | f''4 g''16 a''8. | g''8. f''16 e''16 d''16 c''8 | d''4. r8 | r8 d''8 d''8 a''8 | a''4 g''16 f''8. | g''4 e''16 d''16 c''8 | d''8 r4 r16 f''16 | g''4 e''16 d''16 c''8 | d''4 d''8 c''8 | d''4 r4 | R1*1/2 | R1*1/2 | R1*1/2 | \sectionLabel "Verse 3" r4 d'''8 d'''8 | d'''4 c'''8 bes''8 | a''8 g''8 f''8 g''16 a''16 | a''2 | r8 g''8 g''8 f''8 | g''4 a''16 bes''8. | a''4 g''16 f''16 e''8 | d''4. r8 | r8 d'''8 d'''8 d'''8 | d'''8. c'''16 bes''8 bes''16 a''16 | a''8. g''16 f''8 g''16 a''16 | a''4 r8 f''8 | g''4. f''8 | e''4 r4 | r4. c''8 | d''4 c''4 | d''2 ~ | d''2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | \time 5/8 R1*5/8 | \time 2/4 R1*1/2 | R1*1/2 |
  \bar "|."
}
harmony = \chordmode { d1*4:m d1*3:m c1*1/2 d1*3/2:m c1*1/2 bes1 c1 d1*7/2:m d1*3/2:m c1*1/2 d1*3/2:m c1*1/2 d1*3/2:m c1*1/2 bes1 c1*1/2 d1*2:m bes1 d1:m c1 d1:m bes1 d1:m c1*2 d1*49/8:m }
words = \lyricmode { "Hear" _ "this" "word," "you" "cows" "of" "Bas" -- "han" "Liv" -- "ing" _ "on" "Mount" "Samaria" _ _ _ _ _ "You" _ "op" -- "press" "the" _ "poor" "and" "crush" "the" "nee" -- "dy" "Say" -- "ing," "Bring" "us" "some" -- "thing" "to" "drink" "The" _ _ "Lord" "GOD" "has" "sworn" "by" "his" "ho" -- "li" -- "ness" "Days" _ "are" "com" -- "ing" "up" -- "on" "you" _ _ _ "You" _ "will" "be" "car" -- "ried" "off" "with" "hooks" _ _ "The" _ _ "last" "of" "you" "with" "fish" -- "hooks" "You" _ "will" "go" "out" "through" "breach" -- "es" "in" "the" "wall" "Each" _ "wom" -- "an" "straight" "a" -- "head" "of" "her" _ _ "You" _ _ "will" "be" "cast" "out" "toward" "Har" -- "mon" _ _ _ _ "De" -- "clares" "the" "LORD," "the" "end" "is" "near" }
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
