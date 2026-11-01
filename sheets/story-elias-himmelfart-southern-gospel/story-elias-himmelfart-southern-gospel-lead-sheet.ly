\version "2.24.0"
\header {
  title = "Chariot of Fire"
  subtitle = "2 Kings 2:9–12"
  tagline = ##f
  copyright = \markup \small \wordwrap { "Melody" "and" "chords" "from" "the" "score" "YuE2" "generated" "the" "song" "from" "(score.abc)." "Lyrics" "placed" "syllable" "by" "syllable" "against" "the" "recording" "with" "Whisper," "which" "heard" "150" "of" "153" "words." "17" "of" "18" "lyric" "lines" "sit" "clearly" "on" "their" "notes;" "1" "are" "uncertain" "and" "printed" "in" "grey" "italics." "Bible" "text:" "Open" "Source" "English" "(OSEN)," "CC" "BY" "4.0," "from" "SBLGNT" "and" "tanach.us." }
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
  \clef treble \key as \major \tempo 4 = 119
  \time 4/4 R1*1 | R1*1 | R1*1 | R1*1 | \sectionLabel "Verse 1" r2. r8 es'8 | es'4 es'8 es'4. f'8 es'16 es'16 | as'4 as'4 r4 as'8. bes'16 | c''4 bes'8 as'16 r16 as'4 f'4 | es'2 r2 | es'8 es'4. es'8 f'8 f'16 r16 es'8 | as'4 c''4 bes'8. as'16 as'8 f'16 f'16 | bes'4. bes'16 bes'16 c''4 c''8 bes'16 bes'16 | bes'2 r4. es'8 | c''8 es''8 es''8 c''8 es''4 c''8 es''8 ~ | es''4 c''8 as'4 r8 as'8 bes'8 | c''4 bes'8 as'8 as'4 f'8 es'8 ~ | es'4. r2 r8 | es'8 es'4 es'4 es'8 f'8 es'8 | as'4 c''4 r4 as'8. f'16 | bes'4. bes'8 c''4 bes'8 as'8 | as'2 r2 | \sectionLabel "Chorus" c''2 c''4 r4 | c''8 bes'8 c''8 bes'16 bes'16 as'4 c''4 | des''4 des''8 des''16 des''16 des''4 des''4 | des''8. c''16 des''8 bes'16 bes'16 as'4 c''8 r8 | c''4 c''8. bes'16 c''4 c''8 r8 | c''4 c''8. bes'16 as'4 r8. f'16 | bes'8. bes'16 bes'4 bes'4 bes'8. bes'16 | \time 2/4 c''8. es''16 c''8 bes'8 | \time 4/4 as'2 r2 | R1*1 | \sectionLabel "Verse 2" es'8 es'4 es'4 es'8 f'8 es'16 es'16 | as'4 r2 r8 bes'8 | c''4 bes'8 as'4. f'8 es'8 ~ | es'4. r2 c'8 | c'8 c'8 es'4 es'4 f'8 as'8 ~ | as'4 c''4 r4. as'8 | bes'8 bes'16 bes'16 bes'4 c''4 c''8 bes'8 | bes'2 r4. as'8 | c''4 es''4 es''4 es''4 | es''4 c''8 as'4 r8 as'8 bes'8 | c''4 bes'8 as'4. f'8 es'8 ~ | es'4. r2 r8 | c'8 es'4 es'4. f'8 es'16 es'16 | as'4 c''4 r4 as'8. as'16 | bes'4 bes'4 c''4 bes'8 as'8 ~ | as'4. r2 r8 | \sectionLabel "Chorus" c''2 c''4 r4 | c''8 bes'16 bes'16 c''8 bes'16 bes'16 as'4 c''4 | des''4 des''8. des''16 des''4 des''4 | des''8 c''8 des''8 bes'8 as'4 c''8 r8 | c''4 c''8. bes'16 c''4 c''4 | c''4 c''8. bes'16 as'4 r8. as'16 | bes'8. bes'16 bes'4 bes'4 bes'8. bes'16 | \time 2/4 c''8 es''8 c''8 bes'8 | \time 4/4 \sectionLabel "Outro" as'2 r2 | r4. r16 as'16 c''8. es''16 c''4 | as'2 r2 | r4. as'8 c''8. es''16 c''4 | as'2 r2 | R1*1 |
  \bar "|."
}
harmony = \chordmode { s1*1 as1*3 as1*3 des1 as1*3 es1*2:7 as1*2 des1 as1*3 es1:7 as1 as1*2 des1*2 as1*2 es1*3/2:7 as1*2 as1*2 des1 as1*3 es1*2:7 as1*2 des1 as1*3 es1:7 as1 as1*2 des1*2 as1*2 es1*3/2:7 as1*6 }
words = \lyricmode { "E" -- _ "li" -- "jah" "walked" "with" "E" -- "lis" -- "ha" \skip 1 "by" "the" "riv" -- "er" "Jor" -- "dan's" "side" "Ask" _ "me" "what" _ "you" "want," _ "my" "son," _ "be" -- "fore" "I" "cross" "the" "great" "di" -- "vide" _ _ "E" -- "lis" -- "ha" _ "said" "a" "dou" -- "ble" "por" -- "tion" \skip 1 "of" "your" "spir" -- "it" "let" "it" "be" "If" _ "you" "see" "me" "when" "I'm" "tak" -- "en," "it" "will" "come" "to" "you," "said" "he" "Swing" "low," \skip 1 "char" -- "i" -- "ot" "of" "fire" _ _ _ _ "Hors" -- "es" "of" "fire," "car" -- "ry" "him" "high" -- "er" _ "Up" "in" "a" "whirl" -- "wind," "gone" "in" "a" "flash" "E" -- _ "li" -- "jah" "went" "home" "and" "he" "ne" -- "ver" "looked" "back" "As" "they" "walked" "a" -- "long" "and" "talked," "the" \skip 1 "sky" "be" -- "gan" "to" "burn" "A" "char" -- "i" -- "ot" "came" "be" -- "tween" "them" \skip 1 "and" "there" _ "would" "be" "no" "re" -- "turn" "My" _ "fa" -- "ther," "oh" "my" "fa" -- "ther," "cried" "E" -- "lis" -- "ha" "on" "the" "ground" "And" _ "he" "picked" "up" "the" "man" -- "tle" "that" "came" "float" -- "ing" "soft" -- "ly" "down" "Swing" "low," \skip 1 "char" -- "i" -- "ot" "of" "fire" _ _ _ "Hors" -- "es" "of" "fire," _ "car" -- "ry" "him" "high" -- "er" "Up" "in" "a" "whirl" -- "wind," "gone" "in" "a" "flash" "E" -- "li" -- "jah" "went" "home" "and" "he" "ne" -- "ver" "looked" "back" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "He" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "ne" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "ver" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "looked" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "back" "No," "he" "ne" -- "ver" "looked" "back" }
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
