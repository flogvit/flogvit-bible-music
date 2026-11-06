\version "2.24.0"
\header {
  title = "Kingdom of God"
  subtitle = "Matthew 12:22–32"
  tagline = ##f
  copyright = \markup \small \wordwrap { "Melody" "and" "chords" "from" "the" "score" "YuE2" "generated" "the" "song" "from" "(score.abc)." "Lyrics" "placed" "syllable" "by" "syllable" "against" "the" "recording" "with" "Whisper," "which" "heard" "117" "of" "118" "words." "20" "of" "22" "lyric" "lines" "sit" "clearly" "on" "their" "notes;" "2" "are" "uncertain" "and" "printed" "in" "grey" "italics." "Bible" "text:" "Open" "Source" "English" "(OSEN)," "CC" "BY" "4.0," "from" "SBLGNT" "and" "tanach.us." }
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
  \clef treble \key bes \major \tempo 4 = 84
  \time 4/4 R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | \sectionLabel "Verse 1" r4. r16 bes'16 f''8 f''8 d''8 c''8 ~ | c''8 bes'4 d''8 r2 | r4. bes'8 f''8. f''8 d''16 d''8 ~ | d''8 r4. r2 | r4. f''8 f''8 f''16 f''8 d''8 c''16 ~ | c''8 r4. r2 | r4. r16 bes'16 d''8 d''16 d''8 c''16 c''8 | R1*1 | \sectionLabel "Chorus" r4. r16 bes'16 bes''8. a''8 f''8. | g''2 f''4. d''8 ~ | d''8 r4. bes''8. a''8. f''8 | g''2 f''4. d''8 ~ | d''8 r4 bes'16 bes'16 bes''8. a''8 f''8. | es''4 r4 r2 | r4. d''8 d''8 d''16 d''8 c''8 bes'16 ~ | bes'8 r4. r2 | R1*1 | \sectionLabel "Verse 2" r4. r16 bes'16 f''8 f''16 f''8 d''16 d''8 ~ | d''8 r4 f''8 f''8 f''16 f''8. d''16 d''16 ~ | d''8 r4. r2 | r4 d''16 f''8 f''16 ~ f''8 f''16 f''8 d''8 d''16 ~ | d''8 es''4 r8 r2 | r4. r16 bes'16 d''8 d''16 d''8 c''8 c''16 ~ | c''8. r4 r16 r2 | \sectionLabel "Chorus" r4. r16 bes'16 bes''8. a''8 f''8. | g''2 f''4. d''8 ~ | d''8 r4. bes''8. a''8. f''8 | g''2 f''4. d''8 ~ | d''8 r4 bes'16 bes'16 bes''8. a''8 f''8. | es''4 r4 r2 | r4. d''8 d''8 d''16 d''8 c''16 bes'16 bes'16 ~ | bes'8 r4. r2 | \sectionLabel "Bridge" r2 r4. d''16 f''16 | g''8. g''8. g''8 ~ g''8 f''4 a''8 ~ | a''4 r4 r4. r16 a''16 | bes''8. a''8. f''8 ~ f''8 d''4 d''8 ~ | d''8 r4. r4. f''8 | g''8. g''8. g''8 ~ g''8 f''16 f''8. d''8 | c''4 r4 r4. bes'8 | es''2 d''2 | c''4 r4 r4. bes'16 bes'16 ~ | bes'8 r4. r2 | \sectionLabel "Outro" r4. r16 bes'16 bes''8. a''8 f''8. | g''2 f''4. d''8 ~ | d''8 r4. r2 | r4. bes'16 bes'16 d''8 c''16 c''8 bes'8 bes'16 ~ | bes'8. r4 r16 r2 | R1*1 | \time 2/4 R1*1/2 |
  \bar "|."
}
harmony = \chordmode { bes1*3 es1 bes1 es1 bes1*2 g1*2:m es1*2 f1 f1 es1*1/2 f1*1/2 bes1 es1*1/2 f1*1/2 g1:m es1 f1 bes1*2 bes1*2 g1*2:m es1*2 f1 f1 es1*1/2 f1*1/2 bes1 es1*1/2 f1*1/2 g1:m es1 f1 bes1 bes1 es1 f1 bes1*1/2 f1*1/2/a g1:m es1 f1 es1 f1 bes1 bes1 es1*1/2 f1*1/2 bes1 es1*1/2 f1*1/2 bes1*5/2 }
words = \lyricmode { "A" "man" "who" "is" "blind" "and" "mute" "Was" "brought" "to" "the" "Lord" "He" "healed" "the" "bro" -- "ken" "soul" "And" "ope" -- "ned" "up" "the" "door" "The" "kin" -- "gdom" "of" "God" "has" "come" "Right" _ "here" "in" "our" "sight" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "By" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "the" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "Spir" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "it" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "of" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "God" "He" "sets" "the" "peo" -- "ple" "right" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "The" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "crowds" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "were" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "all" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "a" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "mazed" "They" "asked" "the" "crowd" "to" "see" "Could" "this" "be" "the" "Son" "of" "Da" -- "vid" "The" "one" "who" "sets" "us" "free" "The" "kin" -- "gdom" "of" "God" "has" "come" "Right" _ "here" "in" "our" "sight" "By" "the" "Spir" -- "it" "of" "God" "He" "sets" "the" "peo" -- "ple" "right" _ "A" "di" -- "vid" -- "ed" "house" "will" "fall" "A" "kin" -- "gdom" "can" -- "not" "stand" "If" "Sa" -- "tan" "fights" "a" -- "gainst" "him" -- "self" "Then" "how" "can" "he" "com" -- "mand" "The" "kin" -- "gdom" "of" "God" "has" "come" "By" "the" "Spir" -- "it" "of" "God" _ }
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
