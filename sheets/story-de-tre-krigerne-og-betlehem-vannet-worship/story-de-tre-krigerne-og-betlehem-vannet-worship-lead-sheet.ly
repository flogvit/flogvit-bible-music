\version "2.24.0"
\header {
  title = "Blood of the Mighty Men"
  subtitle = "2 Samuel 23:13–17"
  tagline = ##f
  copyright = \markup \small \wordwrap { "Melody" "and" "chords" "from" "the" "score" "YuE2" "generated" "the" "song" "from" "(score.abc)." "Lyrics" "placed" "syllable" "by" "syllable" "against" "the" "recording" "with" "Whisper," "which" "heard" "160" "of" "163" "words." "23" "of" "24" "lyric" "lines" "sit" "clearly" "on" "their" "notes;" "1" "are" "uncertain" "and" "printed" "in" "grey" "italics." "Bible" "text:" "Open" "Source" "English" "(OSEN)," "CC" "BY" "4.0," "from" "SBLGNT" "and" "tanach.us." }
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
  \clef treble \key bes \major \tempo 4 = 70
  \time 4/4 R1*1 | R1*1 | R1*1 | R1*1 | \sectionLabel "Verse 1" r2 r8. bes16 d'16 f'8. | f'2 g'8. f'16 d'16 c'16 bes8 | d'4 r2 d'16 f'8. | g'8 g'16 g'8. g'16 g'16 ~ g'16 f'8. d'4 | r2. d'16 f'8. | f'4 r4 g'8. f'16 d'16 c'16 bes8 | d'4 r2 r8 bes8 | bes4 c'8. d'16 c'8 bes8 bes8 bes8 | \sectionLabel "Chorus" r2. d''8 f''8 | g''4 g''8. f''16 g''4 f''8 d''8 ~ | d''4 r2 d''16 f''8. | d''4 d''8. c''16 d''4 bes'8 c''8 ~ | c''4 r2 d''16 f''8. | g''4 g''8. f''16 g''4 f''8 d''8 ~ | d''4 r2 c''16 bes'8. | g'4 c''8. d''16 c''4. bes'8 ~ | \sectionLabel "Verse 2" bes'8 r2. f'8 | f'4 f'8. f'16 g'16 f'16 d'4 d'8 | r2. d'16 f'8. | g'8 g'4. g'8 f'8 f'8 d'8 ~ | d'8 r2 r16 bes16 d'8 f'8 | f'4 r4 g'8. f'16 d'16 c'16 bes8 | d'4 r2 c'16 bes8. | bes4 c'16 d'8. c'4 bes8 bes8 ~ | \sectionLabel "Chorus" bes8 r2 r8 d''8 f''8 | g''4 g''8. f''16 g''4 f''8 d''8 ~ | d''8 r2 r8 d''16 f''8. | d''4 d''8. c''16 d''4 c''8 c''8 ~ | c''8 r2 r8 d''16 f''8. | g''4 g''8. f''16 g''4 f''8 d''8 ~ | d''8 r2 r8 c''16 bes'8. | g'4 c''8. d''16 c''4. bes'8 ~ | bes'8 r2. r8 | \sectionLabel "Bridge" bes'4 bes'8 bes'8 c''4 c''8. bes'16 | d''4 r2 r8 bes'8 | g''4 f''8 f''8 ~ f''8 c''8 d''8 d''8 ~ | d''16 c''16 bes'16 r2 r8. bes'8 | bes'8 bes'16 bes'8. c''8 c''4. bes'16 d''16 ~ | d''8. r2 r8. bes'8 | g'4 d''8 c''8 c''4. bes'16 bes'16 ~ | \sectionLabel "Outro" bes'8. r2 r16 d''8 f''8 | g''4 g''8 g''4 f''4 d''16 d''16 ~ | d''8. r2 r8. f''8 | d''4 d''8. c''16 d''4 c''8 c''8 ~ | c''8 bes'8 r2 d''16 d''16 f''8 | g''4 g''8. f''16 g''4 f''8 d''8 ~ | d''8 r2. bes'8 | g'4 r8. d''16 c''4. bes'16 bes'16 ~ | bes'8 bes'8 r2. | R1*1 |
  \bar "|."
}
harmony = \chordmode { s1*7/8 bes1*25/8 bes1*3 es1*1/2 f1*1/2 bes1*2 g1:m es1*1/2 f1*1/2 bes1 es1 bes1 g1:m f1 es1 g1:m es1*1/2 f1*1/2 bes1*3/2 es1*1/2 bes1 es1*1/2 f1*1/2 bes1*3/2 es1*1/2 g1:m es1*1/2 f1*1/2 bes1 es1 bes1 g1:m f1 es1 g1:m es1*1/2 f1*1/2 bes1 es1*1/2 f1*1/2 g1:m es1*1/2 f1*1/2 g1:m es1*1/2 f1*1/2 g1:m es1*1/2 f1*1/2 bes1 es1 bes1 g1:m f1 es1 g1:m es1*1/2 f1*1/2 bes1*2 }
words = \lyricmode { "The" _ "Phi" -- "lis" -- "tines" "held" "the" "gate" "strong" _ "Da" -- "vid" _ "wait" -- "ed" "in" "the" "cave" "deep" "Three" "chief" "men" \skip 1 "heard" "the" "long" -- "ing" "song" "And" "rose" "while" "the" "har" -- "vest" "was" "ripe" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "Pour" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "it" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "out" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "to" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "the" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "Lord" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "a" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "bove" "It" "is" "blood" "of" "the" "men" "who" "died" "Do" "not" "drink" "from" "this" "cup" "of" "love" "For" "their" "lives" "are" "the" "price" "paid" "They" "broke" "through" "the" "en" -- "e" -- "my" "camp" "And" _ "drew" "wa" -- "ter" "from" "the" "well" "The" _ "risk" "was" "great" "and" "the" "dan" -- "ger" "damp" "But" "they" "car" -- "ried" "it" "back" "to" "town" "Pour" "it" "out" "to" "the" "Lord" "a" -- "bove" "It" "is" "blood" "of" "the" "men" "who" "died" "Do" "not" "drink" "from" "this" "cup" "of" "love" "For" "their" "lives" "are" "the" "price" "paid" "Far" "be" "it" "from" "me" "to" "take" "This" "sac" -- "ri" -- "fice" "of" "their" "blood" _ _ "The" "mig" -- "hty" "men" "went" "at" "the" "risk" "And" _ "gave" "their" "lives" "to" "God" "Such" "were" "the" "ex" -- "ploits" "of" "the" "three" "Re" -- "fus" -- "ing" "to" "drink" "the" "wa" -- "ter" "Hon" -- "or" "the" "risk" "of" "the" "men" "for" "me" "And" "keep" "the" "ho" -- "ly" "or" -- "der" }
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
