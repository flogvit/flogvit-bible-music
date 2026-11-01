\version "2.24.0"
\header {
  title = "With All My Heart"
  subtitle = "Psalms 9:1–2"
  tagline = ##f
  copyright = \markup \small \wordwrap { "Melody" "and" "chords" "from" "the" "score" "YuE2" "generated" "the" "song" "from" "(score.abc)." "Lyrics" "placed" "syllable" "by" "syllable" "against" "the" "recording" "with" "Whisper," "which" "heard" "186" "of" "188" "words." "25" "of" "26" "lyric" "lines" "sit" "clearly" "on" "their" "notes;" "1" "are" "uncertain" "and" "printed" "in" "grey" "italics." "Bible" "text:" "Open" "Source" "English" "(OSEN)," "CC" "BY" "4.0," "from" "SBLGNT" "and" "tanach.us." }
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
  \clef treble \key bes \major \tempo 4 = 74
  \time 4/4 \sectionLabel "Intro" R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | \sectionLabel "Verse 1" d'16 f'8 f'8. d'16 g'8. f'16 c'8 bes8. ~ | bes16 r16 bes8 r2. | g'16 bes'8 bes'8. bes'16 a'16 ~ a'16 g'16 f'4 f'16 f'16 ~ | f'8 d'8 r2 r8 bes'16 c''16 | d''8 d''4 c''16 c''16 ~ c''8. r16 bes'8 g'8 ~ | g'8 r2 r16 bes16 bes16 c'16 d'8 | d'8 c'16 bes8. r16 bes16 f'4 d'8 d'16 c'16 | \sectionLabel "Pre-Chorus" bes16 bes8. r2 r8 bes'8 | bes'8 bes'8 bes'8 c''8 ~ c''8 d''8 r8. f'16 | d''8. c''16 c''8 bes'8 ~ bes'8 r4. | bes'8 bes'8 bes'8 c''8 ~ c''4 d''8 d''8 ~ | \sectionLabel "Chorus" d''8 c''16 bes'16 bes'8 bes'4 r4 r16 f'16 | d''4 f''4 f''8 d''8 c''8 bes'8 ~ | bes'8 bes'4 r2 r16 f'16 | g'8 bes'16 bes'8. c''16 d''16 ~ d''16 c''16 c''16 bes'16 bes'8 d''8 ~ | d''4. r2 r8 | es''8 es''16 es''8. d''16 d''16 ~ d''16 c''16 c''8 c''8 bes'8 ~ | bes'8 r4 r16 f'16 d''8 d''8 c''16 bes'16 bes'8 ~ | bes'8 bes'2 r4. | \sectionLabel "Verse 2" r2. r8 bes16 c'16 | d'16 f'4 r16 d'16 g'16 ~ g'8 f'4 d'16 c'16 | bes4 r2 r8. bes16 | bes'8 bes'4 a'8 g'16 f'16 f'8 f'8 d'8 ~ | d'8 r2. bes'8 | d''8 d''8 d''8 c''8 ~ c''8 c''8 bes'8 g'8 ~ | g'16 f'16 r2. d'8 | d'16 c'16 bes4 bes16 f'16 ~ f'8. r16 d'8 c'16 bes16 ~ | \sectionLabel "Pre-Chorus" bes8. r2 r8. bes'8 | bes'8 bes'8 bes'8 c''8 ~ c''8 d''8 r8. bes'16 | d''8. c''16 c''16 bes'16 bes'4 r4. | bes'8 bes'8 bes'8 c''8 ~ c''4 d''8 d''8 ~ | \sectionLabel "Chorus" d''8 c''16 bes'16 bes'8 bes'4 r4 r16 f'16 | d''4 f''4 f''8 d''8 c''8 bes'8 ~ | bes'8 bes'4 r2 r16 f'16 | g'8 bes'16 bes'8. c''16 d''16 ~ d''16 c''16 c''16 bes'16 bes'8 d''8 ~ | d''4. r2 r8 | es''8 es''16 es''8. d''16 d''16 ~ d''8 c''8 c''8 bes'8 ~ | bes'8 r4 r16 f'16 d''8 d''8 c''16 bes'16 bes'8 ~ | bes'8 bes'2 r4. | R1*1 | \sectionLabel "Bridge" d''8 d''8 d''8 c''8 ~ c''8 bes'16 d''8. c''16 c''16 | bes'4 r2 r8 bes'8 | bes'4 bes'8 c''8 ~ c''8 d''8 r8 d''8 | \time 2/4 d''8. c''16 c''8 bes'8 ~ | \time 4/4 \sectionLabel "Chorus" bes'4 r2 r8. f'16 | d''4 f''4 f''8 d''8 c''8 bes'8 ~ | bes'8 bes'4 r2 r16 f'16 | g'8 bes'16 bes'8. c''16 d''16 ~ d''16 c''16 c''16 bes'16 bes'8 d''8 ~ | d''2 ~ d''8 r4. | es''8 es''16 es''8. d''16 d''16 ~ d''16 c''16 c''8 c''8 bes'8 ~ | bes'8 r4 r16 f'16 d''8 d''8 c''8 bes'8 ~ | bes'8 bes'2 r4. | R1*1 | R1*1 | R1*1 |
  \bar "|."
}
harmony = \chordmode { s1*7/8 bes1*5/8 f1*1/2/a g1*1/2:m7 bes1*1/2/f es1*1/2 bes1*1/2/d f1*1/2:sus4 f1*1/2 bes1 es1 g1*1/2:m7 f1*1/2 bes1*3/2 f1*1/2/a es1 g1*1/2:m7 f1*1/2 bes1 es1*1/2 f1*1/2 bes1*1/2 es1 f1*1/2 g1:m bes1*1/2 f1*1/2/a g1:m es1*1/2 f1*1/2 bes1 es1*1/2 f1*1/2 g1*1/2:m f1*1/2 es1 es1 bes1*1/2 f1*1/2/a es1 g1*1/2:m f1*1/2 bes1 g1*1/2:m f1*1/2 es1 g1*1/2:m f1*1/2 bes1 es1*1/2 f1*1/2 g1:m es1*1/2 f1*1/2 g1:m bes1*1/2 f1*1/2/a g1:m es1*1/2 f1*1/2 bes1 es1*1/2 f1*1/2 g1*1/2:m f1*1/2 es1*2 g1*1/2:m f1*1/2 es1 g1*1/2:m f1*1/2 es1*1/2 es1 bes1*1/2 f1*1/2/a g1:m es1*1/2 f1*1/2 bes1 es1*1/2 f1*1/2 g1*1/2:m f1*1/2 es1*2 bes1*2 }
words = \lyricmode { "I" "will" "thank" "the" "LORD" "with" "all" "my" "heart" "I" _ _ "will" "tell" "of" "all" "your" "won" -- "ders" "You" "are" "the" "Most" "High," "the" "judge" "of" \skip 1 "earth" _ "My" "en" -- "e" -- "mies" "turn" "back" "and" "lose" "their" "groun" -- "ders" "They" _ "stum" -- "ble" "and" "per" -- "ish" "be" -- "fore" "your" "face" "You" _ "have" "up" -- "held" "my" "right" "in" "this" "place" "With" "all" "my" "heart" "I" "sing" "your" "praise" "Re" -- _ _ "joic" -- "ing" "in" "the" "joy" "of" "your" "days" "I" _ "will" "tell" "of" "all" "your" "won" -- "ders" "With" _ "all" "my" "heart" "I" "stand" "You" _ "have" "tak" -- "en" "your" "seat" "on" "the" "throne" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "A" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "right" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "eous" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "judge" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "who" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "is" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "known" _ _ "My" _ "cause" "is" "up" -- "held" "in" "your" "light" "My" _ "en" -- "e" -- "mies" "are" "gone" "from" "sight" "They" _ "stum" -- "ble" "and" "per" -- "ish" "be" -- "fore" "your" "face" _ "You" _ "have" "up" -- "held" "my" "right" "in" "this" "place" "With" "all" "my" "heart" "I" "sing" "your" "praise" \skip 1 \skip 1 "Re" -- "joic" -- "ing" "in" "the" "joy" "of" "your" "days" "I" "will" "tell" "of" "all" "your" "won" -- "ders" "With" _ "all" "my" "heart" "I" "stand" "Glad" _ "and" "re" -- "joice" "in" "you" "a" -- "lone" "Your" _ "name" "is" "ho" -- "ly," "your" "love" "is" "known" "With" "all" "my" "heart" "I" "sing" "your" "praise" "Re" -- _ _ "joic" -- "ing" "in" "the" "joy" "of" "your" "days" "I" _ "will" "tell" "of" "all" "your" "won" -- "ders" "With" "all" "my" "heart" "I" "stand" }
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
