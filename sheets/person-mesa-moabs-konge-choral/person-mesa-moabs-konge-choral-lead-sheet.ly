\version "2.24.0"
\header {
  title = "Rebelled Against the King"
  subtitle = "2 Kings 3:4–5"
  tagline = ##f
  copyright = \markup \small \wordwrap { "Melody" "and" "chords" "from" "the" "score" "YuE2" "generated" "the" "song" "from" "(score.abc)." "Lyrics" "placed" "syllable" "by" "syllable" "against" "the" "recording" "with" "Whisper," "which" "heard" "92" "of" "95" "words." "All" "13" "lyric" "lines" "sit" "on" "their" "notes." }
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
  \clef treble \key es \major \tempo 4 = 70
  \time 4/4 \sectionLabel "Intro" R1*1 | R1*1 | R1*1 | R1*1 | r2. es'8 f'8 | \sectionLabel "Verse 1" g'4 g'8 g'8 f'4 es'8 d'8 | es'4 d'8 c'8 r8. c'16 f'8 g'8 | as'4 as'8 as'8 ~ as'8 g'16 f'16 f'8 es'16 f'16 | f'2 r4. bes8 | c''8 c''8 c''8 c''8 d''4 es''8. d''16 | c''16 bes'16 bes'4 r2 es'8 | as'4 as'8 g'16 as'8. g'8 f'8. es'16 | f'2 r4 es'8 f'8 | \sectionLabel "Verse 2" g'4 g'4 f'8. es'16 es'8. d'16 | es'8 c'4 r4 r16 c'16 f'8 g'8 | as'4 as'8 as'8. as'16 g'8 f'8 es'16 f'16 | f'2 r4. bes8 | c''4 c''8 c''8 d''4 es''4 | c''16 bes'16 bes'4 r4 bes16 bes16 g'4 | as'8 as'4 g'16 as'16 ~ as'8. g'16 f'16 es'8. | es'2 r2 | \sectionLabel "Verse 3" r2. r8 bes'8 | es''8 es''8 es''8 d''8 ~ d''4 c''8 bes'8 | c''4 c''8 bes'8 ~ bes'4 r8 bes'8 | es''4 es''8 es''16 d''16 ~ d''8. r16 c''16 bes'8. | c''4 c''8 bes'8 ~ bes'8 r8 g'8 f'16 es'16 ~ | es'8. es'16 es'8 es'16 f'16 ~ f'8. r16 g'4 | f'8 es'4. r4 c'8 es'8 | as'2 as'8 g'16 f'8. es'8 | \sectionLabel "Outro" f'2 r4 c'8 es'8 | \time 9/8 as'4. g'16 f'16 f'2 ~ f'8 | \time 4/4 es'1 | R1*1 | R1*1 | R1*1 |
  \bar "|."
}
harmony = \chordmode { es1*2 as1:maj7/es es1*2 es1*1/2 bes1*1/2/d c1:m7 f1*1/2:m es1*1/2 bes1 as1*1/2 bes1*1/2:7/as g1:m7 f1:m bes1 es1*1/2 bes1*1/2/d c1:m f1:m bes1 as1*1/2 bes1*1/2:7/as es1/g f1*1/2:m bes1*1/2:7 es1 es1 c1*1/2:m bes1*1/2 as1*1/2 es1*1/2 c1*1/2:m bes1*1/2 as1*1/2 es1*1/2 c1*1/2:m bes1*1/2 as1 f1:m bes1 f1*1/2:m bes1*5/8 es1*4 }
words = \lyricmode { \skip 1 \skip 1 \skip 1 \skip 1 \skip 1 "Me" -- "sha" "king" "of" "Moab" "was" "a" "sheep" "breed" -- "er" "He" "paid" "the" "king" "of" "Is" -- "rael" "ev" -- \skip 1 "ery" "year" "A" "hun" -- "dred" "thou" -- "sand" "lambs" "was" "the" "trib" -- "ute" "And" "wool" "from" "a" "hun" -- "dred" "thou" -- "sand" "rams" "But" "when" "A" -- "hab" "died" "the" "bond" "was" "bro" -- "ken" "The" "king" "of" "Moab" "re" -- "belled" "a" -- "gainst" "Is" -- "rael" "The" _ "sheep" "breed" -- "er" "stopped" "his" "pay" -- "ment" "And" "the" "sheep" "breed" -- "er" "re" -- "fused" "the" "hea" -- "vy" "load" "The" "trib" -- "ute" "of" "lambs" "was" "no" "lon" -- "ger" "paid" "The" "wool" "of" "the" "rams" "stayed" "in" "his" "fold" _ "He" "re" -- "belled" "a" -- "gainst" "the" "king" "of" "Is" -- "rael" "And" "the" "sheep" "breed" -- "er" "held" "his" "ground" "He" "re" -- "belled" "a" -- "gainst" "the" "king" }
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
