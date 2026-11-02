\version "2.24.0"
\header {
  title = "Like a Weaned Child"
  subtitle = "Psalm 131"
  tagline = ##f
  copyright = \markup \small \wordwrap { "Melody" "and" "chords" "from" "the" "score" "YuE2" "generated" "the" "song" "from" "(score.abc)." "Lyrics" "placed" "syllable" "by" "syllable" "against" "the" "recording" "with" "Whisper," "which" "heard" "86" "of" "87" "words." "12" "of" "14" "lyric" "lines" "sit" "clearly" "on" "their" "notes;" "2" "are" "uncertain" "and" "printed" "in" "grey" "italics." "Bible" "text:" "Open" "Source" "English" "(OSEN)," "CC" "BY" "4.0," "from" "SBLGNT" "and" "tanach.us." }
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
  \clef treble \key es \major \tempo 4 = 75
  \time 4/4 R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | \sectionLabel "Verse 1" r2. r8 es''8 | es''4 es''8 es''4 bes'8 g''8 f''8 ~ | f''4 bes'8 bes'8 r4. d''8 | es''4. d''4 c''4 c''8 ~ | c''8 bes'4 bes'4 r4 es''8 | es''8 es''8 es''8 es''16 es''8. g''4 f''8 ~ | f''8 d''4 c''16 bes'8. r4 d''8 | es''4 r8 es''4 g''4 g''8 | f''8 f''16 f''8. f''4 f''4. | \sectionLabel "Chorus" r2 bes''8. as''8. g''8 ~ | g''4 es''8 bes''4 as''16 g''8. f''8 | f''4 r4. es''8 f''8 g''8 ~ | g''8 es''4. d''8 es''4 d''8 ~ | d''8 c''4 r4 es''8 f''8 g''8 ~ | g''4. es''2 d''8 ~ | d''4 r4. bes'8 es''4 ~ | es''8 es''2 r4. | r4. c''8 c''8 bes'8 bes'4 | R1*1 | R1*1 | R1*1 | \sectionLabel "Verse 2" r2. es''4 | es''4 es''8 es''4 r4. | f''4 f''8 g''16 f''8. r4 d''8 | d''8. es''8. es''4 r8 es''8 g''8 | g''8 f''4 f''2 ~ f''8 ~ | \sectionLabel "Chorus" f''4. r8 bes''8. as''8. g''8 ~ | g''4 es''8 bes''4 as''16 g''8. f''8 ~ | f''4. r4 es''8 f''8 g''8 ~ | g''8 es''4. d''8 es''4 d''8 ~ | d''8 c''4 r4 es''8 f''8 g''8 ~ | g''4. es''2 d''8 ~ | d''4 r4. bes'8 es''4 ~ | es''8 es''2. r8 | r4. c''8 c''8 bes'16 r16 bes'4 | \sectionLabel "Outro" R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 |
  \bar "|."
}
harmony = \chordmode { s1*3/4 es1*5/4 g1:m7 as1 bes1 es1 g1:m7 as1 bes1 es1 g1:m7 as1 bes1 es1 g1:m7 as1 bes1 bes1 es1 bes1 c1:m as1 es1 bes1 as1*2 es1 g1:m7 as1 bes1 es1 g1:m7 as1 bes1 bes1 es1 bes1 c1:m as1 es1 bes1 as1*2 es1 g1:m7 as1 bes1 es1*2 }
words = \lyricmode { "O" "Lord," "my" "heart" "is" "not" "lift" -- "ed" "up" "My" "eyes" "are" "not" "raised" "too" "high" "I" "do" "not" "oc" -- "cu" -- "py" "my" -- "self" "with" "things" _ "Too" "great" \skip 1 "and" "too" "mar" -- "ve" -- "lous" "for" "me" "I" "have" "calmed" "and" "qui" -- "et" -- "ed" "my" "soul" "Like" "a" "weaned" "child" "with" "its" "moth" -- "er" "Like" "a" "weaned" "child" _ "Is" "my" "soul" \skip 1 "with" -- "in" "me" "O" "Is" -- "rael," "hope" \skip 1 "in" "the" "Lord" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "From" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "this" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "time" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "forth" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "and" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "fo" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "re" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "ver" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "more" "I" "have" "calmed" "and" "qui" -- "et" -- "ed" "my" "soul" "Like" "a" "weaned" "child" "with" "its" "moth" -- "er" "Like" "a" "weaned" "child" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "Is" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "my" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "soul" \skip 1 \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "with" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "in" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "me" }
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
