\version "2.24.0"
\header {
  title = "My Lord and My God"
  subtitle = "John 20:24–29"
  tagline = ##f
  copyright = \markup \small \wordwrap { "Melody" "and" "chords" "from" "the" "score" "YuE2" "generated" "the" "song" "from" "(score.abc)." "Lyrics" "placed" "syllable" "by" "syllable" "against" "the" "recording" "with" "Whisper," "which" "heard" "216" "of" "216" "words." "All" "23" "lyric" "lines" "sit" "on" "their" "notes." "Bible" "text:" "Open" "Source" "English" "(OSEN)," "CC" "BY" "4.0," "from" "SBLGNT" "and" "tanach.us." }
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
  \clef treble \key bes \major \tempo 4 = 76
  \time 4/4 R1*1 | R1*1 | R1*1 | R1*1 | \sectionLabel "Verse 1" r2. r8. bes16 | d'8 f'16 f'8. f'16 g'8. f'16 d'16 c'8. bes16 | c'8 bes16 bes16 bes8 d'8 r4. r16 bes16 | d'16 f'8 f'8. d'16 g'8. f'16 d'16 c'8 r16 bes16 | c'16 bes8 bes8 d'8 d'8. r4 r16 bes16 | bes'16 a'8 a'8. g'16 g'8. f'16 f'4 d'16 | g'8 f'16 f'8 d'8 d'8. r4 r16 bes16 | es'16 d'8 es'8 d'8 f'8. d'8 c'16 bes8. | r4. r16 bes16 es'16 d'8 c'8 bes16 bes8 | R1*1 | R1*1 | \sectionLabel "Verse 2" d'16 f'8. f'16 d'16 f'16 d'16 g'8 f'8 r8 c'16 bes16 | c'8. bes16 c'8 bes16 d'8. r4 r16 bes16 | d'8 f'8 f'8 d'16 g'8 f'8 r8. c'16 bes16 | c'8. bes16 c'16 bes16 d'8 r2 | bes'8 a'16 a'8 g'8. g'8 f'16 f'8 d'16 f'16 d'16 | g'8 f'16 f'8. d'16 d'8 r4. bes16 | es'16 d'8 es'8. d'16 f'8 d'8 c'16 bes8 r16 bes16 | es'8 d'16 c'8. bes16 bes8. r4. | \sectionLabel "Pre-Chorus" r4 g'16 bes'8. c''8. d''8. bes'8 ~ | bes'8 r4. g'16 bes'8 c''8 bes'16 d''8 ~ | d''2 ~ d''8 r4. | R1*1 | r8 bes'8 bes'8 bes'8 c''8. d''16 ~ d''8 d''16 d''16 | es''8 d''16 c''16 bes'8 bes'4 r4 bes'8 | d''8 c''2 bes'8 a'8 a'16 g'16 | \sectionLabel "Chorus" f'4 r2 bes'8 bes'8 ~ | bes'8 r2 f'16 c''8 bes'16 bes'8 ~ | bes'8 r2 r8 bes'8 bes'8 ~ | bes'8 r2 f'16 c''8 bes'16 bes'8 ~ | bes'16 g'16 f'16 r2. r16 | d''8 es''16 f''8. f''4 d''16 c''8 bes'8. | bes'4 r8. f'16 d''8 c''8 bes'8 bes'8 ~ | bes'4. r2 r8 | \sectionLabel "Bridge" r2. r8. bes16 | d'16 f'8 f'8. d'16 g'8 f'8 d'8. r16 bes16 | c'16 bes8 c'8 bes16 d'4 r4 bes16 bes16 | d'8 f'16 f'8. d'16 g'8. r4 r16 bes16 | c'8 bes16 c'16 bes8 d'4 r4 r16 bes16 | bes'16 a'8. a'8 g'16 g'8 f'8. f'16 d'8 g'16 ~ | g'8 f'16 f'8 d'8 d'8. r4 r16 bes16 | es'8 d'16 es'8 d'8 f'8. d'4 c'16 bes16 ~ | bes8 r2 c'4 bes16 bes16 ~ | \sectionLabel "Chorus" bes8. r2 r16 bes'8 bes'8 ~ | bes'8 r2 f'16 c''8 bes'16 bes'8 ~ | bes'8 r2 r8 bes'8 bes'8 ~ | bes'8 r2 f'16 c''8 bes'16 bes'8 ~ | bes'16 g'16 f'16 r2. r16 | d''8 es''16 f''8. f''4 d''16 c''8 bes'8. | bes'4 r8. f'16 d''8 c''8 bes'8 bes'8 ~ | bes'4. r2 r8 | \sectionLabel "Outro" r2. bes'8 bes'8 ~ | bes'8 r2 f'16 c''8 bes'16 bes'8 ~ | bes'16 g'16 f'16 r2. r16 | R1*1 |
  \bar "|."
}
harmony = \chordmode { s1*7/8 bes1*9/8 es1 bes1 es1 bes1 es1 g1:m es1 g1:m es1 c1:m7 es1 bes1*2 bes1 es1 g1:m es1 g1:m es1 c1:m7 es1 c1:m7 es1 bes1*2 c1*3/4:m7 c1*1/4:m/d es1 f1 f1 bes1 es1 g1:m es1 bes1 es1 bes1 bes1 g1:m es1 g1:m es1 g1:m es1 c1:m7 es1 bes1*2 es1 g1:m7 es1 bes1 es1 bes1 bes1*2 es1*2 }
words = \lyricmode { "They" _ "came" "to" "me" "with" "o" -- "pen" "hands" "and" "said" "we've" "seen" "the" "Lord" "I" _ "shook" "my" "head" "and" "turned" "a" -- "way," "I" "would" "not" "take" "their" "word" "Un" -- "less" "I" "see" "the" "mark" "of" "nails" "and" "touch" "them" "with" "my" "hand" "Un" -- "less" "I" "touch" "his" "wound" -- "ed" "side," "I" \skip 1 "can" -- "not" "un" -- "der" -- "stand" "Eight" "days" "lat" -- "er" "we" "were" "gath" -- "ered" "and" "the" "doors" "were" "locked" "a" -- "gain" "He" "came" "and" "stood" "a" -- "mong" "us" "and" "he" "spoke" "to" "all" "of" "them" "Peace" "be" "with" "you," "said" "the" "Mas" -- "ter," "and" "he" "turned" "his" "eyes" "to" "me" "He" _ "did" "not" "scold," "he" "did" "not" "shame," "he" "showed" "his" "hands" "to" "me" "Put" "your" "fin" -- "ger" "here" "Look" "at" "my" "hands" _ "Reach" _ "out" "your" "hand" "and" "put" "it" "in" -- "to" "my" "side" "Stop" "doubt" -- "ing" "and" "be" -- "lieve" _ _ "My" "Lord" \skip 1 "and" "my" "God" "My" "Lord" \skip 1 "and" "my" "God" _ _ "Blessed" _ "are" "those" "who" "have" "not" "seen" "and" "yet" "have" "be" -- "lieved" "We" "ne" -- "ver" "saw" "the" "emp" -- "ty" "tomb," "we" "ne" -- "ver" "touched" "his" "hand" "But" "the" "word" "has" "come" "to" "us" "ac" -- "ross" "the" "sea" "and" "land" "So" "we" "are" "in" "the" "bles" -- "sing" "that" "he" "spoke" "in" -- "side" "that" "room" "For" "those" "who" "have" "not" "seen" "him" "ri" -- "sen" "from" "the" "tomb" "My" "Lord" \skip 1 "and" "my" "God" "My" "Lord" \skip 1 "and" "my" "God" _ _ "Blessed" _ "are" "those" "who" "have" "not" "seen" "and" "yet" "have" "be" -- "lieved" "My" "Lord" \skip 1 "and" "my" "God" _ _ }
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
