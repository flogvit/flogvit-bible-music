\version "2.24.0"
\header {
  title = "Out of Egypt"
  subtitle = "Matthew 2:13–15"
  tagline = ##f
  copyright = \markup \small \wordwrap { "Melody" "and" "chords" "from" "the" "score" "YuE2" "generated" "the" "song" "from" "(score.abc)." "Lyrics" "placed" "syllable" "by" "syllable" "against" "the" "recording" "with" "Whisper," "which" "heard" "80" "of" "83" "words." "9" "of" "12" "lyric" "lines" "sit" "clearly" "on" "their" "notes;" "3" "are" "uncertain" "and" "printed" "in" "grey" "italics." "Bible" "text:" "Open" "Source" "English" "(OSEN)," "CC" "BY" "4.0," "from" "SBLGNT" "and" "tanach.us." }
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
  \clef treble \key c \minor \tempo 4 = 70
  \time 2/4 c'8 c'4 g'8 | \sectionLabel "Verse 1" g'4. f'8 | g'4. es'8 | f'4. es'8 | d'8 c'8 bes8 d'8 | c'4 r4 | R1*1/2 | c'4 g'8 g'8 | g'4 f'8 es'8 | f'16 es'16 d'4 r8 | r4. bes8 | c'4 g'8 g'8 | g'16 f'16 es'8 r4 | f'16 es'16 d'4 d'8 | es'16 d'16 c'16 bes16 bes8 d'8 | c'4 r4 | R1*1/2 | \sectionLabel "Chorus" c''8 g''8 g''16 f''16 es''8 | f''4 d''8 bes'8 | c''2 | R1*1/2 | c''8 g''8 g''16 f''16 es''8 | f''4 d''8 bes'8 | c''2 | \sectionLabel "Verse 2" r4. c'8 | c'8 g'8 g'8 g'8 | g'4 f'8 es'8 | f'16 es'16 d'4 d'8 | c'4 r4 | r4. c'8 | c'8 g'8 g'8 g'8 | g'16 f'16 es'4 es'8 | f'16 es'16 d'4 d'8 | c'4 r4 | R1*1/2 | c'8 g'4 g'8 | g'16 f'16 es'4. | f'16 es'16 d'4 d'8 | es'16 d'16 c'8 bes8 d'8 | c'4 r4 | R1*1/2 | \sectionLabel "Chorus" c''8 g''8 g''16 f''16 es''8 | f''4 d''8 bes'8 | c''2 | R1*1/2 | c''8 g''8 g''16 f''16 es''8 | f''4 d''8 bes'8 | c''2 | R1*1/2 | \sectionLabel "Interlude" R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 |
  \bar "|."
}
harmony = \chordmode { c1*1/2:m c1*6:m bes1 c1:m c1*1/2:m bes1*1/2 c1*3/2:m bes1*1/2 c1*1/2:m c1*3/2:m bes1*1/2 c1*2:m bes1*1/2 c1*2:m bes1 c1:m c1*1/2:m bes1*1/2 c1*3/2:m bes1*1/2 c1:m c1*1/2:m bes1*1/2 c1*3/2:m bes1*1/2 c1*3/2:m }
words = \lyricmode { \skip 1 \skip 1 \skip 1 \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "An" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "an" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "gel" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "of" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "the" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "Lord" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "ap" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "peared" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "to" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "Jo" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "seph" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "in" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "a" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "dream" "Rise," "take" "the" "child" "and" "his" \skip 1 "moth" -- "er" "And" "flee" "in" -- "to" "E" -- "gypt" _ _ "Stay" "there" "un" -- "til" "I" "tell" "you" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "Out" _ \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "of" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "E" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "gypt" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "I" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "called" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "my" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "son" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "Out" _ \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "of" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "E" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "gypt" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "I" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "called" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "my" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "son" "He" _ "rose" "and" "took" "the" "child" "and" "his" "moth" -- "er" "by" "night" "And" _ _ "went" "down" "in" -- "to" "E" -- "gypt" _ "And" "there" "they" "stayed" "Blessed" _ _ "be" _ "E" -- "gypt," _ "where" "the" "Lord" "came" _ _ _ _ "Out" _ "of" "E" -- "gypt" "I" "called" "my" "son" "Out" "of" "E" -- "gypt" "I" "called" "my" "son" _ }
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
