\version "2.24.0"
\header {
  title = "Arise, My Love"
  subtitle = "Song of Songs 2"
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
  \clef treble \key d \minor \tempo 4 = 82
  \time 4/4 R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | \sectionLabel "Verse 1" r4. d''8 d''8 e''8 f''8 g''8 | a''8 a''4. g''4 bes''4 | a''4 r4 d''8 e''8 f''8 g''16 a''16 | a''4 g''4 f''8 e''8 d''8 c''16 bes'16 | a'4 r4 d''8 e''8 f''8 g''8 | a''4. a''8 g''4 bes''4 | a''4 r8. a''16 bes''8 a''8 g''8 f''8 | g''4. g''8 f''8 e''8 d''8 c''8 | d''4 r4 e''4 d''8 c''8 | d''1 | \sectionLabel "Chorus" r2 a''4 c'''4 | d'''4. d'''8 c'''8. bes''8. a''8 | a''4 r8 a''8 a''4 g''8 f''8 | g''2 f''4 e''4 | d''4 r8 a''8 a''4 c'''8 c'''8 | d'''2 c'''4 bes''8 a''8 | a''4 r8 a''8 a''4 g''8 f''8 | g''2 f''4 e''4 | d''1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | \sectionLabel "Verse 2" r4. d''8 d''4 e''4 | f''2 e''4 c''4 | d''4 r8 d''8 d''8. e''8. f''8 | a''4 g''4 f''8. e''8. c''8 | e''4 d''8 a''8 a''8 bes''16 g''16 g''16 r16 g''8 | a''4. a''8 g''8. g''8. bes''8 | a''4 r4 a''8. g''8. f''8 | g''1 ~ | \sectionLabel "Chorus" g''2 a''4 c'''4 | d'''4. d'''8 c'''8. bes''8. a''8 | a''4 r8 a''8 a''4 g''8 f''8 | g''2 f''4 e''4 | d''4 r8 a''8 a''4 c'''8 c'''8 | d'''2 c'''4 bes''8 a''8 | a''4 r8 a''8 a''4 g''8 f''8 | g''2 f''4 e''4 | d''1 | \sectionLabel "Outro" R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 |
  \bar "|."
}
harmony = \chordmode { s1*1/4 d1*35/4:m g1*2:m d1:m d1*3:m g1:m d1*3:m c1 bes1*1/2 c1*1/2 d1:m d1:m bes1*1/2 c1*1/2 d1:m c1 d1:m bes1*1/2 c1*1/2 d1:m c1 d1*3:m g1*2:m d1:m d1*3:m g1:m d1*3:m c1 c1 bes1*1/2 c1*1/2 d1:m c1 d1:m bes1*1/2 c1*1/2 d1:m c1 d1:m d1*2:m g1*2:m d1*2:m }
words = \lyricmode { "The" _ _ "voice" "of" "my" "belo" -- "ved," "look," "he" "comes" _ "Leap" -- "ing" "o" -- "ver" "the" "moun" -- "tains," "bound" -- "ing" "o" -- "ver" "the" "hills" "My" "belo" -- "ved" "speaks" "and" "says" "to" "me" _ _ "A" -- "rise," "my" "love," "my" "beau" -- "ti" -- "ful" "one," "and" "come" "a" -- "way" "For" "be" -- "hold," "the" "win" -- "ter" "is" "past" "The" _ "rain" "is" "o" -- "ver" "and" "gone" "The" _ "flow" -- "ers" "ap" -- "pear" "on" "the" "earth" "The" _ "time" "of" "sin" -- "ging" "has" "come" "The" "fig" "tree" "ri" -- "pens" "its" "figs" "The" "vines" "are" "in" "blos" -- "som," "they" "give" "their" "fra" -- "grance" _ _ _ "A" -- "rise," "my" "love," "my" "beau" -- "ti" -- "ful" "one" "And" "come" "a" -- "way" "For" "be" -- "hold," "the" "win" -- "ter" "is" "past" "The" "rain" "is" "o" -- "ver" "and" "gone" _ "The" "flow" -- "ers" "ap" -- "pear" "on" "the" "earth" _ "The" "time" "of" "sin" -- "ging" "has" "come" _ }
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
