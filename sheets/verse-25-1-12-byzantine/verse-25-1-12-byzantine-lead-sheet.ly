\version "2.24.0"
\header {
  title = "Is There Any Sorrow Like My Sorrow"
  subtitle = "Lamentations 1:12"
  tagline = ##f
  copyright = \markup \small \wordwrap { "Melody" "and" "chords" "from" "the" "score" "YuE2" "generated" "the" "song" "from" "(score.abc)." "Lyrics" "placed" "syllable" "by" "syllable" "against" "the" "recording" "with" "Whisper," "which" "heard" "97" "of" "97" "words." "13" "of" "16" "lyric" "lines" "sit" "clearly" "on" "their" "notes;" "3" "are" "uncertain" "and" "printed" "in" "grey" "italics." "Bible" "text:" "Open" "Source" "English" "(OSEN)," "CC" "BY" "4.0," "from" "SBLGNT" "and" "tanach.us." }
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
  \clef treble \key es \major \tempo 4 = 74
  \time 4/4 \sectionLabel "Verse 1" r4 es'8 f'8 g'8 bes'4 g'8 | f'2 r4. es'8 | c''2 c''8 bes'8 bes'4 | g'2 r4 es'8 g'8 | f'2 r4 es'8 d'8 | c'4 d'4 es'8 f'8 g'8 c''8 | bes'4 g'4 r4 es'8 g'8 | as'2 g'4 es'4 | \sectionLabel "Verse 2" f'2 r4 es'8 d'8 | c'2 es'2 | g'2 r4. bes8 | c'4 d'4 es'4 bes'4 | g'2 r4 es'8 d'8 | c'4 d'4 es'4 f'4 | g'4 bes'4 es'4 r8 es'8 | as'8 g'8 f'8 es'8 es'4 c'4 | f'2 r2 | \sectionLabel "Chorus" g''4 bes''4 f''2 | es''4 g''4 d''4. r8 | c''8 d''8 es''8 f''8 g''8 f''8 es''8 g''8 | \sectionLabel "Verse 3" f''2 es''4. bes8 | g'8. g'8. bes'8 bes'8 g'16 f'8. es'16 d'16 | c'16 d'16 es'8 es'8. bes'16 g'4 r4 | c'8 d'8 es'8 f'8 g'8 f'16 es'8. es'16 es'16 | as'8. g'8. es'8 es'4 c'4 | f'2 r2 | \sectionLabel "Chorus" g''4 bes''4 f''2 | es''4 g''4 d''4. r8 | c''8 d''8 es''8 f''8 g''8 f''8 es''8 g''8 | f''2 es''2 | \sectionLabel "Outro" R1*1 | R1*1 | \time 9/8 R1*9/8 | \time 4/4 R1*1 | R1*1 |
  \bar "|."
}
harmony = \chordmode { s1*1 bes1 as1 es1 bes1 c1:m g1:m as1 bes1 as1 es1 as1 es1 as1 c1:m as1 bes1 es1*1/2 bes1*1/2 c1*1/2:m g1*1/2:m as1*1/2 es1*1/2 bes1 es1*1/2 bes1*1/2 c1*1/2:m g1*1/2:m as1*1/2 es1*1/2 as1 bes1 es1*1/2 bes1*1/2 c1*1/2:m g1*1/2:m as1*1/2 es1*1/2 bes1 es1*1/2 bes1*1/2 c1*1/2:m g1*1/2:m as1*1/2 bes1*5/8 es1*2 }
words = \lyricmode { "Is" "it" "noth" -- "ing" "to" "you," \skip 1 "all" "you" "who" "pass" "by" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "Look" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "and" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "see" "Is" "there" "a" -- "ny" "sor" -- "row" "like" "my" "sor" -- "row" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "That" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "was" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "brought" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "up" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "on" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "me" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "For" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "these" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "things" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "I" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "weep" "My" "eyes" "flow" "down" "with" "tears" "For" "the" "com" -- "for" -- "ter" "is" "far" "from" "me" "The" "one" "who" "should" "re" -- "store" "my" "soul" "Look" "and" "see," "look" "and" "see" "Is" "there" "a" -- "ny" "sor" -- "row" "like" "my" "sor" -- "row" "My" "chil" -- "dren" "are" "des" -- "o" -- "late" "For" "the" "en" -- "e" -- "my" "has" "pre" -- "vailed" "Zion" "stretch" -- "es" "out" "her" "hands" _ "And" "there" "is" "none" "to" "com" -- "fort" "her" "Look" "and" "see," "look" "and" "see" "Is" "there" "a" -- "ny" "sor" -- "row" "like" "my" "sor" -- "row" }
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
