\version "2.24.0"
\header {
  title = "Free Indeed"
  subtitle = "John 8:36"
  tagline = ##f
  copyright = \markup \small \wordwrap { "Melody" "and" "chords" "from" "the" "score" "YuE2" "generated" "the" "song" "from" "(score.abc)." "Lyrics" "placed" "syllable" "by" "syllable" "against" "the" "recording" "with" "Whisper," "which" "heard" "171" "of" "171" "words." "20" "of" "22" "lyric" "lines" "sit" "clearly" "on" "their" "notes;" "2" "are" "uncertain" "and" "printed" "in" "grey" "italics." "Bible" "text:" "Open" "Source" "English" "(OSEN)," "CC" "BY" "4.0," "from" "SBLGNT" "and" "tanach.us." }
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
  \clef treble \key bes \major \tempo 4 = 82
  \time 4/4 \sectionLabel "Intro" R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | \sectionLabel "Verse 1" r8. bes'16 d''8 d''16 d''8. c''16 c''8 bes'8 c''16 ~ | c''8 c''4 d''8 r2 | r8. bes'16 d''8 d''16 d''16 d''16 c''16 bes'8 r4 | c''16 bes'16 bes'4 bes'8 r2 | r8. bes'16 f''16 f''8 f''8. d''16 d''16 d''16 c''16 bes'8 | c''8 c''4 d''8 r4. bes'16 c''16 | d''8. f''8. g''4 d''4 r8 | c''16 bes'16 bes'4 bes'4 r4. | \sectionLabel "Chorus" bes''8 bes''8 bes''8 bes''4 f''8 bes''8 a''8 ~ | a''8 g''8 f''8 f''4 r4. | bes''8 bes''16 bes''8. bes''4 f''8 f''8 g''8 ~ | g''8 f''8 f''8 bes'4 r4 bes'16 d''16 ~ | d''8. r8. d''8 d''4 f''8 f''8 ~ | f''8 c''8 bes'8 c''4 r4 bes'16 c''16 | d''4 c''8. bes'16 c''16 bes'8. g'16 bes'8. | bes'4 r2. | R1*1 | \sectionLabel "Verse 2" r4 d''16 d''8 d''8. c''8 bes'8 c''8 ~ | c''8 c''8 bes'8 d''4 r4. | r8 d''8 d''8 d''8 d''16 c''16 bes'4 c''8 ~ | c''8 bes'4 bes'4 r4. | r8 f''8 f''8 f''16 f''16 d''16 d''8. r4 | r16 bes'16 c''8 bes'8 d''4 r8. bes'16 c''8 | d''8. f''8. g''4 d''4. | c''8 bes'4 bes'4 r4. | \sectionLabel "Chorus" bes''8 bes''8 bes''8 bes''4 f''8 bes''8 a''8 ~ | a''8 g''8 f''8 f''4 r4. | bes''8 bes''16 bes''8. bes''4 f''8 f''8 g''8 ~ | g''8 f''8 f''8 bes'4 r4 bes'16 d''16 ~ | d''8. r8. d''8 d''4 f''8 f''8 ~ | f''8 c''8 bes'8 c''4 r4 bes'16 c''16 | d''4 c''8. bes'16 c''16 bes'8. g'16 bes'8. | \sectionLabel "Bridge" bes'4 r2 r8. bes'16 | g''8 g''16 g''8 g''16 g''8 g''8. f''8 d''8 d''16 ~ | d''8 c''16 bes'16 r2 r8. bes'16 | g''8 g''16 g''8 g''8 g''4 f''8 d''8 d''16 ~ | d''8 c''16 bes'16 r2 r8. bes'16 | g''8 g''16 g''8 g''16 g''8 g''8. f''8 d''8. | d''16 c''16 bes'8 r4 d''8. c''16 c''8. bes'16 | bes'4 r4. g'8 bes'8 bes'8 ~ | \sectionLabel "Outro" bes'8 r2 r8 d''8 c''16 bes'16 | bes'2 r8 bes'16 d''8. c''16 c''16 ~ | c''4. ~ c''16 r4 r16 d''8 c''16 bes'16 | bes'2 r8 bes'16 d''8. c''16 bes'16 ~ | bes'8 bes'2 r4. | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 |
  \bar "|."
}
harmony = \chordmode { s1*7/8 bes1*9/8 f1/a g1:m es1 bes1 f1/a g1:m es1 bes1 f1/a g1:m es1 bes1 f1 g1:m es1 bes1 f1 g1*1/2:m es1*1/2 bes1*2 bes1 f1/a g1:m es1 bes1 f1/a g1:m es1 bes1 f1 g1:m es1 bes1 f1 g1*1/2:m es1*1/2 bes1 es1 bes1 es1 g1:m es1 g1:m es1 es1 bes1 f1/a g1:m es1 bes1 f1/a g1:m es1*2 }
words = \lyricmode { "We" "claim" "the" "blood" "of" "Ab" -- "ra" -- "ham" "runs" "deep" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "We" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "say" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "we" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "have" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "ne" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "ver" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "been" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "a" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "nyo" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "ne's" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "slave" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "But" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "you" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "ask" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "how" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "we" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "could" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "ev" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "er" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "be" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "tru" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "ly" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "free" "When" "the" "chains" "of" "sin" "are" "hea" -- "vy" "and" "strong" "Tru" -- "ly," _ "tru" -- "ly," "I" "tell" "you" "to" -- "day" "Ev" -- "ery" -- "one" "who" "com" -- "mits" "sin" "is" "a" "slave" "A" "slave" "does" "not" "re" -- "main" "in" "the" "house" "But" "a" "son" "stays" "for" -- "ev" -- "er" "in" "his" "place" "If" "the" "Son" "sets" "you" "free" "from" "the" "bond" "You" "will" "be" "free" "in" -- "deed," "tru" -- "ly" "free" "I" "know" "your" "lin" -- "eage," "I" \skip 1 "know" "your" "name" "But" "my" "word" "finds" "no" "room" "in" "your" "heart" "Tru" -- "ly," _ "tru" -- "ly," "I" "tell" "you" "to" -- "day" "Ev" -- "ery" -- "one" "who" "com" -- "mits" "sin" "is" "a" "slave" "A" "slave" "does" "not" "re" -- "main" "in" "the" "house" "But" "a" "son" "stays" "for" -- "ev" -- "er" "in" "his" "place" "I" _ "speak" "of" "what" "I" "have" "seen" "with" "my" "Fa" -- "ther" "You" _ "do" "what" "you" "have" "heard" "from" "your" "fa" -- "ther" "If" _ _ "you" "were" "chil" -- "dren" "of" "Ab" -- "ra" -- "ham" "then" "You" "would" "do" "the" "works" "that" "he" "did" "Free" _ "in" -- "deed," "the" "son" "re" -- "mains" "Free" _ "in" -- "deed," \skip 1 "the" "chains" "are" "gone" }
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
