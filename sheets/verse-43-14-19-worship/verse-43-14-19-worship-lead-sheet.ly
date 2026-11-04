\version "2.24.0"
\header {
  title = "Because I live, you also will live"
  subtitle = "John 14:19"
  tagline = ##f
  copyright = \markup \small \wordwrap { "Melody" "and" "chords" "from" "the" "score" "YuE2" "generated" "the" "song" "from" "(score.abc)." "Lyrics" "placed" "syllable" "by" "syllable" "against" "the" "recording" "with" "Whisper," "which" "heard" "151" "of" "151" "words." "All" "24" "lyric" "lines" "sit" "on" "their" "notes." "Bible" "text:" "Open" "Source" "English" "(OSEN)," "CC" "BY" "4.0," "from" "SBLGNT" "and" "tanach.us." }
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
  \time 4/4 \sectionLabel "Intro" R1*1 | R1*1 | R1*1 | R1*1 | \sectionLabel "Verse 1" r2 d''8 es''16 f''8. r8 | f''4 c''8 c''4 r4. | r2 bes'8 c''16 d''8. es''8 | d''4 a'8 a'4 r4 r16 a'16 | g'4 a'8 bes'4 g''4 f''8 ~ | f''4 d''8 d''16 c''16 bes'8 r4 r16 d''16 | es''8 d''8 es''16 d''16 d''16 es''8. d''16 c''8. bes'8 | \sectionLabel "Chorus" c''4 r4 r8. bes'16 bes'16 f''8. | f''4 r4. bes'16 bes'8 bes'16 f''8 ~ | f''8 f''4 r2 g''16 a''16 | bes''16 a''8 g''8. f''16 d''8. c''16 c''16 bes'8 bes'16 d''16 ~ | d''8. r2 bes'16 d''8 c''8 | c''8 bes'4 r4. c''8 d''8 ~ | d''4 r16 c''16 bes'4 r4 d''8 | es''4 d''8 c''8 ~ c''4 bes'8 bes'8 ~ | bes'2 ~ bes'8 r4. | R1*1 | \sectionLabel "Verse 2" r2 d''8 es''16 f''8. f''8 ~ | f''8 c''8 c''8 c''4 d''4 r8 | r4. bes'16 c''16 d''8 es''16 d''8. bes'16 a'16 ~ | a'8. r2 r16 bes'8 a'8 | g'4. bes'4 g''4 f''8 ~ | f''4 r4 d''8 es''16 d''8. es''16 d''16 ~ | d''16 c''8 c''8. r8 d''16 c''16 bes'16 c''8. r8 | d''8 c''16 bes'16 c''2 r8 d''8 | es''8. d''8. es''8 f''8. d''8 c''16 c''16 bes'16 ~ | \sectionLabel "Chorus" bes'4. ~ bes'16 r4 bes'16 bes'16 f''8. | f''2 r8 bes'16 bes'8 bes'16 f''8 ~ | f''8 f''2 r4 g''16 a''16 | bes''16 a''8 g''8. f''16 d''4 c''16 bes'8 bes'16 d''16 ~ | d''4. ~ d''16 r4 bes'16 d''8 c''8 | c''8 bes'2 r8 c''8 d''8 ~ | d''4 r16 c''16 bes'4. r8 d''8 | es''4 d''8 c''8 ~ c''4 bes'8 bes'8 ~ | bes'2 ~ bes'8 r4. | \sectionLabel "Bridge" bes''8 a''16 a''8. g''16 g''8 f''8 f''8. r8 | bes''8 a''16 g''16 g''8 f''16 d''4 r8. f''16 g''16 ~ | g''16 g''4 r16 g''16 g''8 f''8 f''8. d''16 d''16 ~ | d''16 c''8 c''8. bes'8 d''4 r8 bes'16 c''16 | \sectionLabel "Outro" c''16 r2 r8 bes'16 bes'16 f''8. | f''4 r4. bes'16 bes'8 bes'16 f''8 ~ | f''8 f''4 r2 d''8 | es''8 d''4 c''8 ~ c''4. bes'16 bes'16 ~ | bes'8. r2. r16 | \time 9/8 R1*9/8 | \time 4/4 R1*1 |
  \bar "|."
}
harmony = \chordmode { bes1*4 bes1 d1:m7 g1:m d1:m es1 bes1*1/2 g1*1/2:m c1:m7 f1*1/2:sus4 f1*1/2 bes1 d1:m7 g1:m d1:m es1 g1:m c1*1/2:m7 f1*1/2 bes1*2 bes1 d1:m7 g1:m d1:m7 es1 bes1*1/2 g1*1/2:m c1:m7 f1 c1*1/2:m7 f1*1/2 bes1*2 d1:m7 g1:m d1:m7 es1 g1:m c1*1/2:m7 f1*1/2 bes1 es1 g1:m es1 f1 f1 bes1 d1:m es1*1/2 f1*1/2 bes1*25/8 }
words = \lyricmode { "The" "Ad" -- "vo" -- "cate" "comes" "to" "stay" "The" "Spir" -- "it" "of" "truth" "re" -- "mains" "He" "dwells" "with" -- "in" "your" "heart" "to" -- "day" _ "The" _ "world" "sees" "noth" -- "ing" "but" "the" "fain" -- "test" "pain" "Be" -- "cause" "I" "live," "you" "al" -- "so" "will" "live" "In" _ _ "a" "lit" -- "tle" "while" "the" "world" "looks" "a" -- "way" "But" "you" "will" "see" "me," \skip 1 "a" -- "live" _ "Your" "life" "is" "bound" "to" "mine" "I" "will" "not" "leave" "you" "as" "or" -- "phans" "I" "am" "com" -- "ing" "to" "be" "near" "On" "that" "day" "you" "will" "learn" "I" "am" "in" "the" "Fa" -- "ther," "clear" "You" "are" "in" "me," "I" "am" "in" "you" "A" _ "bond" "that" "no" "death" "can" "break" _ "Be" -- "cause" "I" "live," "you" "al" -- "so" "will" "live" "In" _ "a" "lit" -- "tle" "while" "the" "world" "looks" "a" -- "way" "But" "you" "will" "see" "me," "a" -- "live" \skip 1 \skip 1 "Your" "life" "is" "bound" "to" "mine" "Hold" "to" "my" "com" -- "mand" -- "ments" "tight" "Love" "me" "with" "all" "your" "heart" "The" _ "Fa" -- "ther" "will" "love" "you" "back" "And" "I" "will" "show" "my" -- "self" _ _ "Be" -- "cause" "I" "live," "you" "al" -- "so" "will" "live" "For" -- "ev" -- "er" "in" "the" "light" }
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
