\version "2.24.0"
\header {
  title = "No More Tears"
  subtitle = "Revelation 21:4"
  tagline = ##f
  copyright = \markup \small \wordwrap { "Melody" "and" "chords" "from" "the" "score" "YuE2" "generated" "the" "song" "from" "(score.abc)." "Lyrics" "placed" "syllable" "by" "syllable" "against" "the" "recording" "with" "Whisper," "which" "heard" "96" "of" "96" "words." "All" "16" "lyric" "lines" "sit" "on" "their" "notes." "Bible" "text:" "Open" "Source" "English" "(OSEN)," "CC" "BY" "4.0," "from" "SBLGNT" "and" "tanach.us." }
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
  \clef treble \key es \major \tempo 4 = 85
  \time 2/4 R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | \sectionLabel "Verse 1" r8 es'8 es'8 f'16 g'16 ~ | g'8 bes'8 bes'8 g'16 bes'16 ~ | bes'8. r8. bes'16 bes'16 ~ | bes'8 g'16 f'16 f'8 es'8 | g'4 r4 | r4. es'8 | es'8 f'16 g'8. bes'16 bes'16 ~ | bes'16 c''8 bes'8. bes'16 bes'16 ~ | bes'8 g'16 f'16 f'8 es'16 es'16 ~ | es'8. r4 r16 | \sectionLabel "Verse 2" r4. bes'8 | bes'8 c''16 es''8. d''16 c''16 ~ | c''16 bes'8 bes'8. bes'8 | bes'8 g'16 f'16 f'8 es'8 | g'4 r4 | r4. es'8 | es'8 f'8 g'8 bes'8 | bes'16 c''8 bes'8. bes'16 bes'16 ~ | bes'8 g'16 f'16 f'8 es'8 | es'4 r4 | \sectionLabel "Verse 3" r4. bes8 | es'4. f'8 | g'4 bes'4 | c''4. bes'8 | g'4 r8 bes'8 | c''4. bes'8 | bes'4 g'4 | f'2 | r4. es'8 | es''4 d''4 | c''4 bes'4 | c''4. bes'8 | g'4 r8 es'8 | as'4 g'4 | f'4. es'8 | es'2 | R1*1/2 | R1*1/2 | \sectionLabel "Verse 4" r4. bes8 | es'8 f'16 g'8. bes'8 | bes'8 c''16 bes'8. bes'8 | bes'8 g'16 f'16 f'8 es'8 | g'4 r4 | r4. es'8 | es'8 f'8 g'8 bes'8 | bes'16 c''8 bes'8. bes'16 bes'16 ~ | bes'16 g'16 g'16 f'16 f'8. es'16 | es'2 | R1*1/2 | R1*1/2 |
  \bar "|."
}
harmony = \chordmode { es1*2 c1*2:m7 as1:maj7 bes1 es1 es1*3/2 bes1*1/2 c1:m7 es1 as1*1/2:maj7 es1*1/2 es1*3/2 bes1*1/2 c1:m7 es1 as1*1/2:maj7 es1*1/2 es1*3/2 as1*1/2:maj7 es1*1/2 as1*1/2:maj7 es1*1/2 bes1 c1:m as1*1/2:maj7 es1*1/2 as1*1/2:maj7 bes1*1/2 es1*3/2 es1*3/2 bes1*1/2 c1:m7 es1 as1*1/2:maj7 es1*3/2 }
words = \lyricmode { "I" "heard" "a" "voice" "come" "from" "the" "throne" "Be" -- "hold," "God" "dwells" "with" "men" _ "He" _ "makes" "his" "home" "a" -- "mong" "his" "own" "And" "they" "are" "his" "a" -- "gain" "He" _ "wipes" "the" "tears" "from" "ev" -- "ery" "eye" "And" "death" "shall" "be" "no" "more" "No" _ "grief," "no" "pain," "no" "mourn" -- "ing" "cry" "Up" -- "on" "that" "shin" -- "ing" "shore" "The" "for" -- "mer" "things" "have" "passed" "a" -- "way" "The" "one" "up" -- "on" "the" "throne" "Says," "I" "make" "all" "things" "new" "to" -- "day" "And" "claims" "us" "as" "his" "own" "So" _ "write" "it" "down," "these" "words" "are" "true" "And" "trust" -- "wor" -- "thy" "and" "sure" "Lord," _ "make" "my" "wea" -- "ry" "spir" -- "it" "new" _ "Till" "I" "am" "home" "se" -- "cure" }
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
