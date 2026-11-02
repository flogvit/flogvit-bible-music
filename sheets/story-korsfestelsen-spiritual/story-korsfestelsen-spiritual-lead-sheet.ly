\version "2.24.0"
\header {
  title = "They Nailed Him to the Tree"
  subtitle = "Luke 23:33–34; 23:44–46"
  tagline = ##f
  copyright = \markup \small \wordwrap { "Melody" "and" "chords" "from" "the" "score" "YuE2" "generated" "the" "song" "from" "(score.abc)." "Lyrics" "placed" "syllable" "by" "syllable" "against" "the" "recording" "with" "Whisper," "which" "heard" "102" "of" "102" "words." "23" "of" "24" "lyric" "lines" "sit" "clearly" "on" "their" "notes;" "1" "are" "uncertain" "and" "printed" "in" "grey" "italics." "Bible" "text:" "Open" "Source" "English" "(OSEN)," "CC" "BY" "4.0," "from" "SBLGNT" "and" "tanach.us." }
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
  \clef treble \key c \minor \tempo 4 = 72
  \time 4/4 \sectionLabel "Verse 1" r2 r8 c'8 es'8 f'8 | g'4 r8 f'16 es'16 f'4 es'8 c'8 | r2. bes8 c'8 | c'4 r2 r8. c'16 | c'4 g'4 f'4 es'8 g'8 ~ | g'4. r4. bes'8 c''8 | c''4 r2. | c''8. c''8. c''8 bes'8. f'8. f'8 | g'4 f'16 es'16 c'8 c'4 r8. bes16 | c'4 g'4 f'4 es'16 d'16 c'8 ~ | c'8 r2 r8 bes8 c'8 | \sectionLabel "Chorus" c'4 r4. c''8 c''8 bes'16 g'16 | c''4 c''4 bes'4 f'8 r8 | r4 es'16 f'8. g'8. f'8. es'16 c'16 | c'4 r4. c''8 c''8 bes'16 g'16 | c''4 c''8. bes'16 bes'4 f'8 r8 | r4 es'16 f'8. g'8. f'8. es'16 c'16 | \sectionLabel "Verse 2" c'4 r2 r8. c'16 | c'4 g'4 f'4 es'8 g'8 ~ | g'4 r2 bes'8 c''8 | c''4 r2 r8. bes16 | c'4 g'4 f'4 es'8 g'8 ~ | g'4 r2 bes'8 c''8 | c''4 r2. | c''8. c''8. c''8 bes'4 f'8 g'8 ~ | g'4 f'16 es'16 c'8 c'4 r8. bes16 | c'4 g'4 f'4 es'8 c'8 ~ | c'8 r2 r8 bes8 c'8 | \sectionLabel "Chorus" c'4 r4. c''8 c''8 bes'16 g'16 | c''4 c''8. bes'16 bes'4 f'8 r8 | r4 es'16 f'8. g'8. f'8. es'8 | c'4 r4. c''8 c''8 bes'16 g'16 | c''4 c''8. bes'16 bes'4 f'8 r8 | r4 es'16 f'8. g'8. f'8. es'8 | c'4 r2. | R1*1 |
  \bar "|."
}
harmony = \chordmode { s1*7/8 c1*5/8:m bes1*1/2 c1*5/2:m bes1*1/2 es1 c1:m as1*1/2 bes1*1/2 c1:m as1*1/2 bes1*1/2 c1:m c1:m as1*1/2 bes1*3/2 c1:m as1*1/2 bes1*3/2 c1*3/2:m bes1*1/2 es1 c1:m as1*1/2 bes1*1/2 es1 c1:m as1*1/2 bes1*1/2 c1:m as1*1/2 bes1*1/2 c1:m c1:m as1*1/2 bes1*3/2 c1:m as1*1/2 bes1*3/2 c1*2:m }
words = \lyricmode { "They" _ "led" "him" "up" "to" "Cal" -- "va" -- "ry" "Oh," "Lord" _ "They" "nailed" "him" "to" "the" "tree" "Oh," "Lord" _ "Fa" -- "ther," "for" -- "give" _ "them," "he" "said" _ "Oh," "Lord" "They" _ "know" "not" "what" "they" "do" "Oh," "Lord" _ "It" _ "makes" "me" "trem" -- "ble," "trem" -- "ble" "When" _ "I" "think" "how" "he" "died" "It" _ _ "makes" "me" "trem" -- "ble," "trem" -- "ble" "When" _ "I" "think" "how" "he" "died" "The" "sun" "re" -- "fused" "to" "shine" "Oh," "Lord" _ "The" "tem" -- "ple" "cur" -- "tain" "tore" "Oh," "Lord" _ "In" -- "to" "your" "hands," "he" "cried" "Oh," "Lord" _ _ "I" "give" "my" "spir" -- "it," "Lord" "Oh," "Lord" _ \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "It" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "makes" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "me" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "trem" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "ble," \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "trem" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "ble" _ _ "When" "I" "think" "how" "he" "died" "It" "makes" "me" "trem" -- "ble," "trem" -- "ble" _ _ "When" "I" "think" "how" "he" "died" }
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
