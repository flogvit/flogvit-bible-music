\version "2.24.0"
\header {
  title = "More Than an Ox"
  subtitle = "Psalms 69:31"
  tagline = ##f
  copyright = \markup \small \wordwrap { "Melody" "and" "chords" "from" "the" "score" "YuE2" "generated" "the" "song" "from" "(score.abc)." "Lyrics" "placed" "syllable" "by" "syllable" "against" "the" "recording" "with" "Whisper," "which" "heard" "135" "of" "140" "words." "All" "18" "lyric" "lines" "sit" "on" "their" "notes." "Bible" "text:" "Open" "Source" "English" "(OSEN)," "CC" "BY" "4.0," "from" "SBLGNT" "and" "tanach.us." }
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
  \clef treble \key bes \major \tempo 4 = 75
  \time 4/4 \sectionLabel "Intro" R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | \sectionLabel "Verse 1" r8 d''8 d''8 f''8 f''8 d''16 c''16 bes'16 bes'16 bes'16 r16 | r8 d''2 r4. | r8 es''8 es''8 f''8 f''8 d''16 c''8 bes'8. ~ | bes'16 r16 d''2 r4. | r8 d''8 d''8 f''16 f''16 ~ f''8 g''16 bes''8. c'''8 ~ | c'''8 bes''4 g''16 g''4 r4 r16 | r8 bes''8 bes''8 g''16 f''16 g''8 bes''8 c'''8 c'''8 ~ | \sectionLabel "Chorus" c'''2 ~ c'''8 r8 d'''8 c'''16 bes''16 | bes''4 d'''4 c'''4 a''4 | g''4 g''8 g''4 r8 d'''8 c'''16 bes''16 | bes''4 d'''4 c'''4 bes''4 | a''4 bes''8 a''4 g''16 f''16 d'''8 c'''16 bes''16 | bes''4 d'''4 c'''4 a''8. g''16 | g''4 g''8 g''4 r8 f''16 g''16 bes''8 | c'''4 d'''8 c'''8 ~ c'''4 bes''8 bes''8 ~ | bes''2 ~ bes''8 r4. | R1*1 | \sectionLabel "Verse 2" r8 d''8 d''8 f''8 f''4 c''8 bes'8 | c''4 d''8 d''16 c''16 bes'4 r4 | r16 bes'16 es''8 es''8 f''8 f''8 d''16 c''16 bes'16 bes'8. ~ | bes'16 r16 d''4. r2 | r4 d''8 f''16 f''8. g''16 g''16 bes''8 c'''8 ~ | c'''8 d'''8 bes''2 r4 | es'''8 d'''8 c'''8 bes''8 bes''8 g''16 bes''8 d'''8. | \sectionLabel "Chorus" c'''2 f'''4 d'''8 c'''16 bes''16 | bes''4 d'''4 c'''4 a''8. g''16 | g''4 g''8 g''4 r8 d'''8 c'''16 bes''16 | bes''4 d'''4 c'''4 bes''4 | a''4 a''8 a''4 g''16 f''16 d'''8 c'''16 bes''16 | bes''4 d'''8. c'''16 c'''4 a''8. g''16 | g''4 g''8 g''4 r8 f''16 g''16 bes''8 | c'''4 d'''8 c'''8 ~ c'''4 bes''8 bes''8 ~ | \sectionLabel "Outro" bes''2 ~ bes''8 r8 d'''8 c'''16 bes''16 | bes''4 d'''4 c'''4 a''8. g''16 | g''4 g''8 g''4 r4. | R1*1 | r2. d'''8 c'''16 bes''16 | bes''4 d'''4 c'''4 a''4 | g''4 g''8 g''4 r8 f''16 g''16 bes''8 | c'''4 d'''8 c'''8 ~ c'''4 bes''8 bes''8 ~ | bes''2. ~ bes''8 r8 | R1*1 |
  \bar "|."
}
harmony = \chordmode { s1*7/8 bes1*5/8 f1*1/2/a es1/g bes1*1/2 f1*1/2/a es1 bes1*1/2 f1*1/2/a g1:m es1 bes1*3/2 f1*1/2/a g1:m es1 f1 bes1*1/2 f1*1/2/a g1:m es1 f1 bes1*1/2 f1*1/2/a g1:m es1*1/2 f1*1/2 bes1 es1*1/4:maj7 es1*1/4:6 es1*1/2 bes1*3/4 f1*1/4/a g1:m7 es1 bes1*7/4 f1*1/4/a g1:m es1 f1 bes1*1/2 f1*1/2/a g1:m es1 f1 bes1*1/2 f1*1/2/a g1:m es1*1/2 f1*1/2 bes1*3/2 f1*1/2/a g1:m es1*1/2 f1*1/2 bes1*3/2 f1*1/2/a g1:m es1*1/2 f1*1/2 bes1*2 }
words = \lyricmode { "I" _ "am" "af" -- "flict" -- "ed" "and" "in" "pain" "Let" \skip 1 "your" "sal" -- "va" -- "tion" "lift" "me" "high" "Out" _ "of" "the" "dust" "and" "out" "of" "shame" _ "I" _ "see" "your" "light" "in" "the" "sky" "I" _ "will" "praise" "the" "name" "of" "God" "with" "song" "I" _ "will" "mag" -- "ni" -- "fy" "him" "with" "thanks" -- "giv" -- "ing" _ "This" _ "will" "please" "the" "LORD" "more" _ "than" "an" "ox" "More" "than" "a" "bull" "with" "horns" "and" "hooves" "You" _ "who" "seek" "God" "let" "your" "hearts" "re" -- "vive" _ "The" _ "hum" -- "ble" "will" "see" "it" "and" "be" "glad" "For" "the" "LORD" "hears" "the" "nee" -- "dy" "cry" _ "He" _ "does" "not" "de" -- "spise" "his" "own" "in" "chains" _ "I" "will" "praise" "the" "name" "of" _ "God" "with" "song" "I" _ "will" "mag" -- "ni" -- "fy" "him" "with" "thanks" -- "giv" -- "ing" _ _ _ "This" "will" "please" "the" "LORD" "more" _ "than" "an" "ox" "More" "than" "a" "bull" "with" "horns" "and" "hooves" "I" _ "will" "praise" "the" "name" "of" "God" "with" "song" _ "This" "will" _ "please" "the" "LORD" "more" "than" "an" "ox" \skip 1 \skip 1 \skip 1 \skip 1 \skip 1 \skip 1 \skip 1 \skip 1 }
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
