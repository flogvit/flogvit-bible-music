\version "2.24.0"
\header {
  title = "Joktan's Son"
  subtitle = "Genesis 10:26; 1 Chronicles 1:20"
  tagline = ##f
  copyright = \markup \small \wordwrap { "Melody" "and" "chords" "from" "the" "score" "YuE2" "generated" "the" "song" "from" "(score.abc)." "Lyrics" "placed" "syllable" "by" "syllable" "against" "the" "recording" "with" "Whisper," "which" "heard" "97" "of" "100" "words." "All" "21" "lyric" "lines" "sit" "on" "their" "notes." }
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
  \clef treble \key es \major \tempo 4 = 74
  \time 4/4 \sectionLabel "Intro" R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | \sectionLabel "Verse 1" r8 g'16 bes'16 bes'8 g'16 bes'8. bes'16 c''8. r8 | f'16 f'16 f'8 f'8 f'16 es'16 g'4 r4 | r8. bes16 g'16 bes'16 bes'16 g'16 bes'8. c''8. es'16 es'16 | es'8. es'8 es'8. es'8 r4. | \sectionLabel "Verse 2" r8 g'16 bes'16 bes'8 bes'8 bes'8 bes'16 c''8. r16 bes'16 | d''8 d''16 c''16 d''8 c''16 bes'16 bes'4 r8. bes'16 | es''8 d''16 d''4 r16 d''8 c''16 c''8. c''16 bes'16 | c''8 bes'16 bes'8. g'16 f'16 es'4 r4 | \time 2/4 R1*1/2 | \time 4/4 \sectionLabel "Verse 3" r8 g'16 bes'16 bes'8 bes'16 g'16 c''8 r4 r16 es'16 | f'16 f'8. f'16 es'16 f'8 es'16 g'8. r4 | r8 g'16 bes'16 bes'8 g'16 bes'8 bes'8. c''8 r8 | c'16 es'16 es'16 es'8 es'8. es'4 r4 | \sectionLabel "Verse 4" r8 g'16 bes'16 bes'8 g'16 bes'8 bes'8. c''4 | d''16 c''16 d''16 c''16 d''8 c''16 c''16 bes'4 r4 | es''8. d''8. d''16 d''8 c''16 c''16 c''8. c''16 bes'16 | c''8 bes'16 bes'8 g'8. f'16 es'4. ~ es'16 ~ | es'2 ~ es'16 r4. r16 | \sectionLabel "Verse 5" r4 es''8 es''16 es''16 es''8 d''8 c''4 | r4 es''8 es''16 es''16 es''8 d''8 c''4 | r4 es''8 es''16 es''16 es''8 bes'16 bes'8. bes'16 bes'16 | f''8. f''8. es''16 g''4. as''16 f''8 ~ | f''2 ~ f''8 r4. | \time 3/8 R1*3/8 | \time 4/4 \sectionLabel "Outro" c''8 c''16 c''16 c''8 bes'16 r8. g'8 g'16 f'16 es'16 r16 | \sectionLabel "Outro" R1*1 | R1*1 | R1*1 | R1*1 |
  \bar "|."
}
harmony = \chordmode { s1*3/4 es1*5/4 as1/es es1 as1/es es1 bes1 c1:m as1 es1 bes1 c1:m as1*3/2 es1 bes1 c1:m as1 es1 bes1 c1:m as1*2 c1:m as1 es1 bes1*19/8 bes1 es1 as1*5/4/es es1*7/4 }
words = \lyricmode { "Jok" -- "tan" "fa" -- "thered" "Al" -- "mo" -- "dad" "She" -- "leph" "came" "next" "in" "the" "line" "Ha" -- "zar" -- "ma" -- "veth" "and" "Jer" -- "ah" "In" "the" "east" "they" "drew" "near" "Sons" _ _ "of" "Shem" "af" -- "ter" "the" "Flood" "De" -- "scen" -- "dants" "of" "Noah's" "blood" "A" _ "fami" -- "ly" "tree" "from" "the" "start" "In" "the" "land" "of" "the" "east" "part" "Thir" -- "teen" "sons" "in" "the" "list" "Of" _ "Jok" -- "tan's" "lin" -- "eage" "dis" -- "tinct" "In" "the" "moun" -- "tain" "re" -- "gions" "high" "Un" -- "der" "the" "o" -- "pen" "sky" "Gen" -- "e" -- "sis" "re" -- "cords" "their" "names" _ "Chron" -- "i" -- "cles" "re" -- "peats" "the" "same" "From" "the" _ "be" -- "gin" -- "ning" "of" "days" _ "To" "the" "light" "of" "our" "eyes" "Part" "of" "the" "na" -- "tions" "spread" "Af" -- "ter" "the" "Tow" -- "er's" "head" "Scat" -- "tered" "ac" -- "ross" "the" "land" "By" "the" "Fa" -- "ther's" "com" -- "mand" _ _ "She" -- "leph" "re" -- "mains" "in" "the" "text" _ _ }
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
