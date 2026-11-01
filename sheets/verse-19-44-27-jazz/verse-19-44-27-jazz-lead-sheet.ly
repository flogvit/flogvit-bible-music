\version "2.24.0"
\header {
  title = "Redeem Us"
  subtitle = "Psalms 44:27"
  tagline = ##f
  copyright = \markup \small \wordwrap { "Melody" "and" "chords" "from" "the" "score" "YuE2" "generated" "the" "song" "from" "(score.abc)." "Lyrics" "placed" "syllable" "by" "syllable" "against" "the" "recording" "with" "Whisper," "which" "heard" "95" "of" "95" "words." "All" "18" "lyric" "lines" "sit" "on" "their" "notes." "Bible" "text:" "Open" "Source" "English" "(OSEN)," "CC" "BY" "4.0," "from" "SBLGNT" "and" "tanach.us." }
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
  \clef treble \key bes \major \tempo 4 = 108
  \time 4/4 \sectionLabel "Intro" R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | \sectionLabel "Verse 1" r4. bes'8 d''8 f''8 g''8 g''8 | d''2 r2 | r2 d''8 c''8 d''4 | c''8 bes'8 bes'4 r2 | r4. bes'8 d''8 f''8 g''8 bes''16 bes''16 | r8 d''8 d''8 d''4 r4. | r4 d''8 d''16 d''16 c''8 c''16 r16 bes'4 ~ | bes'8 bes'4 r2 r8 | \sectionLabel "Verse 2" r4. bes'8 d''8. f''16 g''8 g''16 r16 | d''8 d''2 r4. | r4. bes'8 d''8 c''8 c''4 | bes'8 bes'4 r2 r8 | r4. bes'8 d''8 f''8 g''8 g''8 | d''8 d''2 d''4 d''8 ~ | d''4 c''8 c''8 ~ c''4 bes'8 bes'8 ~ | bes'4. r2 r8 | \sectionLabel "Chorus" r4 d''4 d''4 bes'4 | d''2 d''4. d''8 ~ | d''4 r8 bes'8 d''8 c''8 c''8 bes'8 | bes'4 r2. | r2 bes'4 c''4 | d''4 f''4 g''4 f''4 | d''4. bes'8 d''8 c''8 c''8 bes'8 | bes'4 r2. | \sectionLabel "Chorus" r4 d''4 d''4 bes'4 | d''2 d''4. d''8 ~ | d''4 r8 bes'8 d''8 c''8 c''8 bes'8 | bes'4 r2. | r2 bes'4 c''4 | d''4 f''4 g''4 f''4 | d''4. bes'8 d''8 c''8 c''8 bes'8 | bes'4 r2. | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | \sectionLabel "Outro" r4 d''4 d''4 bes'4 | d''2 f''4 r4 | r4. bes'8 d''8 c''8 c''8 bes'8 | bes'2 r2 | R1*1 | R1*1 | R1*1 |
  \bar "|."
}
harmony = \chordmode { s1*3/2 bes1*3/2:6 d1:7 g1:m es1:maj7 bes1:6 d1:7 g1:m es1:maj7 bes1:6 d1:7 g1:m es1:maj7 bes1:6 d1:7 g1:m es1:maj7 bes1:6 d1:7 g1*1/2:m f1*1/2 es1:maj7 es1:maj7 bes1 d1:7 g1:m es1 bes1 d1:7 g1:m es1:maj7 bes1 d1:7 g1:m es1 bes1 d1:7 g1:m es1:maj7 bes1 d1:7 g1:m es1:maj7 bes1 d1:7 g1:m es1:maj7 bes1 d1:7 g1:m es1:maj7 bes1*2 }
words = \lyricmode { "A" -- "wake" "Lord" "why" "do" "you" "sleep" "Rouse" "your" -- "self" "from" "your" "rest" "Do" "not" "re" -- "ject" "us" "for" -- "ev" -- "er" "Keep" "us" "in" "your" "sight" \skip 1 \skip 1 "Why" "hide" "your" "face" "a" -- "way" _ "For" -- "get" "our" "deep" "dis" -- "tress" "Our" _ "soul" "is" "sunk" "to" "dust" "Our" "bo" -- "dy" "clings" "to" "ground" "Rise" "up" "and" "help" "us" "now" "Re" -- "deem" "us" "in" "your" "love" "Stead" -- "fast" "kind" -- "ness" "holds" "us" "fast" "When" "all" "our" "strength" "is" "gone" "Rise" "up" "and" "help" "us" "now" "Re" -- "deem" "us" "in" "your" "love" "Stead" -- "fast" "kind" -- "ness" "holds" "us" "fast" "When" "all" "our" "strength" "is" "gone" "Rise" "up" "and" "help" "us" "Re" -- "deem" "us" "for" "your" "love" }
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
