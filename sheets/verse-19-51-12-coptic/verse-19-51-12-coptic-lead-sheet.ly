\version "2.24.0"
\header {
  title = "Create in Me a Clean Heart"
  subtitle = "Psalms 51:12"
  tagline = ##f
  copyright = \markup \small \wordwrap { "Melody" "and" "chords" "from" "the" "score" "YuE2" "generated" "the" "song" "from" "(score.abc)." "Lyrics" "placed" "syllable" "by" "syllable" "against" "the" "recording" "with" "Whisper," "which" "heard" "80" "of" "80" "words." "9" "of" "12" "lyric" "lines" "sit" "clearly" "on" "their" "notes;" "3" "are" "uncertain" "and" "printed" "in" "grey" "italics." "Bible" "text:" "Open" "Source" "English" "(OSEN)," "CC" "BY" "4.0," "from" "SBLGNT" "and" "tanach.us." }
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
  \clef treble \key g \minor \tempo 4 = 81
  \time 4/4 R1*1 | R1*1 | R1*1 | R1*1 | \sectionLabel "Verse 1" r2. d'4 | d'4. g'4. bes'4 | a'4. r4. f'8 g'8 | g'2. r4 | r4. d'8 g'4 bes'4 | d''2 r8 es''8 d''8 c''8 | c''2 a'8 bes'16 a'16 g'4 | g'2 r2 | r4. d'8 g'4 bes'4 | d''2 r8 es''8 d''8 c''8 | c''4. r4. a'4 | a'8 bes'16 a'16 g'2 r4 | r2. bes'8 a'8 | a'2 r8 bes'8 a'8 g'8 | g'2 f'2 | g'2. r4 | \sectionLabel "Chorus" r4 d''4 d''4 f''4 | g''2. g''4 | f''2 c''4 es''4 | d''2 r2 | r2 d''4 f''4 | g''2 g''4 g''4 | f''8 c''4. r4 bes'8 c''8 ~ | c''8 d''2. ~ d''8 ~ | \sectionLabel "Verse 2" d''8 r2 r8 d'8 d'8 | d'4 g'2 r4 | a'4. bes'16 a'16 g'4 f'4 | f'8 g'2 r4. | r4 g'8 a'8 bes'4 c''4 | d''2 r8 es''8 d''8 c''8 | c''4. a'4. f'8 g'8 | g'2 r2 | r4. d'8 g'4 bes'4 | d''2 r8 es''8 d''8 c''8 | c''4. a'8 a'4 a'4 | a'8 bes'16 a'16 g'4 r2 | r2 g'4 bes'4 | a'4. a'8 bes'4 a'8 g'8 | \sectionLabel "Chorus" g'4. f'16 r16 f'2 | f'8 g'2 r4. | r4 d''4 d''4 f''4 | g''2. g''4 | f''2 c''4 es''4 | d''2 r2 | r2 d''4 f''4 | g''2 g''4 g''4 | f''8 c''4. r4 bes'8 c''8 ~ | c''8 d''2. ~ d''8 ~ | d''2 ~ d''8 r4. | \sectionLabel "Outro" R1*1 | R1*1 | R1*1 | R1*1 | R1*1 |
  \bar "|."
}
harmony = \chordmode { s1*3/4 g1*5/4:m es1 f1 g1*2:m f1 g1*2:m bes1 f1 g1*2:m bes1 f1 g1*2:m f1 es1*1/2 f1*1/2 g1:m g1:m es1 f1 g1*2:m es1 f1 g1:m g1*2:m f1 g1*2:m bes1 f1 g1*2:m bes1 f1 g1*2:m f1 es1*1/2 f1*1/2 g1*2:m es1 f1 g1*2:m es1 f1 g1*2:m g1:m es1 f1 g1*2:m }
words = \lyricmode { "Have" "mer" -- "cy" "on" "me," \skip 1 "O" "God" "Ac" -- "cord" -- "ing" "to" \skip 1 "your" "stead" -- "fast" "love" _ _ _ _ "Ac" -- "cord" -- "ing" "to" \skip 1 "your" _ "great" \skip 1 "com" -- "pas" -- "sion" _ "Blot" _ "out" "my" "trans" -- "gres" -- "sions" _ _ "Cre" -- "ate" "in" "me" "a" "clean" "heart," "O" "God" "And" "re" -- "new" "a" "right" "spir" -- "it" "with" -- "in" "me" "Do" "not" "cast" "me" \skip 1 "from" "your" "pre" -- "sence" _ _ \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "Do" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "not" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "take" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "your" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "Ho" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "ly" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "Spir" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "it" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "from" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "me" _ _ _ \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "Re" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "store" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "to" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "me" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "the" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "joy" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "of" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "your" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "sal" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "va" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "tion" _ _ \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "And" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "up" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "hold" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "me" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "with" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "a" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "will" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "ing" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "spir" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "it" _ "Cre" -- "ate" "in" "me" "a" "clean" "heart," "O" "God" "And" "re" -- "new" "a" "right" "spir" -- "it" "with" -- "in" "me" \skip 1 \skip 1 \skip 1 }
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
