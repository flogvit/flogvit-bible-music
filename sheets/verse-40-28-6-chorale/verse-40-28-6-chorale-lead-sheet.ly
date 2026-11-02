\version "2.24.0"
\header {
  title = "He Is Not Here, for He Is Risen"
  subtitle = "Matthew 28:6"
  tagline = ##f
  copyright = \markup \small \wordwrap { "Melody" "and" "chords" "from" "the" "score" "YuE2" "generated" "the" "song" "from" "(score.abc)." "Lyrics" "placed" "syllable" "by" "syllable" "against" "the" "recording" "with" "Whisper," "which" "heard" "107" "of" "108" "words." "All" "16" "lyric" "lines" "sit" "on" "their" "notes." "Bible" "text:" "Open" "Source" "English" "(OSEN)," "CC" "BY" "4.0," "from" "SBLGNT" "and" "tanach.us." }
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
  \clef treble \key f \major \tempo 4 = 76
  \time 4/4 R1*1 | R1*1 | R1*1 | R1*1 | \sectionLabel "Verse 1" r2. c''4 | c''4 c''8 c''16 c''16 ~ c''8 bes'16 bes'8. a'16 a'16 ~ | a'8. r4 a'16 a'8 bes'16 c''8. f'16 d'16 ~ | d'8. r2 r8. d'16 d'16 ~ | d'8 bes'8 bes'4 bes'8 a'8 g'8 f'16 g'16 ~ | g'8. r8. g'8 g'8 a'8 bes'8 c''8 ~ | c''8 c''2 r4. | \sectionLabel "Verse 2" r2 r8 c''16 f''8 e''8. | f''2 r8 c''16 f''8. e''8 | e''16 d''4. r8. d''8 d''8 c''16 c''16 ~ | c''4 ~ c''16 r4 r16 bes'16 bes'8. a'8 | a'4. r4 c''8 f''8 e''16 f''16 ~ | f''2 ~ f''8 g''8 f''8 e''8 | d''2 r4. c''16 c''16 ~ | c''8. r16 a''8. g''16 g''8 f''8 f''8 e''16 f''16 ~ | f''1 ~ | f''2 ~ f''4. ~ f''16 r16 | R1*1 | \sectionLabel "Verse 3" r2. c''4 | c''4 c''4 c''8 bes'8 bes'8 a'16 a'16 ~ | a'8. r8. a'16 a'16 a'16 bes'8 c''4 ~ c''16 ~ | c''16 f'16 d'4. r4. d'16 d'16 ~ | d'8 bes'16 bes'4 r16 bes'8 a'16 g'8. f'16 g'16 ~ | g'8. r8. g'8 g'8. a'8. bes'8 | bes'4. a'2 r8 | \sectionLabel "Verse 4" r2 r8 c''8 f''8 e''8 | g''16 f''2 ~ f''8. f''8 e''16 e''16 ~ | e''8 d''4. r8 d''8 d''8 c''8 | d''16 c''4. r4 r16 bes'8 a'16 a'16 ~ | a'4. ~ a'16 r8. c''16 f''16 ~ f''16 e''8. | f''2 r8 g''8 f''8 e''8 | e''16 d''4. r4. r16 c''8 | c''4 a''8. g''16 g''8 f''16 f''8. e''8 ~ | e''8 f''2. ~ f''8 ~ | f''1 ~ | f''8 r2. r8 |
  \bar "|."
}
harmony = \chordmode { s1*7/8 f1*9/8 c1:7 f1*1/2 d1*1/2:m c1 f1*1/2 c1*1/2/e d1:m bes1 g1:m c1 f1 c1 f1 bes1 c1 f1 d1:m bes1 c1 f1 bes1*1/2/f f1*1/2 c1 c1 f1 d1:m bes1 g1:m c1 f1 c1 f1 bes1 c1 f1*3/4 c1*1/4/e d1:m bes1 c1 f1*3 }
words = \lyricmode { "They" "came" "to" "the" "tomb" "at" "ear" -- "ly" "dawn" "To" "find" "the" "Lord" "who" "died" "An" "an" -- "gel" "said," "Do" "not" "be" "af" -- "raid" "I" "know" "whom" "you" "have" "sought" "He" "is" "not" "here," "for" "he" "is" "ri" -- "sen" "Just" "as" "he" "said," "it" "now" "is" "done" "Come," "see" "the" "place" "where" "once" "he" "lay" "The" _ "grave" "by" "life" "is" "o" -- "ver" -- "come" "Now" "go" "and" "tell" "his" "fol" -- "low" -- "ers" "He" "has" "ri" -- "sen" "from" "the" "dead" "He" "goes" "be" -- "fore" "you" "to" "Ga" -- "li" -- "lee" "And" "there" "you" "will" "see" "him" "So" "sing," "all" "peo" -- "ple," "East" -- "er" "morn" -- "ing" "Our" "Lord" "is" "liv" -- "ing," "he" "is" "here" "He" "is" "not" "here," "for" "he" "is" "ri" -- "sen" "The" "emp" -- "ty" "grave" "is" "al" -- "ways" "near" _ }
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
