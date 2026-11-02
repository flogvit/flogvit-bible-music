\version "2.24.0"
\header {
  title = "They Shall Mount Up"
  subtitle = "Isaiah 40:31"
  tagline = ##f
  copyright = \markup \small \wordwrap { "Melody" "and" "chords" "from" "the" "score" "YuE2" "generated" "the" "song" "from" "(score.abc)." "Lyrics" "placed" "syllable" "by" "syllable" "against" "the" "recording" "with" "Whisper," "which" "heard" "133" "of" "135" "words." "16" "of" "20" "lyric" "lines" "sit" "clearly" "on" "their" "notes;" "4" "are" "uncertain" "and" "printed" "in" "grey" "italics." "Bible" "text:" "Open" "Source" "English" "(OSEN)," "CC" "BY" "4.0," "from" "SBLGNT" "and" "tanach.us." }
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
  \clef treble \key es \major \tempo 4 = 84
  \time 4/4 R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | \sectionLabel "Verse 1" r2 es'8 f'8 g'8 g'8 ~ | g'8 r4. es'8 f'8 g'8 g'8 ~ | g'8 r2 r16 bes16 g'8 bes'8 | c''4 c''8 bes'4 r8 es'16 f'16 f'8 ~ | f'8 r4. es'8 f'8 g'8 g'8 ~ | g'8 r4 r16 bes16 es'8 f'8 g'8 g'8 ~ | g'16 f'16 es'4 r4 r16 bes16 g'8 bes'8 | c''4 c''8 bes'4 r8 g'8 g'8 ~ | \sectionLabel "Verse 2" g'16 f'16 f'4 r4. r16 bes'16 c''8 | es''8. es''8. es''4 r8 c''8 bes'8 ~ | bes'8 r2 r16 bes'16 c''8 d''16 es''16 ~ | es''8. es''8 es''8. es''8. c''8 bes'8. | g'8. f'8. es'8 r8. bes'16 c''8 es''16 f''16 ~ | f''8. r16 g''8 f''4 es''8 c''8 c''8 | c''16 bes'16 bes'4 r4. c''8 es''8 | f''4 f''4 f''8 es''8 c''8 g''8 ~ | g''8 f''2 r4. | \sectionLabel "Chorus" r8. bes'16 es''8 g''8 g''8 f''8 es''8 es''8 ~ | es''4 r4 g''8 g''16 g''8 f''8. | f''4 r4. c''8 es''8 f''8 ~ | f''8 g''8 g''8 f''4. g''8 f''8 ~ | f''16 es''16 es''4 r4 c''8 es''8 es''8 ~ | es''16 c''16 bes'16 r4. r16 bes'16 g''8 g''8 g''16 ~ | g''16 f''16 f''4 r4 c''8 es''8 as''8 ~ | as''4. g''4. f''8 es''8 ~ | \sectionLabel "Bridge" es''4 r4 as''8. as''8. g''16 g''16 ~ | g''8. r4 r16 g''8. g''8. f''16 f''16 ~ | f''8. r4 r16 f''4 g''8 f''8 ~ | f''8 es''4 r8 f''4 g''8 f''8 ~ | f''8 es''2 r4. | \sectionLabel "Chorus" r8. bes'16 g''8 g''8 g''8 f''8 es''8 es''8 ~ | es''16 c''16 bes'16 r4 r16 g''8 g''16 g''8 f''8. | f''4 r4. c''8 es''8 f''8 ~ | f''8 g''8 g''8 f''4. g''8 f''8 ~ | f''8 es''4 r4 c''8 es''8 es''8 ~ | es''16 c''16 bes'16 r4. r16 bes'16 g''8 g''8 g''16 ~ | g''16 f''16 f''4 r4 c''8 es''8 as''8 ~ | as''4. g''4. f''8 es''8 ~ | es''4. r2 r8 | \sectionLabel "Outro" R1*1 | R1*1 |
  \bar "|."
}
harmony = \chordmode { s1*7/8 es1*33/8 es1*2 es1/g as1 bes1:sus4 es1 es1/g as1 bes1:sus4 c1:m g1:m7 as1 es1 f1:m7 c1:m7/g as1 bes1:sus4 bes1:sus4 es1 bes1 c1:m7 as1 es1 bes1 des1 as1 es1 bes1 c1:m7 as1 as1 es1 bes1 c1:m7 as1 es1 bes1 des1 as1 es1*2 }
words = \lyricmode { "Have" "you" "not" "known," "have" "you" "not" "heard" "The" _ "ev" -- "er" -- "last" -- "ing" "God," "the" "Lord" "He" "does" "not" "faint," \skip 1 "he" "does" "not" "grow" "wea" -- "ry" "His" "un" -- "der" -- "stand" -- "ing" "is" "un" -- "sear" -- "chab" -- "le" "He" "gives" "pow" -- "er" "to" "the" "faint" "And" _ _ "to" "the" "one" "with" "no" "might" "he" "in" -- "creas" -- "es" "strength" "E" -- "ven" "the" "young" "shall" "faint" "and" "be" "wea" -- "ry" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "And" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "the" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "young" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "men" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "shall" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "fall" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "ex" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "haust" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "ed" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "But" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "they" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "who" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "wait" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "for" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "the" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "Lord" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "Shall" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "re" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "new" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "their" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "strength" "They" _ "shall" "mount" "up" "with" "wings" "like" "ea" -- "gles" "They" _ _ "shall" "run" \skip 1 "and" "not" "be" "wea" -- "ry" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "They" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "shall" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "walk" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "and" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "not" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "faint" "Wait" "on" "the" "Lord," "wait" "on" "the" "Lord" "Wings" "like" "ea" -- "gles," "wings" "like" "ea" -- "gles" "But" _ _ "they" "who" "wait" "for" "the" "Lord" "Shall" "re" -- "new" "their" "strength" "They" _ "shall" "mount" "up" "with" "wings" "like" "ea" -- "gles" _ "They" "shall" "run" \skip 1 "and" "not" "be" "wea" -- "ry" "They" "shall" "walk" "and" "not" "faint" }
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
