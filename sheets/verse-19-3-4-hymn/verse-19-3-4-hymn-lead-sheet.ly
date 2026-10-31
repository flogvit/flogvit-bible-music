\version "2.24.0"
\header {
  title = "Shield Around Me"
  subtitle = "Psalms 3:4–5"
  tagline = ##f
  copyright = \markup \small \wordwrap { "Melody" "and" "chords" "from" "the" "score" "YuE2" "generated" "the" "song" "from" "(score.abc)." "Lyrics" "placed" "syllable" "by" "syllable" "against" "the" "recording" "with" "Whisper," "which" "heard" "151" "of" "153" "words." "All" "22" "lyric" "lines" "sit" "on" "their" "notes." "Bible" "text:" "Open" "Source" "English" "(OSEN)," "CC" "BY" "4.0," "from" "SBLGNT" "and" "tanach.us." }
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
  \clef treble \key bes \major \tempo 4 = 74
  \time 4/4 \sectionLabel "Intro" R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | \sectionLabel "Verse 1" bes8 f'8 f'16 d'8 g'16 ~ g'8. g'16 g'8 f'16 d'16 | d'4 r2. | r4 d'16 f'8 g'16 ~ g'8. g'16 g'8 f'8 | d'4 r2 r8 bes'8 | bes'8 c''16 d''8 bes'8 c''16 ~ c''4 ~ c''16 r16 bes'16 bes'16 ~ | bes'8 r2 r8 r4 | r8 es'8 es'8 d'16 d'16 ~ d'8. r16 c'16 bes8 bes16 ~ | \sectionLabel "Chorus" bes8 r2 r8 d''16 f''8. | g''4 g''8 f''16 f''16 ~ f''4 ~ f''16 r16 d''16 d''16 ~ | d''8 c''4 r2 f''8 | g''8. g''8. f''8 f''8. es''8. d''8 | c''4 r4. d''8 c''8 bes'16 bes'16 ~ | bes'4 ~ bes'16 r16 bes'8 g''4 f''8 d''8 ~ | d''16 c''16 bes'8 r4. d''8 c''8 bes'16 bes'16 ~ | bes'8. r16 c''16 d''8 c''16 c''4. bes'16 c''16 ~ | c''8 bes'4 r2 r8 | \sectionLabel "Verse 2" r4 d'16 f'8 g'16 ~ g'8 g'8 g'16 f'8. | d'4 r2 r4 | r8. bes16 d'8 f'16 g'16 ~ g'8. g'16 g'8 f'8 ~ | f'8 d'4 r4. r8. bes'16 | bes'8 c''16 d''8 c''16 bes'8 c''4 bes'8 bes'8 ~ | bes'16 g'16 f'8 r2 r4 | r4 es'16 d'8 d'16 ~ d'16 c'8 c'8. bes8 ~ | \sectionLabel "Chorus" bes8 bes4. r4 d''16 f''8. | g''4 g''8 f''16 f''16 ~ f''4 ~ f''16 r16 d''16 d''16 ~ | d''8 c''4 r2 f''8 | g''8. g''8. f''8 f''8. es''8. d''8 | c''4 r4. d''8 c''8 bes'16 bes'16 ~ | bes'4 ~ bes'16 r16 bes'8 g''4 f''8 d''8 ~ | d''16 c''16 bes'8 r4. d''8 c''8 bes'16 bes'16 ~ | bes'8. r16 c''16 d''8. c''4. bes'16 c''16 ~ | c''8 bes'4 r2 r8 | \sectionLabel "Bridge" r4 d''8 d''8 es''8 es''8 es''8. d''16 | d''4 r2 r4 | r8 d''8 d''8 d''8 es''8. es''16 es''16 d''16 d''8 ~ | d''16 c''16 bes'8 r2 r4 | r8 d''8 d''8 d''16 es''16 ~ es''8 es''16 es''16 es''16 d''8. | d''16 c''16 bes'8 r2 r4 | r4. d''8 d''16 c''8. c''16 bes'8. ~ | \sectionLabel "Outro" bes'16 r16 bes'4 r2 f''8 | g''4 g''8 f''8 ~ f''4 es''16 d''8 d''16 | c''16 c''8. r2 r8 f''8 | g''4 g''16 f''8 f''16 ~ f''8. r16 es''16 d''8 c''16 | c''4 r2. | R1*1 | R1*1 |
  \bar "|."
}
harmony = \chordmode { s1*7/8 bes1*5/8 es1*1/2 bes1 g1*1/2:m es1*1/2 bes1 bes1*1/2 es1*1/2 bes1 g1*1/2:m es1*1/2 bes1 g1*1/2:m f1*1/2 g1*3/4:m g1*1/4:m7 es1*1/2 f1*1/2 bes1 es1*1/2 bes1*1/2 f1 es1*1/2 bes1*1/2 f1 g1*1/2:m es1*1/2 bes1 es1*1/2 f1*1/2 bes1 bes1*1/2 es1*1/2 bes1*3/4 f1*1/4/a g1*1/2:m es1*1/2 bes1*3/4 f1*1/4/a g1*1/2:m f1*1/2 g1*3/4:m f1*1/4 es1*1/2 f1*1/2 bes1 es1*1/2 bes1*1/2 f1 es1*1/2 bes1*1/2 f1 g1*1/2:m es1*1/2 bes1 es1*1/2 f1*1/2 bes1 g1*1/2:m es1*1/2 bes1*3/4 f1*1/4/a g1*1/2:m es1*1/2 bes1*3/4 f1*1/4/a g1*1/2:m es1*1/2 bes1*3/4 f1*1/4/a es1*1/2 f1*1/2 bes1 es1*1/2 bes1*1/2 f1 es1*1/2 bes1*1/2 f1 g1*1/2:m es1*1/2 bes1 }
words = \lyricmode { "LORD" _ "how" "ma" -- "ny" "foes" "sur" -- "round" "me" "now" "Ma" -- "ny" "rise" "to" "bring" "me" "down" "They" "say" "there" "is" "no" "help" "for" "me" "No" "hope" "in" "God" "to" "be" "seen" "But" "you" "LORD" "are" "a" "shield" "a" -- "round" "me" "My" "glo" -- "ry" "that" "lifts" "my" "head" "high" "I" _ "call" "a" -- "loud" "to" "you" "in" "need" _ "You" _ "an" -- "swer" "me" "from" "your" "ho" -- "ly" "moun" -- "tain" "I" "lie" "down" "and" "sleep" "in" "peace" "I" "wake" "a" -- "gain" "sus" -- "tained" "by" "grace" "The" "tens" _ "of" "thou" -- "sands" "on" "ev" -- "ery" "side" _ "Can" -- "not" "make" "me" "fear" "your" "ways" "But" "you" "LORD" "are" "a" "shield" "a" -- "round" "me" "My" "glo" -- "ry" "that" "lifts" "my" "head" "high" "I" _ "call" "a" -- "loud" "to" "you" "in" "need" _ "You" "an" -- "swer" "me" "from" "your" "ho" -- "ly" "moun" -- "tain" "Rise" "up" "LORD" "and" "save" "me" "now" "My" _ _ "God" "you" "strike" "the" "en" -- "e" -- "mies" "You" _ "break" _ "the" "teeth" "of" "the" "wic" -- "ked" "ones" "And" "bring" "them" "to" "their" "end" "You" _ "are" "my" "shield" "and" "my" "glo" -- "ry" "My" _ "head" "lift" -- "ed" "high" "in" "your" "light" }
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
