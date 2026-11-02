\version "2.24.0"
\header {
  title = "My Heart Exults in the Lord"
  subtitle = "1 Samuel 2:1–8"
  tagline = ##f
  copyright = \markup \small \wordwrap { "Melody" "and" "chords" "from" "the" "score" "YuE2" "generated" "the" "song" "from" "(score.abc)." "Lyrics" "placed" "syllable" "by" "syllable" "against" "the" "recording" "with" "Whisper," "which" "heard" "98" "of" "105" "words." "12" "of" "16" "lyric" "lines" "sit" "clearly" "on" "their" "notes;" "4" "are" "uncertain" "and" "printed" "in" "grey" "italics." "Bible" "text:" "Open" "Source" "English" "(OSEN)," "CC" "BY" "4.0," "from" "SBLGNT" "and" "tanach.us." }
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
  \clef treble \key c \minor \tempo 4 = 88
  \time 4/4 R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | \time 3/8 R1*3/8 | \time 4/4 R1*1 | \sectionLabel "Verse 1" r2. c''4 | g''4 g''8 f''16 r16 f''4 es''8 d''8 | es''4 r2 c''4 | g''8 g''8 g''8 f''8 f''4 es''8 d''8 | es''4 r2 c''4 | c'''4 c'''8 bes''16 r16 bes''8 as''8 g''8 f''8 | g''2 r4 c''8 c''8 | f''2 r8 es''8 d''4 | \sectionLabel "Chorus" c''16 r16 c''4. r4. c''8 | c''4 es''4 f''4 f''8 es''8 | g''4 es''4 d''4 r8 c''8 | c''4 es''8 es''8 f''4 f''8 es''8 | g''4 r2 r8 c''8 | c'''4 c'''8 bes''8 bes''8 as''8 g''8 f''8 | g''2 c''4 r8 c''8 | f''2. es''4 | \sectionLabel "Verse 2" d''4 c''2 r8 c''8 | c''4 es''8 es''8 f''4 f''8 es''8 | g''4 es''4 d''4 r8 c''8 | c''4 es''8 es''8 f''4 f''8 es''8 | g''2 r4. c''8 | c'''4 c'''8 bes''8 bes''4 as''8 g''8 | g''2 c''4 r8 c''8 | f''2 f''4. es''8 | d''2 bes'2 | \sectionLabel "Chorus" c''2. r8 c''8 | c''4 es''4 f''4 f''8 es''8 | g''4 es''4 d''4 r8 c''8 | c''4 es''8 es''8 f''4 f''8 es''8 | g''2 r4. c''8 | c'''4 c'''8 bes''16 r16 bes''8 as''8 g''8 f''8 | g''2 c''4 r8 c''8 | f''2. es''4 | d''4 c''2 r4 | \sectionLabel "Outro" R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 |
  \bar "|."
}
harmony = \chordmode { s1*1/2 c1*55/8:m c1*5:m as1*2:maj7 bes1 c1*7:m bes1 c1*7:m bes1*2 c1*7:m bes1 c1:m c1*6:m bes1 c1*2:m }
words = \lyricmode { \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "My" _ \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "heart" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "ex" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "ults" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "in" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "the" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "Lord" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "My" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "strength" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "is" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "lift" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "ed" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "up" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "in" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "the" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "Lord" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "There" _ \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "is" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "none" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "ho" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "ly" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "like" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "the" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "Lord" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "There" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "is" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "none" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "be" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "sides" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "you" \skip 1 "The" _ "Lord" "brings" "low" "and" "he" "lifts" "up" "He" "rais" -- "es" "the" "poor" "from" "the" "dust" "He" _ "lifts" "the" "nee" -- "dy" "from" "the" "ash" "heap" "To" "sit" "with" "prin" -- "ces" "The" _ "bows" "of" "the" "mig" -- "hty" "are" "bro" -- "ken" "The" _ "fee" -- "ble" "are" "clothed" "with" "strength" "The" _ "bar" -- "ren" "has" "borne" "sev" -- "en" _ "The" "Lord" "kills" "and" "brings" "to" "life" "The" _ "Lord" "brings" "low" "and" "he" "lifts" "up" "He" "rais" -- "es" "the" "poor" "from" "the" "dust" "He" _ "lifts" "the" "nee" -- "dy" "from" "the" "ash" "heap" "To" "sit" "with" "prin" -- "ces" }
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
