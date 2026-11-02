\version "2.24.0"
\header {
  title = "Our Mouths Were Filled With Laughter"
  subtitle = "Psalm 126"
  tagline = ##f
  copyright = \markup \small \wordwrap { "Melody" "and" "chords" "from" "the" "score" "YuE2" "generated" "the" "song" "from" "(score.abc)." "Lyrics" "placed" "syllable" "by" "syllable" "against" "the" "recording" "with" "Whisper," "which" "heard" "101" "of" "110" "words." "14" "of" "16" "lyric" "lines" "sit" "clearly" "on" "their" "notes;" "2" "are" "uncertain" "and" "printed" "in" "grey" "italics." "Bible" "text:" "Open" "Source" "English" "(OSEN)," "CC" "BY" "4.0," "from" "SBLGNT" "and" "tanach.us." }
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
  \clef treble \key d \minor \tempo 4 = 130
  \time 4/4 R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | \sectionLabel "Verse 1" r2. d'8 e'8 | f'4 f'4 f'4 e'4 | d'2 a4 d'4 | e'4. c'4. r4 | r2 f'4 g'4 | a'2 f'4 e'8 d'8 | d'2 r2 | R1*1 | r2. d'8 e'8 | f'4 f'4 f'4 e'4 | d'2 a4 d'8 f'8 | e'4. c'8 c'4 d'4 | \sectionLabel "Chorus" e'4 r8 e'8 f'4 g'4 | a'2 f'4 e'4 | d'2 d'4 r4 | r4. a'8 d''4 e''4 | f''2 f''8 g''8 e''8 f''8 | d''2 r4 d''8 e''8 | f''2 f''8 g''8 e''8 f''8 | d''4 r8 d''8 g''4 a''4 | bes''2 bes''8 c'''8 a''8 bes''8 | g''2 r4 f''8 g''8 | a''4. bes''8 g''4. f''16 e''16 | d''1 | R1*1 | \sectionLabel "Verse 2" f''4 f''4 f''8 g''8 e''8 f''8 | d''2 r4 d''8 e''8 | f''4 f''4 f''8 g''8 e''8 f''8 | d''2 r2 | bes''4 bes''4 bes''8 c'''8 a''8 bes''8 | g''4 g''4 g''8 e''8 f''8 g''8 | a''4. bes''8 g''4. f''16 e''16 | d''1 | \sectionLabel "Chorus" r4. a'8 d''4 e''4 | f''2 f''8 g''8 e''8 f''8 | d''2 r4 d''8 e''8 | f''2 f''8 g''8 e''8 f''8 | d''4 r8 d''8 g''4 a''4 | bes''2 bes''8 c'''8 a''8 bes''8 | g''2 r4 f''8 g''8 | a''4. bes''8 g''4. f''16 e''16 | d''1 | R1*1 | \sectionLabel "Interlude" R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 |
  \bar "|."
}
harmony = \chordmode { s1*3/4 d1*17/4:m g1:m c1 bes1*1/2 a1*1/2 d1*5:m g1:m c1 bes1*1/2 a1*1/2 d1*3:m c1*2 d1*6:m c1 c1 d1*7:m g1:m c1 bes1*1/2 a1*1/2 d1*2:m d1*4:m g1:m c1 bes1*1/2 a1*1/2 d1:m d1*5:m g1:m c1 bes1*1/2 a1*1/2 d1*2:m d1*4:m g1:m c1 bes1*1/2 a1*1/2 d1*5:m g1:m c1 bes1*1/2 a1*1/2 d1*5:m g1:m c1 bes1*1/2 a1*1/2 d1*3:m }
words = \lyricmode { "When" _ "the" "Lord" "re" -- "stored" "the" "for" -- "tunes" "of" "Zion" "We" "were" "like" "those" "who" "dream" _ "Then" "our" "mouths" "were" "filled" "with" "laugh" -- "ter" "And" "our" "tongues" "with" "shouts" "of" "joy" "The" "Lord" "has" "done" "great" "things" "for" "us" "And" _ "we" "are" "glad," "we" "are" "glad" _ "The" _ _ "Lord" "has" _ _ "done" \skip 1 "great" "things" "for" "us" _ _ _ _ "And" _ _ "we" "are" "glad" _ _ "Those" "who" "sow" "in" "tears" _ _ "Shall" _ _ "reap" "with" "shouts" "of" "joy" _ \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "He" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "who" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "goes" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "out" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "weep" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "ing," \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "bear" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "ing" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "seed" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "Shall" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "come" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "home" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "with" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "shouts" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "of" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "joy," \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "bring" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "ing" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "his" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "sheaves" "The" "Lord" "has" "done" "great" "things" "for" "us" "And" "we" "are" "glad," "we" "are" "glad" "The" _ "Lord" "has" "done" "great" "things" "for" "us" "And" "we" "are" "glad" _ _ _ _ }
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
