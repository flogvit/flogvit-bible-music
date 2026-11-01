\version "2.24.0"
\header {
  title = "Valley of the Shadow"
  subtitle = "Psalm 23"
  tagline = ##f
  copyright = \markup \small \wordwrap { "Melody" "and" "chords" "from" "the" "score" "YuE2" "generated" "the" "song" "from" "(score.abc)." "Lyrics" "placed" "syllable" "by" "syllable" "against" "the" "recording" "with" "Whisper," "which" "heard" "122" "of" "125" "words." "All" "17" "lyric" "lines" "sit" "on" "their" "notes." "Bible" "text:" "Open" "Source" "English" "(OSEN)," "CC" "BY" "4.0," "from" "SBLGNT" "and" "tanach.us." }
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
  \clef treble \key bes \major \tempo 4 = 84
  \time 3/4 R1*3/4 | R1*3/4 | R1*3/4 | R1*3/4 | \sectionLabel "Verse 1" r4 bes8 bes8 d'16 f'8. | f'16 g'8. r2 | r4 f'4 d'8 c'8 | d'4 r2 | r4 bes8 bes8 d'16 f'8. | g'2 g'16 a'8. | g'16 f'16 f'16 f'8. r4 bes8 | g'8 bes'8 bes'16 bes'8. g'16 g'8. | g'16 f'16 f'8 r4 d'8 f'8 | g'4. f'16 r16 f'4 | d'16 c'16 bes4 r4. | \sectionLabel "Chorus" r2 d''8 f''8 | f''2 d''8 c''16 c''16 ~ | c''8 bes'4. bes'8 g'16 g'16 ~ | g'8 f'4 r4. | r2 d''8 f''8 | f''2 d''4 | c''8 bes'8. bes'16 bes'16 c''8 d''8. | d''8 c''4 r4. | r2 r8 bes'8 | bes'4 bes'8 c''4 bes'8 ~ | bes'8 r8 g'8 g'16 f'16 f'16 f'8. | f'16 es'16 d'8 r2 | r2 d'8 f'16 g'16 ~ | g'4 ~ g'16 r16 f'8 f'4 ~ | f'2 d'8 c'16 c'16 ~ | c'8 bes4 r4. | R1*3/4 | \sectionLabel "Verse 2" r4 bes8 bes16 d'8. f'8 | f'8 g'2 f'16 f'16 ~ | f'8 d'4 r4. | r2 bes8 bes16 d'16 ~ | d'8 f'4. f'8 f'8 | g'2 d'8 d'16 c'16 | bes4 r2 | r2 d'8 f'16 g'16 ~ | g'8 bes'4 bes'4 g'16 g'16 ~ | g'16 f'16 f'4 r4 bes8 | g'4 r4 d'8 c'16 bes16 ~ | bes8. r2 r16 | \sectionLabel "Chorus" r2 d''8 f''8 | f''2 d''8 c''16 c''16 ~ | c''8 bes'4. bes'8 g'16 g'16 ~ | g'8 f'4 r4. | r2 d''8 f''8 | f''2 d''4 | c''8 bes'8. bes'16 bes'16 c''8 d''8. | d''8 c''4 r4. | r2 r8 bes'8 | bes'4 bes'8 c''4 bes'8 ~ | bes'8 r8 g'8 g'16 f'16 f'16 f'8. | f'16 es'16 d'8 r2 | r2 d'8 f'16 g'16 ~ | g'4 ~ g'16 r16 f'16 f'16 f'4 ~ | f'2 d'8 c'16 c'16 ~ | c'8 bes4 r4. | \sectionLabel "Outro" r2 d'8 f'8 | g'2 g'8 a'16 g'16 | f'2 d'8 f'16 g'16 | g'2 r8 a'16 g'16 | f'2 r8 d'16 c'16 ~ | \sectionLabel "Outro" c'8 bes4 r4. | R1*3/4 | R1*3/4 | R1*3/4 | R1*3/4 |
  \bar "|."
}
harmony = \chordmode { s1*5/8 bes1*19/8 bes1*15/4 g1*3/4:m es1*3/2 bes1*3/4 f1*3/4 bes1*3/4 bes1*3/2 es1*3/4 bes1*9/4 es1*3/4 f1*3/2 g1*3/4:m es1*3/4 bes1*3/2 es1*3/4 f1*3/4 bes1*3/2 bes1*3/4 es1*3/4 bes1*9/4 g1*3/4:m es1*9/4 bes1*3/4 f1*3/4 bes1*3/4 bes1*3/2 es1*3/4 bes1*9/4 es1*3/4 f1*3/2 g1*3/4:m es1*3/4 bes1*3/2 es1*3/4 f1*3/4 bes1*3/4 bes1*3/4 es1*3/4 bes1*3/4 es1*3/4 f1*3/4 bes1*15/4 }
words = \lyricmode { "The" "Lord" "is" "my" "shep" -- "herd," "I" "shall" "not" "want" "He" _ "makes" "me" "lie" "down" "in" "green" "pas" -- "tures" _ "He" _ "leads" "me" "be" -- "side" "the" "still" "wa" -- "ters" "He" _ "re" -- "stores" "my" "soul" _ _ "Though" "I" "walk" "through" "the" "val" -- "ley" "of" "the" "shad" -- "ow" "I" _ "will" "fear" "no" "e" -- "vil," "for" "you" "are" "with" "me" "Your" _ "rod" "and" "your" \skip 1 "staff," "they" "com" -- "fort" "me" _ _ "In" _ "the" "val" -- "ley" "of" "the" "shad" -- "ow" "You" "pre" -- "pare" "a" "ta" -- "ble" "be" -- "fore" "me" "In" _ "the" "pre" -- "sence" "of" "my" "en" -- "e" -- "mies" _ "You" _ "a" -- "noint" "my" "head" "with" "oil" _ "My" "cup" "o" -- "ver" -- "flows" "Though" "I" "walk" "through" "the" "val" -- "ley" "of" "the" "shad" -- "ow" "I" "will" "fear" "no" _ "e" -- "vil," "for" "you" "are" "with" "me" "Your" _ "rod" "and" "your" \skip 1 "staff," "they" "com" -- "fort" "me" _ _ "In" _ "the" "val" -- "ley" "of" "the" "shad" -- "ow" _ "I" _ "will" "dwell" "in" "the" "house" "of" "the" "Lord" "for" -- "ev" -- "er" _ \skip 1 \skip 1 \skip 1 }
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
