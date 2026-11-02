\version "2.24.0"
\header {
  title = "Over Jordan"
  subtitle = "Joshua 3:14–17; Deuteronomy 34:1–4"
  tagline = ##f
  copyright = \markup \small \wordwrap { "Melody" "and" "chords" "from" "the" "score" "YuE2" "generated" "the" "song" "from" "(score.abc)." "Lyrics" "placed" "syllable" "by" "syllable" "against" "the" "recording" "with" "Whisper," "which" "heard" "94" "of" "95" "words." "All" "16" "lyric" "lines" "sit" "on" "their" "notes." "Bible" "text:" "Open" "Source" "English" "(OSEN)," "CC" "BY" "4.0," "from" "SBLGNT" "and" "tanach.us." }
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
  \clef treble \key d \minor \tempo 4 = 104
  \time 4/4 R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | \sectionLabel "Verse 1" r2 d''2 | d''8 a''8 a''8 g''8 g''4 f''8 e''8 | d''4 r2 f''4 | g''4 a''4 c'''4 b''8 a''8 | a''4. r4. d''4 | d''8 a''8 a''8 g''8 g''4 f''8 e''8 | d''4 r2 d''4 | f''4 g''4 e''8 d''8 c''8 d''8 | \sectionLabel "Verse 2" d''2 r4. a''8 | d'''4 d'''4 c'''4. a''8 | g''4 a''8 c'''8 a''4 r8 d''8 | f''4 f''4 g''4 f''8 g''8 | a''8 c'''8 b''8 a''8 a''4 r8 a''8 | d'''4 d'''4 c'''4 a''8 g''16 r16 | g''4 a''8 c'''8 a''4 r8 d''8 | f''4 g''8 a''8 e''8 d''8 c''8 d''8 | d''2. r4 | \sectionLabel "Verse 3" r2. d''4 | d''8 a''8 a''8 g''8 g''4 f''8 e''8 | d''2 r4 f''4 | g''4 a''4 c'''4 b''8 a''8 | a''2 r4 d''4 | d''8 a''8 a''8 g''8 g''4 f''8 e''8 | d''2 r4 d''4 | f''4 g''8 a''8 e''8 d''8 c''8 d''8 | \sectionLabel "Verse 4" d''2 r4 a''4 | d'''4 d'''4 c'''4 a''4 | g''4 a''8 c'''8 a''4 r8 d''8 | f''4 f''4 g''4 f''8 g''8 | a''8 c'''8 b''8 a''8 a''4 r8 a''8 | d'''4 d'''4 c'''4 a''8 g''16 r16 | g''4 a''8 c'''8 a''4 r4 | f''2 g''8 a''4. | \time 7/8 e''2 c''4. | \time 4/4 R1*1 | \sectionLabel "Outro" d''1 ~ | d''1 ~ | d''1 | R1*1 |
  \bar "|."
}
harmony = \chordmode { d1*8:m d1*8:m d1:m bes1:maj7 c1*1/2 d1*1/2:m bes1*1/2 c1*1/2 f1*1/2 a1*1/2:m bes1 c1*1/2 d1*1/2:m bes1*1/2 c1*1/2 d1:m d1*3/2:m c1*1/2 bes1 c1 d1*3/2:m c1*1/2 bes1 g1*1/2:m7 a1*1/2:m7 d1:m bes1 c1*1/2 d1*1/2:m bes1*1/2 c1*1/2 f1*1/2 a1*1/2:m bes1 c1*1/2 d1*1/2:m bes1 c1*15/8 d1*4:m }
words = \lyricmode { "On" _ "Ne" -- "bo's" "height" "old" "Mo" -- "ses" "stood" "And" _ "looked" "on" "Ca" -- "naan's" "land" "The" _ "Lord" "showed" "him" "the" "promi" -- "sed" "good" "Laid" _ "out" "on" "ev" -- "ery" "hand" _ "The" _ "priests" "went" "down" "to" "Jor" -- "dan's" "flood" "The" _ "ark" "up" -- "on" "their" "shoul" -- "ders" "high" _ _ "The" _ "wa" -- "ters" "stood" _ "up" "where" "they" "stood" "And" _ "Is" -- "rael" "passed" "by" "dry" _ _ "So" _ "when" "I" "come" "to" "Jor" -- "dan's" "side" "And" "hear" "the" "wa" -- "ters" "roar" _ "The" _ "Lord" "will" "part" "the" "swel" -- "ling" "tide" "And" "lead" "me" "safe" -- "ly" "o" -- "'er" _ _ "Then" "I" "shall" "stand" "on" "Ca" -- "naan's" "ground" _ "And" "see" "the" "promi" -- "sed" "land" _ _ _ _ _ "Where" "milk" "and" "hon" -- "ey" "flow" "a" -- "round" _ _ "At" "God's" "own" "right" "hand" \skip 1 }
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
