\version "2.24.0"
\header {
  title = "Pater Noster"
  subtitle = "Matthew 6:9–13"
  tagline = ##f
  copyright = \markup \small \wordwrap { "Melody" "and" "chords" "from" "the" "score" "YuE2" "generated" "the" "song" "from" "(score.abc)." "Lyrics" "placed" "syllable" "by" "syllable" "against" "the" "recording" "with" "Whisper," "which" "heard" "46" "of" "50" "words." "11" "of" "12" "lyric" "lines" "sit" "clearly" "on" "their" "notes;" "1" "are" "uncertain" "and" "printed" "in" "grey" "italics." "Bible" "text:" "the" "Clementine" "Vulgate" "(public" "domain)." }
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
  \clef treble \key d \minor \tempo 4 = 60
  \time 2/4 \sectionLabel "Intro" R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | \sectionLabel "Verse 1" d'8 a'8 a'8 g'8 | a'4 f'8 e'8 | e'16 f'16 e'16 c'16 d'4 | r4. a'8 | d''8. d''16 d''8 c''8 | a'4 g'4 | a'2 | r4. a'8 | d''8. d''16 d''8 e''8 | f''8. e''16 d''8 c''8 | a'4 r4 | r4 a'16 g'16 f'8 | g'4 g'8 a'8 | g'16 f'16 d'4 r8 | r8 d'8 f'8 g'8 | g'4 g'8 a'8 | g'16 f'16 d'16 c'16 d'4 ~ | d'4 r4 | R1*1/2 | R1*1/2 | R1*1/2 | \sectionLabel "Verse 2" d'8 a'8 a'8 g'8 | a'4 f'8 e'8 | e'16 f'16 e'16 c'16 d'4 | r4. a'8 | d''4 d''8 c''8 | a'4 g'4 | a'2 | R1*1/2 | d''8 d''16 d''8. e''8 | f''8 e''8 d''16 d''16 c''8 | a'4 a'4 | r4 a'16 g'16 f'8 | g'4 r8 a'8 | g'16 f'16 d'4 r8 | r4 f'8 a'8 | g'4 g'8 a'8 | g'16 f'16 d'16 c'16 d'4 ~ | d'2 | R1*1/2 | R1*1/2 | R1*1/2 | \sectionLabel "Verse 3" d''4 d''8 e''8 | f''8 e''8 d''8 c''8 | a'4 g'4 | g'16 f'16 d'4 r8 | d''4 d''16 d''16 e''8 | f''4 e''8 c''8 | e''2 ~ | e''2 ~ | e''2 | R1*1/2 | \sectionLabel "Outro" r4 d'4 ~ | d'8 a'4. ~ | \time 3/8 a'4. ~ | \time 2/4 a'8 r4. | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 |
  \bar "|."
}
harmony = \chordmode { d1*13/2:m d1*2:m bes1*1/2 f1*1/2 d1:m bes1*1/2 f1*1/2 d1:m c1*1/2 bes1 c1*3/4 d1*9/4:m d1*1/2:m f1*1/2 c1*1/2 d1*1/2:m bes1*1/2 f1*1/2 d1:m bes1*1/2 f1*1/2 d1:m c1*1/2 bes1 c1*3/4 d1*9/4:m d1*1/2:m f1*1/2 c1*1/2 d1*1/2:m bes1*1/2 f1*1/2 c1*2 c1*1/4 d1*57/8:m }
words = \lyricmode { "Pa" -- "ter" "nos" -- "ter," "qu" -- "i" "es" "in" "cae" -- "lis" _ _ \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "san" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "cti" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "fi" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "ce" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "tur" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "no" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "men" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "tu" -- \skip 1 \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "um" "Ad" -- "ve" -- "ni" -- "at" "reg" -- "num" "tu" -- "um" "fi" -- _ _ "at" "vo" -- "lun" -- "tas" "tu" -- "a" "si" -- "cut" _ "in" "cae" -- "lo" "et" "in" "ter" -- "ra" _ "Pa" -- "nem" "nos" -- "trum" "su" -- "per" -- "sub" -- "stan" -- "ti" -- "a" -- "lem" _ "da" "no" -- "bis" "ho" -- "di" -- "e" _ "et" "di" -- "mit" -- "te" "no" -- "bis" "de" -- "bi" -- "ta" "nos" -- "tra" "si" -- "cut" "et" "nos" "di" -- "mit" -- "ti" -- "mus" \skip 1 "de" -- "bi" -- "to" -- "ri" -- "bus" "nos" -- "tris" _ _ "Et" "ne" "nos" "in" -- "du" -- "cas" "in" "ten" -- "ta" -- "ti" -- "o" -- "nem" "sed" "li" -- "be" -- "ra" "nos" "a" "ma" -- "lo" "A" -- "men" }
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
