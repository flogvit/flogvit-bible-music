\version "2.24.0"
\header {
  title = "From the Mouths of Children"
  subtitle = "Psalms 8:2–3"
  tagline = ##f
  copyright = \markup \small \wordwrap { "Melody" "and" "chords" "from" "the" "score" "YuE2" "generated" "the" "song" "from" "(score.abc)." "Lyrics" "placed" "syllable" "by" "syllable" "against" "the" "recording" "with" "Whisper," "which" "heard" "104" "of" "104" "words." "All" "16" "lyric" "lines" "sit" "on" "their" "notes." "Bible" "text:" "Open" "Source" "English" "(OSEN)," "CC" "BY" "4.0," "from" "SBLGNT" "and" "tanach.us." }
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
  \clef treble \key c \major \tempo 4 = 102
  \time 2/4 \sectionLabel "Intro" R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | \sectionLabel "Verse 1" e''8 g''8 g''8 e''8 | d''4 g''4 | c''2 | r4. c''8 | a''4 a''4 | g''4 e''4 | d''2 | R1*1/2 | e''8 g''8 g''4 | d''8 g''8 g''8 b'8 | c''4 r8 c'''8 | a''4 g''4 | e''2 | d''4. c''8 | c''2 | \sectionLabel "Chorus" r4 e''8 d''8 | c''4 c'''8. b''16 | a''8 g''8 g''8 c''8 | d''2 | r8 c''16 e''8. d''8 | c''8 c''16 c'''8. b''8 | a''4 r8 g''16 g''16 | g''8 g''16 a''8. b''8 | c'''4 b''4 | a''2 | r4 c'''8 b''8 | g''2 | R1*1/2 | \sectionLabel "Verse 2" e''8 g''8 g''8 e''8 | d''4 g''4 | c''2 | r4. c''8 | a''4 a''4 | g''4 e''4 | d''2 | r8 e''8 d''8 c''8 | c''4 c'''4 | b''4 g''4 | a''4 g''4 | r8 c''8 d''8 e''8 | f''2 | e''2 | c''2 | \sectionLabel "Chorus" r4 e''8 d''8 | c''4 c'''8. b''16 | a''8 g''8 g''8 c''8 | d''2 | r8 c''16 e''8. d''8 | c''8 c''16 c'''8. b''8 | a''4 r8 g''16 g''16 | g''8 g''16 a''8. b''8 | c'''4 b''4 | a''2 | r4 c'''8 b''8 | g''2 ~ | g''2 | \sectionLabel "Outro" R1*1/2 | R1*1/2 | R1*1/2 | \time 5/8 R1*5/8 | \time 2/4 R1*1/2 | R1*1/2 | R1*1/2 |
  \bar "|."
}
harmony = \chordmode { s1*1/4 c1*3/4 g1*1/2 a1*1/2:m f1*1/4 g1*1/4 c1*1/2 g1*1/2 f1 c1*1/2 g1*1/2/b a1:m f1*1/2 c1*1/2/e g1 c1*1/2 g1*1/2/b a1*1/2:m f1*1/2 c1*1/2/g g1*1/2 c1*1/2 c1*1/4 g1*1/4/b a1*1/2:m f1*1/2 g1 a1*1/2:m f1*1/2 g1*1/2 a1*1/4:m g1*1/4 f1 g1 c1*1/2 g1*1/2 a1:m f1*1/2 c1*1/2/e g1 a1*1/2:m e1*1/2:m f1*1/2 c1*1/2/e d1*1/2:m7 g1*1/2 c1*1/2 c1*1/4 g1*1/4/b a1*1/2:m f1*1/2 g1 a1*1/2:m f1*1/2 g1*1/2 a1*1/4:m g1*1/4 f1 g1 c1*1/2 g1*1/2 f1*1/2 g1*7/8 c1*5/4 }
words = \lyricmode { "When" "I" "look" "up" "at" "the" "sky" "The" "moon" "and" "stars" "you" "made" "What" "are" "we" "that" "you" "think" "of" "us" "And" "care" "for" "us" "each" "day" _ "Lord," "our" "Lord," "how" "ma" -- "jes" -- "tic" "is" "your" "name" "In" "all" "the" "earth," "in" "all" "the" "earth" "From" "the" "mouths" "of" "chil" -- "dren" "you" "made" "strength" "Lord," "our" "Lord" "Ev" -- "ery" "lit" -- "tle" "voice" "can" "sing" "And" "ev" -- "ery" "child" "can" "pray" "You" "set" "your" "splen" -- "dor" "in" "the" "heav" -- "ens" "And" "hear" "the" "songs" "we" "raise" "Lord," "our" "Lord," "how" "ma" -- "jes" -- "tic" "is" "your" "name" "In" "all" "the" "earth," "in" "all" "the" "earth" "From" "the" "mouths" "of" "chil" -- "dren" "you" "made" "strength" "Lord," "our" "Lord" }
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
