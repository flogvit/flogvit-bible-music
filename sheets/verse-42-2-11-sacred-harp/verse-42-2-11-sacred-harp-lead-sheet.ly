\version "2.24.0"
\header {
  title = "While Shepherds Watched in Bethlehem"
  subtitle = "Luke 2:11"
  tagline = ##f
  copyright = \markup \small \wordwrap { "Melody" "and" "chords" "from" "the" "score" "YuE2" "generated" "the" "song" "from" "(score.abc)." "Lyrics" "placed" "syllable" "by" "syllable" "against" "the" "recording" "with" "Whisper," "which" "heard" "97" "of" "98" "words." "All" "16" "lyric" "lines" "sit" "on" "their" "notes." "Bible" "text:" "Open" "Source" "English" "(OSEN)," "CC" "BY" "4.0," "from" "SBLGNT" "and" "tanach.us." }
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
  \clef treble \key c \major \tempo 4 = 110
  \time 4/4 R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | \sectionLabel "Verse 1" r2. c'4 | c'4 g'4 g'4 e'8 d'8 | d'4 e'4 e'4 r8 c'8 | c'4 a'4 a'4. f'8 | e'2 r4. c'8 | c'4 g'4 g'4. e'8 | d'4 e'4 e'4 r8 c'8 | c'4 a'4 g'4 e'8 d'8 | \sectionLabel "Verse 2" d'2 r4. c'8 | c'4 c''4 c''4. b'8 | a'4 g'4 g'4 r8 c'8 | c'4. d'8 e'4 f'8 e'8 | e'2 r4. c'8 | c'4 g'4 g'4. e'8 | d'4 e'4 e'4 r8 c'8 | c'4 a'4 g'4. e'8 | \sectionLabel "Verse 3" c'2 r4. c''8 | c''4 g''4 g''4 e''8 d''8 | d''4 e''4 e''4 r8 c''8 | c''4 a''4 a''4 f''4 | e''2 r4. c''8 | c''4 g''4 g''4. e''8 | d''4 e''4 e''4 r8 c''8 | c''4 a''4 g''4 e''8 d''8 | \sectionLabel "Verse 4" d''2 r4. c''8 | c''4 c'''4 c'''4. b''8 | a''4 g''4 g''4 r8 c''8 | c''4. d''8 e''4 f''4 | e''2 r4. c''8 | c''4 g''4 g''4. e''8 | d''8 d''8 e''4 e''4 r8 c''8 | c''4 a''4 g''4. e''8 | c''2 r2 | \sectionLabel "Outro" R1*1 | R1*1 | R1*1 |
  \bar "|."
}
harmony = \chordmode { s1*7/8 c1*17/8 f1 c1 a1:m7 c1:maj7/g f1*1/2 c1*1/2/e g1 c1*2 f1 c1 a1:m7 g1*1/2:6 c1*1/2:maj7/g f1*1/2 c1*1/2:maj7/g g1 a1:m7 f1*1/2 c1*1/2 f1*1/2 g1*1/2 a1:m a1:m7 g1*1/2 c1*1/2 f1*1/2 c1*1/2:maj7/g c1*3 f1 c1 a1:m7 g1:6 f1*1/2 c1*1/2:maj7/g g1 a1:m7 f1*1/2 c1*1/2 f1*1/2 g1*1/2:6 a1:m a1:m7 g1*1/2:6 c1*1/2 f1*1/2 g1*1/2:6 c1 c1*3 }
words = \lyricmode { "The" _ "shep" -- "herds" "in" "the" "field" "by" "night" "Were" "watch" -- "ing" "flocks" "of" "sheep" "When" "glo" -- "ry" "shone" "with" "sud" -- "den" "light" "And" _ "woke" "them" "from" "their" "sleep" "Fear" "not," "the" "shin" -- "ing" "an" -- "gel" "said" "Great" _ "joy" "to" "all" "I" "bring" "In" "Beth" -- "le" -- "hem" "a" "man" -- "ger" "bed" "Now" "holds" "your" "Lord" "and" "King" "And" _ "then" "a" "host" "of" "an" -- "gels" "came" "And" "filled" "the" "mid" -- "night" "sky" "They" "sang" "the" "glo" -- "ry" "of" "his" "name" "To" "God" "be" "praise" "on" "high" _ "And" "peace" "on" "earth" "to" "all" "be" -- "low" "With" "whom" "the" "Lord" "is" "pleased" "So" "let" "us" "all" "to" "Beth" -- "le" -- "hem" "go" "And" "see" "what" "God" "has" "seized" }
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
