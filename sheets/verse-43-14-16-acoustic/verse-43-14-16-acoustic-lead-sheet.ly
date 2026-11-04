\version "2.24.0"
\header {
  title = "Another Advocate"
  subtitle = "John 14:16–17"
  tagline = ##f
  copyright = \markup \small \wordwrap { "Melody" "and" "chords" "from" "the" "score" "YuE2" "generated" "the" "song" "from" "(score.abc)." "Lyrics" "placed" "syllable" "by" "syllable" "against" "the" "recording" "with" "Whisper," "which" "heard" "170" "of" "175" "words." "29" "of" "31" "lyric" "lines" "sit" "clearly" "on" "their" "notes;" "2" "are" "uncertain" "and" "printed" "in" "grey" "italics." "Bible" "text:" "Open" "Source" "English" "(OSEN)," "CC" "BY" "4.0," "from" "SBLGNT" "and" "tanach.us." }
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
  \time 4/4 \sectionLabel "Intro" R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | \sectionLabel "Verse 1" d''8 es''16 f''8. bes''16 a''16 a''4 f''8 d''8 ~ | d''8 r2. c''16 d''16 | es''8. es''8. d''16 d''16 ~ d''8. r16 bes'16 c''16 c''8 ~ | c''8 r4. r4. bes'16 c''16 | d''8. f''8. bes''8 a''4 f''8 d''8 ~ | d''8 r4 c''16 d''16 es''8 d''16 c''8. bes'16 bes'16 ~ | bes'8 r2. r8 | \sectionLabel "Pre-Chorus" r4. r16 bes'16 es''8 d''16 es''8. f''8 ~ | f''8 bes'4 c''8 ~ c''8 r4. | r4. c''16 d''16 es''8 d''16 c''8. bes'16 d''16 ~ | d''8. r2 r8. bes'8 | g''8 g''8 g''8 a''8 a''4 bes''8 bes''8 ~ | bes''8 r4 bes'16 bes'16 es''8 d''8 c''16 bes'16 bes'8 ~ | bes'8 r2. r8 | \sectionLabel "Chorus" r2 r8. f''16 bes''16 a''8. | bes''8 a''16 g''8. f''8 c''4 r8. bes'16 | d''16 es''16 d''16 c''8. bes'16 bes'16 ~ bes'8 r8 bes''16 a''16 g''16 f''16 | f''2 r8 bes''8 a''8 bes''8 ~ | bes''2 ~ bes''8 r4 r16 bes'16 | es''4 d''4 c''4 bes'4 | bes'2 r2 | R1*1 | \sectionLabel "Verse 2" d''8 es''16 f''8. bes''8 a''8. f''8. d''8 ~ | d''8 c''16 bes'8. r2 c''16 d''16 | es''4 d''4 d''4 bes'16 c''16 c''8 ~ | c''8 r2. r8 | d''8 es''16 f''8 bes''16 a''8 ~ a''4 f''8 d''8 ~ | d''8 r4 r16 bes'16 es''8 d''16 c''8. bes'16 bes'16 ~ | bes'8. r2. r16 | \sectionLabel "Pre-Chorus" r4. r16 bes'16 es''8 d''16 es''8. f''8 ~ | f''8 bes'4 c''8 ~ c''8 r4. | r4. r16 bes'16 es''8 d''16 c''8. bes'16 d''16 ~ | d''8. r2 r8. bes'8 | g''4 g''8 a''8 ~ a''8 a''8 bes''8 bes''8 ~ | bes''8 r4 bes'16 bes'16 es''8 d''16 c''8. bes'8 ~ | bes'8 bes'4 r2 r8 | \sectionLabel "Chorus" r2 r8. f''16 bes''16 a''8. | bes''8 a''16 g''8. f''8 c''4 r8. bes'16 | d''16 es''16 d''16 c''8. bes'16 bes'16 ~ bes'8 r8 bes''16 a''16 g''16 f''16 | f''2 r8 bes''8 a''8 bes''8 ~ | bes''2 ~ bes''8 r4 r16 bes'16 | es''4 d''4 c''4 bes'4 | \sectionLabel "Bridge" bes'4 r2 r8. bes'16 | g''8 g''8 g''8 a''8 a''4 r8 g''16 a''16 | bes''8 a''16 g''8. f''8 ~ f''8 d''16 c''16 bes'8 r16 bes'16 | es''8 d''16 es''8. f''8 ~ f''4 d''8 d''8 ~ | d''8 r4 r16 bes'16 es''8 d''16 c''8. bes'16 bes'16 ~ | \sectionLabel "Outro" bes'8. r2 r8. bes''8 | bes''8 a''8 g''8 f''8 f''4 r8. bes'16 | d''16 es''16 d''16 c''8. r8 r4 bes''8 a''16 g''16 | \time 9/8 f''2 r4 a''4. | \time 4/4 \sectionLabel "Outro" bes''2 ~ bes''2 ~ | bes''2 r2 | R1*1 | R1*1 |
  \bar "|."
}
harmony = \chordmode { s1*7/8 bes1*5/8 f1*1/2/a es1*1/2/g es1*1/2/f bes1*1/2 f1*1/2/a es1 bes1*1/2 f1*1/2/a g1:m7 c1*1/2:m7 bes1*1/2 f1*1/2:sus4 f1*1/2 bes1*1/2 f1*1/2/a g1*1/2:m7 es1*1/2 bes1 es1 bes1*1/2 f1*1/2 g1*1/2:m7 es1*1/2 bes1 es1*1/2 f1*1/2 g1*1/2:m7 es1*1/2 bes1 f1 bes1*1/2 f1*1/2 g1*1/2:m7 es1*1/2 bes1*1/2 f1*1/2 g1*1/2:m7 es1 f1*1/2 bes1*1/2 f1*1/2/a es1 bes1*1/2 f1*1/2/a g1:m7 es1*1/2 bes1*1/2 f1 bes1*1/2 f1*1/2/a g1*1/2:m7 es1*1/2 bes1 es1 bes1*1/2 f1*1/2 g1*1/2:m7 es1*1/2 bes1 es1*1/2 f1*1/2 g1*1/2:m7 es1*1/2 bes1 f1 bes1*1/2 f1*1/2 g1*1/2:m es1*1/2 bes1*1/2 f1*1/2 g1*1/2:m es1 f1*1/2 bes1 es1*1/2 f1*1/2 g1*1/2:m bes1*1/2/d es1*1/2 f1*1/2 g1*1/2:m es1*1/2 bes1 es1*1/2 f1*1/2 g1*1/2:m es1*1/2 bes1*1/2 f1*5/8 bes1*1/2 f1*1/2/a es1*1/2/g es1*3/4 bes1*7/4 }
words = \lyricmode { "I" _ "will" "ask" "the" "Fa" -- "ther" "now" "He" _ "will" "give" "you" "an" -- "oth" -- "er" "guide" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "To" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "be" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "with" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "you" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "fo" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "re" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "ver" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "more" "In" "the" "qui" -- "et" "of" "the" "night" "The" "Spir" -- "it" "of" "truth" "comes" "near" "Who" "the" "world" "can" -- "not" "re" -- "ceive" "It" "nei" -- "ther" "sees" "nor" "knows" "his" "face" "But" _ "you" "have" "him" "with" -- "in" "An" -- "oth" -- "er" "Ad" -- "vo" -- "cate" "with" "you" "The" "Spir" -- "it" "of" "truth" "re" -- "mains" "He" "is" "in" "you" "and" \skip 1 "with" "you" "The" "truth" "that" "no" "one" "claims" "He" _ "will" "not" "leave" "you" "as" "or" -- "phans" "I" "am" "com" -- "ing" "to" "re" -- "turn" _ "In" "a" "lit" -- "tle" "while" "you" "see" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "The" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "Fa" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "ther" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "in" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "the" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "Son" "The" "world" "will" "see" "me" "no" "more" "But" "you" "will" "see" "me" "live" "Be" -- "cause" "I" "live" "you" "will" "live" "In" "the" "Fa" -- "ther" "and" "in" "me" "An" -- "oth" -- "er" "Ad" -- "vo" -- "cate" "with" "you" "The" "Spir" -- "it" "of" "truth" "re" -- "mains" "He" "is" "in" "you" "and" \skip 1 "with" "you" "The" "truth" "that" "no" "one" "claims" "You" "know" "him" "for" "he" "stays" "He" "re" -- "mains" "with" "you" "al" -- "ways" _ _ "The" "world" "does" "not" "know" "his" "name" "But" "you" "are" "not" "a" -- "lone" "You" "know" "him" "for" "he" "stays" "The" "Spir" -- "it" "of" "truth" "He" "re" -- "mains" "with" "you" _ }
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
