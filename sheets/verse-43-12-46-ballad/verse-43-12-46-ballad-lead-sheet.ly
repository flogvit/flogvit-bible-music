\version "2.24.0"
\header {
  title = "I have come into the world as light"
  subtitle = "John 12:46"
  tagline = ##f
  copyright = \markup \small \wordwrap { "Melody" "and" "chords" "from" "the" "score" "YuE2" "generated" "the" "song" "from" "(score.abc)." "Lyrics" "placed" "syllable" "by" "syllable" "against" "the" "recording" "with" "Whisper," "which" "heard" "159" "of" "159" "words." "All" "27" "lyric" "lines" "sit" "on" "their" "notes." "Bible" "text:" "Open" "Source" "English" "(OSEN)," "CC" "BY" "4.0," "from" "SBLGNT" "and" "tanach.us." }
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
  \time 4/4 R1*1 | R1*1 | R1*1 | R1*1 | \sectionLabel "Verse 1" r2 bes8 c'8 d'8 es'8 | d'2 r8 f'4 c'8 | c'8 r4 bes16 c'16 d'8 es'8 f'8 bes8 ~ | bes8 r2. r16 bes16 | g'8 g'16 g'8. g'16 f'8. r4 r16 bes16 | f'16 f'16 f'16 f'8. bes16 c'16 ~ c'8 r4. | r16 bes16 d'16 c'16 d'8 c'16 d'8. r4 bes16 c'16 | d'4 es'8 d'8 c'4 r4 | \sectionLabel "Chorus" r4 d''8 c''16 c''8. bes'16 bes'8. f'16 f'16 ~ | f'8 c''4 c''4 r4. | r4 d''8 c''16 c''8. bes'8 bes'8 f'16 f'16 ~ | f'8 bes'4 bes'4 r4. | r4 d''8 c''16 c''16 ~ c''8. r16 bes'8 a'8 ~ | a'8 bes'2 r4. | \sectionLabel "Verse 2" r4. bes16 bes16 bes16 c'16 d'4 d'8 ~ | d'2 ~ d'8 f'4 c'8 ~ | c'8 r4 r16 bes16 d'8 f'4 c'8 ~ | c'8 bes8 r2 r8. bes16 | g'8 g'4 g'8 f'8 r4 d'16 es'16 | f'16 f'8 f'8. f'16 f'16 ~ f'8 bes16 c'8. r8 | r8 d'16 c'16 d'8 c'16 c'8. r4. | \sectionLabel "Chorus" r4 d''8 c''16 c''8. bes'16 bes'8. f'16 f'16 ~ | f'8 c''4 c''4 r4. | r4 d''8 c''16 c''8. bes'8 bes'8 f'16 f'16 ~ | f'8 bes'4 bes'4 r4. | r4 d''8 c''16 c''16 ~ c''8. r16 bes'8 a'8 ~ | a'8 bes'2 r4. | R1*1 | \sectionLabel "Bridge" r8. bes16 bes'16 bes'16 bes'16 bes'8 f'8. r8. bes16 | a'16 a'8 a'16 a'8 bes'8 c''4 d''8 c''16 bes'16 | bes'4 g'8 g'4 r4. | R1*1 | r8. bes16 bes'16 bes'8 bes'8. c''8 d''8 c''8 ~ | c''8 g'16 f'8. r2 r16 bes16 | g'8 f'4 f'4. d'8 d'8 ~ | d'8 c'4 r2 r8 | \sectionLabel "Chorus" r4 d''8 c''16 c''8. bes'16 bes'8. f'16 f'16 ~ | f'8 c''4 c''4 r4. | r4 d''8 c''16 c''8. bes'8 bes'8 f'16 f'16 ~ | f'8 bes'4 bes'4 r4. | r4 d''8 c''16 c''16 ~ c''8. r16 bes'8 a'8 ~ | a'8 bes'2 r4. | R1*1 | \sectionLabel "Outro" r4 d'8 d'8 d'8 c'16 c'8. bes16 c'16 | c'8 bes16 c'8. bes16 d'8. r4. | r4. r16 bes16 d'8 c'16 c'8. bes8 | c'8 bes16 bes8. r2 r8 | R1*1 |
  \bar "|."
}
harmony = \chordmode { s1*7/8 bes1*9/8 f1/a g1:m7 es1 bes1 f1/a g1:m es1 bes1*1/2/d f1*1/2 g1:m es1 bes1 f1/a g1:m es1 bes1*1/2 f1*1/2 es1 es1 bes1 f1/a g1:m es1 bes1*1/2 f1*1/2 es1 bes1 f1/a g1:m es1 bes1*1/2 f1*1/2 es1*2 g1:m f1 es1*2 g1:m f1 es1*2 bes1 f1/a g1:m es1 bes1*1/2 f1*1/2 es1*2 bes1 f1/a g1:m7 es1*2 }
words = \lyricmode { "For" "they" "loved" "hu" -- "man" "glo" -- "ry" "more" "Than" "the" "glo" -- "ry" "of" "God" "Then" _ "Je" -- "sus" "cried" "out" "Who" -- "ev" -- "er" "be" -- "lieves" "in" "me" "Does" "not" "be" -- "lieve" "in" "me" "But" "in" "him" "who" "sent" "me" "I" "have" "come" "in" -- "to" "the" "world" "as" "light" "So" "that" "no" "one" "who" "be" -- "lieves" "in" "me" "Should" "re" -- "main" "in" "dark" -- "ness" "And" "if" "a" -- "ny" -- "one" "hears" "my" "words" "And" "does" "not" "keep" "them" "I" "do" "not" "judge" "him" "For" "I" "did" "not" "come" "to" "judge" "the" "world" "But" "to" "save" "the" "world" "I" "have" "come" "in" -- "to" "the" "world" "as" "light" "So" "that" "no" "one" "who" "be" -- "lieves" "in" "me" "Should" "re" -- "main" "in" "dark" -- "ness" "Who" -- "ev" -- "er" "re" -- "jects" "me" "And" "does" "not" "re" -- "ceive" "my" "words" "Al" -- "rea" -- "dy" "has" "a" "judge" "The" _ "ve" -- "ry" "word" "I" "have" "spo" -- "ken" "Will" "judge" "him" "on" "the" "last" "day" "I" "have" "come" "in" -- "to" "the" "world" "as" "light" "So" "that" "no" "one" "who" "be" -- "lieves" "in" "me" "Should" "re" -- "main" "in" "dark" -- "ness" "I" "have" "not" "spo" -- "ken" "on" "my" "own" "au" -- "thor" -- "i" -- "ty" "The" "Fa" -- "ther" "has" "com" -- "mand" -- "ed" "me" }
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
