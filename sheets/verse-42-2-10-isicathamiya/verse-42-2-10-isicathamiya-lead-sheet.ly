\version "2.24.0"
\header {
  title = "Good News of Great Joy"
  subtitle = "Luke 2:10–11"
  tagline = ##f
  copyright = \markup \small \wordwrap { "Melody" "and" "chords" "from" "the" "score" "YuE2" "generated" "the" "song" "from" "(score.abc)." "Lyrics" "placed" "syllable" "by" "syllable" "against" "the" "recording" "with" "Whisper," "which" "heard" "94" "of" "94" "words." "16" "of" "17" "lyric" "lines" "sit" "clearly" "on" "their" "notes;" "1" "are" "uncertain" "and" "printed" "in" "grey" "italics." "Bible" "text:" "Open" "Source" "English" "(OSEN)," "CC" "BY" "4.0," "from" "SBLGNT" "and" "tanach.us." }
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
  \clef treble \key bes \major \tempo 4 = 80
  \time 4/4 \sectionLabel "Intro" R1*1 | bes'8 c''8 d''4 c''8 d''8 es''4 | d''8 es''8 f''4 r2 | R1*1 | R1*1 | \sectionLabel "Verse 1" bes'8 c''8 d''8 d''8 c''4 a'8 bes'8 ~ | bes'4. r2 r8 | g'8 a'8 bes'8 bes'8 ~ bes'8 a'8 g'8 f'8 ~ | f'4 r2 r8. bes'16 | bes'8 c''8 d''8 d''8 c''4 f''8 d''8 ~ | d''16 c''16 bes'4. r4 bes'8 a'8 | g'4 bes'4 bes'4 a'8 c''8 ~ | c''8 bes'4. r2 | \sectionLabel "Chorus" bes''4 bes''4 a''4 f''8 g''8 ~ | g''4. r4 g''8 g''8 a''8 | bes''4 bes''4 a''4 f''4 | g''2 r8 g''8 g''8. f''16 | f''4 d''2 r4 | r4. d''8 d''8. c''8. bes'8 | bes'2 ~ bes'4 r4 | R1*1 | \sectionLabel "Verse 2" bes'8 c''8 d''8 d''8 c''4 a'8 bes'8 ~ | bes'4. r2 r8 | r4 g'8 bes'8 bes'16 a'8. g'8 g'8 ~ | g'8 f'4. r4. r16 bes'16 | bes'8 c''8 d''8 d''8 c''4 f''8 d''8 ~ | d''16 c''16 bes'4 r4. bes'8 a'8 | g'4 bes'4 bes'4 a'8 c''8 ~ | c''8 bes'2 r4. | R1*1 | R1*1 | \sectionLabel "Chorus" bes''4 bes''4 a''4 f''8 g''8 ~ | g''4. r4 g''8 g''8 a''8 | bes''4 bes''4 a''4 f''4 | g''2 r8 g''8 g''8. f''16 | f''4 d''2 r4 | r4. d''8 d''8. c''8. bes'8 | bes'2. r4 | \sectionLabel "Outro" g''4 g''8 g''8 a''4 a''8 a''8 | bes''4 g''2. ~ | g''2 ~ g''4 r4 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 |
  \bar "|."
}
harmony = \chordmode { s1*7/8 bes1*17/8 g1*1/2:m f1*1/2 es1 bes1*1/2 f1*1/2 g1:m es1*1/2 f1*1/2 bes1*3/2 f1*1/2 g1:m es1*1/2 f1*1/2 bes1 g1*1/2:m f1*1/2 es1 g1*1/2:m f1*1/2 es1 bes1 f1 bes1*1/2 bes1*1/2:sus4 bes1 bes1*1/2 f1*1/2 g1:m es1*1/2 f1*1/2 bes1*3/2 f1*1/2 g1:m es1*1/2 f1*1/2 bes1 g1*1/2:m f1*1/2 es1 g1*1/2:m f1*1/2 es1 g1*1/2:m f1*1/2 es1 bes1 f1 bes1 es1*1/2 f1*1/2 g1:m es1*1/2 f1*1/2 g1:m es1*1/2 f1*1/2 g1:m es1*1/2 f1*1/2 bes1*2 }
words = \lyricmode { \skip 1 \skip 1 \skip 1 \skip 1 \skip 1 \skip 1 \skip 1 \skip 1 \skip 1 \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "Shep" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "herds" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "in" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "the" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "fields" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "at" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "night" "Keep" -- "ing" "watch" "o" -- "ver" "their" "flock" "The" _ _ "an" -- "gel" "of" "the" "Lord" "ap" -- "peared" "And" "the" "glo" -- "ry" "shone" "a" -- "round" "them" "Do" "not" "be" "af" -- "raid" "I" "bring" "you" "good" "news" "of" "great" "joy" "For" "all" "the" "peo" -- "ple" "Do" "not" "be" "af" -- "raid" "Un" -- "to" "you" "is" "born" "this" "day" "In" "the" "c" -- "ity" "of" "Da" -- "vid" "A" _ _ "Sav" -- "ior" "who" "is" "Christ" "the" "Lord" "You" "will" "find" "him" "in" "a" "man" -- "ger" "Do" "not" "be" "af" -- "raid" "I" "bring" "you" "good" "news" "of" "great" "joy" "For" "all" "the" "peo" -- "ple" "Do" "not" "be" "af" -- "raid" "Glo" -- "ry" "to" "God" "in" "the" "high" -- "est" }
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
