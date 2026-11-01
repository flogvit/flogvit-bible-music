\version "2.24.0"
\header {
  title = "Out of the Depths"
  subtitle = "Psalm 130"
  tagline = ##f
  copyright = \markup \small \wordwrap { "Melody" "and" "chords" "from" "the" "score" "YuE2" "generated" "the" "song" "from" "(score.abc)." "Lyrics" "placed" "syllable" "by" "syllable" "against" "the" "recording" "with" "Whisper," "which" "heard" "87" "of" "91" "words." "13" "of" "15" "lyric" "lines" "sit" "clearly" "on" "their" "notes;" "2" "are" "uncertain" "and" "printed" "in" "grey" "italics." "Bible" "text:" "Open" "Source" "English" "(OSEN)," "CC" "BY" "4.0," "from" "SBLGNT" "and" "tanach.us." }
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
  \clef treble \key c \minor \tempo 4 = 75
  \time 4/4 \sectionLabel "Intro" R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | r2 c''4 es''8 es''8 | \sectionLabel "Verse 1" f''4 g''8 g''16 r16 g''8 f''16 r16 es''8 d''8 | c''8 c''8 c''4 r4 bes''4 ~ | bes''8 c'''2 bes''8 g''16 r16 g''8 ~ | g''4. r2 f''8 | g''8 as''4 g''16 r16 g''8 f''8 es''4 | d''4 r4. bes'8 c''4 | es''4. d''8 d''8 c''8 bes'4 | c''2. r4 | \sectionLabel "Chorus" r2 c''4 es''4 | f''2 f''4 es''8 d''8 | c''4 r4 c''4 es''4 | f''4 f''4 f''8. g''16 f''16 es''16 d''8 | c''4 r4 c''4 es''4 | f''4 f''4 f''8. g''16 f''16 es''16 d''8 | c''2 r2 | R1*1 | \sectionLabel "Verse 2" r2. r8 bes'8 | c''4 es''4 f''8 g''8 f''16 es''16 d''8 | c''2 r4 bes''4 | c'''2 bes''4 g''16 r16 g''8 ~ | g''4. r2 f''8 | g''8 as''4 g''8 f''8. es''16 es''8 d''8 ~ | d''8 r4 bes'8 bes'8 c''4 es''8 ~ | es''4. r8 d''8 c''16 bes'16 bes'8 c''8 ~ | \sectionLabel "Chorus" c''4. r8 c''4 es''4 | f''2 f''4 es''8 d''8 | c''4 r4 c''4 es''4 | f''4 f''4 f''8. g''16 f''16 es''16 d''8 | c''4 r4 c''4 es''4 | f''4 f''4 f''8. g''16 f''16 es''16 d''8 | c''2 r2 | \sectionLabel "Outro" r2 c''8 es''8 f''4 ~ | f''2 r8 es''8 d''4 | \time 9/8 d''4 bes'4 c''16 r16 c''2 ~ | \time 4/4 \sectionLabel "Outro" c''2 r2 | R1*1 | R1*1 | R1*1 |
  \bar "|."
}
harmony = \chordmode { s1*3/4 c1*29/4:m c1*8:m c1:m bes1 c1:m bes1 c1:m bes1 c1:m bes1 c1*8:m c1:m bes1 c1:m bes1 c1:m bes1 c1:m c1*25/8:m c1*4:m }
words = \lyricmode { \skip 1 \skip 1 \skip 1 \skip 1 \skip 1 "Out" "of" "the" "depths" "I" "cry" "to" "you," "O" "Lord" "Lord," "hear" "my" \skip 1 "voice" _ "Let" "your" "ears" "be" "at" -- "ten" -- "tive" "To" "my" "cry" "for" "mer" -- "cy" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "My" _ \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "soul" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "waits" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "for" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "the" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "Lord" "More" _ "than" "watch" -- "men" "for" "the" "morn" -- "ing" _ "More" _ "than" "watch" -- "men" "for" "the" "morn" -- "ing" _ "If" "you," "Lord," "kept" "a" "re" -- "cord" "of" "sins" "Lord," "who" "could" "stand" \skip 1 "But" "with" "you" "there" "is" "for" -- "give" -- "ness" "And" "in" "your" "word" "I" "hold" _ _ _ "My" "soul" "waits" "for" "the" "Lord" _ "More" "than" "watch" -- "men" "for" "the" "morn" -- "ing" _ _ "More" "than" "watch" -- "men" "for" "the" "morn" -- "ing" _ _ \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "With" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "the" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "Lord" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "there" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "is" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "stead" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "fast" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "love" \skip 1 }
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
