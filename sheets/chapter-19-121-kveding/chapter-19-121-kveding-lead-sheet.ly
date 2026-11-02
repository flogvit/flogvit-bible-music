\version "2.24.0"
\header {
  title = "Jeg løfter mine øyne mot fjellene"
  subtitle = "Psalm 121"
  tagline = ##f
  copyright = \markup \small \wordwrap { "Melody" "and" "chords" "from" "the" "score" "YuE2" "generated" "the" "song" "from" "(score.abc)." "Lyrics" "placed" "syllable" "by" "syllable" "against" "the" "recording" "with" "Whisper," "which" "heard" "106" "of" "106" "words." "All" "16" "lyric" "lines" "sit" "on" "their" "notes." "Bible" "text:" "Open" "Source" "English" "(OSEN)," "CC" "BY" "4.0," "from" "SBLGNT" "and" "tanach.us." }
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
  \clef treble \key d \minor \tempo 4 = 87
  \time 3/4 R1*3/4 | R1*3/4 | R1*3/4 | R1*3/4 | \sectionLabel "Verse 1" r2 r8 d''8 | d''4 a''8 a''4 g''16 f''16 | e''4 d''4 r8 d''8 | d''4 a''8 a''4 c'''8 ~ | c'''8 a''4 r4 d''8 | d''4 a''8 a''16 r16 a''8. g''16 | e''4. d''8. c''8. | d''16 f''8. r4. d''8 | \sectionLabel "Verse 2" d''4 r4. d''8 | d''8. a''8. a''4 f''8 | e''4 d''8 r8 d''8 d''8 | d''8. a''8. a''8 g''16 f''8. | g''8. a''16 ~ a''8 f''8 e''8 d''8 | d''8 r8 a''8 a''8. g''16 f''16 e''16 | e''8. d''16 c''8 d''4 d''8 | d''4 f''8 e''8 d''16 c''8. ~ | c''16 r16 d''4 r4. | \sectionLabel "Verse 3" r2 r8 d''8 | d''4. a''8. g''8. | e''4 d''16 c''16 d''4 d''8 | d''8 d''8 a''8 a''8 g''8 f''8 | g''4. d''4 c''8 | d''8 d''8 a''8 a''8 g''8 f''16 e''16 | e''4 r4 d''8 c''16 d''16 ~ | d''4 ~ d''16 r16 f''4. | \sectionLabel "Verse 4" d''2 r8 d''8 | d''8. a''8. a''8 g''8 f''16 e''16 ~ | e''8. r16 d''8 r4. | d''8 d''16 a''8. a''8 g''8 f''8 | g''4 ~ g''4 r8 d''8 | d''8 d''16 a''8. a''8 g''16 f''8. | e''4 d''16 c''16 d''4 c''8 | d''4. f''16 e''4 r16 | d''4 r2 | d''2 r8 e''16 f''16 | e''2 d''8 c''8 | \sectionLabel "Interlude" d''16 d''4 r16 d''4. ~ | d''4. r4. | R1*3/4 | R1*3/4 | R1*3/4 | R1*3/4 | R1*3/4 | R1*3/4 | R1*3/4 |
  \bar "|."
}
harmony = \chordmode { s1*5/8 d1*19/8:m d1*15/4:m bes1*3/4 c1*3/4 g1*3/4:m g1*3/4:m d1*3/4:m c1*1/4 d1*5/4:m c1*1/4 d1*1/2:m bes1*3/4 c1*3/4 g1*3/4:m d1*3/4:m d1*3/4:m bes1*3/4 c1*3/4 d1*3/2:m bes1*3/4 c1*3/4 g1*3/4:m g1*3/4:m d1*3/4:m c1*1/4 d1*5/4:m c1*1/4 d1*1/2:m bes1*3/4 c1*3/4 g1*3:m d1*3:m bes1*3/4 c1*3/4 d1*9/4:m }
words = \lyricmode { "I" "lift" "my" "eyes" "to" "the" "moun" -- "tains" "Where" "will" "my" "help" "come" "from" "My" _ "help" "comes" "from" "the" "LORD" "Who" "made" "heav" -- "en" "and" "earth" "He" "will" "not" "let" "your" "foot" "slip" "He" _ "who" "watch" -- "es" "o" -- "ver" "you" "will" "not" "slum" -- "ber" _ "See," "he" "who" "watch" -- "es" "o" -- "ver" "Is" -- "rael" "Will" "nei" -- "ther" "slum" -- "ber" "nor" "sleep" "The" "LORD" "watch" -- "es" "o" -- "ver" "you" _ _ "The" "LORD" "is" "your" "shade" "at" "your" "right" "side" "The" "sun" "will" "not" "strike" "you" "by" "day" "Nor" "the" "moon" "by" "night" "The" "LORD" "will" "keep" "you" "from" "all" "harm" "He" "will" "watch" "o" -- "ver" "your" "life" "The" _ "LORD" "will" "watch" "o" -- "ver" "your" "go" -- "ing" "out" "and" "your" "com" -- "ing" "in" "Now" "and" "fo" -- "re" -- "ver" -- "more" _ _ \skip 1 }
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
