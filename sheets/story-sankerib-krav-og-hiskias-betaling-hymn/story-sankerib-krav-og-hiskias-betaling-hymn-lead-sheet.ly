\version "2.24.0"
\header {
  title = "Stripped of Gold"
  subtitle = "2 Kings 18:13–16"
  tagline = ##f
  copyright = \markup \small \wordwrap { "Melody" "and" "chords" "from" "the" "score" "YuE2" "generated" "the" "song" "from" "(score.abc)." "Lyrics" "placed" "syllable" "by" "syllable" "against" "the" "recording" "with" "Whisper," "which" "heard" "99" "of" "102" "words." "16" "of" "17" "lyric" "lines" "sit" "clearly" "on" "their" "notes;" "1" "are" "uncertain" "and" "printed" "in" "grey" "italics." "Bible" "text:" "Open" "Source" "English" "(OSEN)," "CC" "BY" "4.0," "from" "SBLGNT" "and" "tanach.us." }
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
  \clef treble \key d \minor \tempo 4 = 72
  \time 4/4 R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | \sectionLabel "Verse 1" r2 r8 a8 d'8 e'8 | f'8 e'4 g'4. f'4 | d'4 r2 r8 a8 | d'8 e'16 f'8. g'8 ~ g'4 a'8 a'8 ~ | a'4 r2 a'8 c''8 | d''8 d''4 d''16 c''16 ~ c''8. r16 g'8 a'8 ~ | a'4 r4. d'8 d'8 e'16 f'16 ~ | f'8 g'4. e'16 c'4 r16 d'8 ~ | \sectionLabel "Verse 2" d'4 r2 r8 a8 | d'8 e'8 f'8 e'16 g'16 ~ g'8. r16 f'8 d'8 ~ | d'8 r2 r8 d'16 e'8. | f'4 a'8 g'8 ~ g'4 a'8 a'8 ~ | a'4 r2 r8 a'8 | d''4 d''8 c''8 ~ c''8 g'8 a'8 a'8 ~ | a'4 r2 r8. d'16 | d'16 f'16 f'4 g'16 e'16 ~ e'8. r16 c'8 d'8 ~ | d'4. r2 r8 | \sectionLabel "Verse 3" r8 d''8 d''8 d''8 e''16 e''4 r16 c''8 | c''8. d''8. a'4 r4 a'16 c''16 | d''16 d''8. d''8 e''8 ~ e''4 c''8 c''8 | c''4 d''8 d''4 r4. | r8 d''8 d''8. d''16 e''8 e''16 e''8. c''8 | a'4. r2 r16 a16 | d'4 f'8 g'16 e'16 ~ e'8. r16 e'16 d'16 c'16 d'16 ~ | d'8 d'4. r2 | R1*1 | \sectionLabel "Interlude" R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | \sectionLabel "Verse 4" r8 d'8 d'16 d'8. e'16 e'16 e'4 c'8 | a4 r2. | r4 d'16 d'8 e'16 ~ e'8. r16 e'16 c'8 d'16 | d'4 r2 r8. a16 | d'4 d'8 d'16 e'16 ~ e'16 e'8. e'8 c'8 | a4 r2 r8. a16 | d'4. f'8 e'4 c'8 d'8 ~ | d'4. r2 r8 | \time 2/4 \sectionLabel "Outro" r8 d'8 d'8 d'16 e'16 | \time 4/4 e'4. e'8 c'4 d'8 e'8 | e'8 d'16 d'16 r2. | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 |
  \bar "|."
}
harmony = \chordmode { s1*7/8 d1*57/8:m d1*7/2:m c1*1/2 f1 bes1*1/2 c1*1/2 d1:m bes1*1/2 c1*1/2 d1*3/2:m c1*1/2 d1:m bes1*1/2 c1*1/2 f1 bes1*1/2 c1*1/2 d1:m bes1*1/2 c1*1/2 d1:m d1*1/2:m c1*1/2 d1:m bes1*1/2 c1*1/2 d1:m bes1*1/2 c1*1/2 d1:m bes1*1/2 c1*1/2 d1*2:m bes1*1/2 c1*1/2 d1:m bes1*1/2 c1*1/2 d1:m bes1*1/2 c1*1/2 d1:m bes1*1/2 c1*1/2 d1:m bes1*1/2 c1*1/2 d1:m bes1*1/2 c1*1/2 d1:m bes1*1/2 c1*1/2 d1:m bes1*1/2 c1*1/2 d1:m bes1*1/2 c1 d1*6:m }
words = \lyricmode { "In" "He" -- "ze" -- "kiah's" "four" -- "teenth" "year," "The" "As" -- "syr" -- "i" -- "an" "king" "drew" "near." "Sen" -- "nac" -- "he" -- "rib" "at" -- "tacked" "the" "land," \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "He" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "took" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "the" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "stron" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "gholds" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "in" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "his" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "hand." "From" "Lac" -- "hish" "He" -- "ze" -- "kiah" "spoke," _ "\"I" "have" "sinned," "my" "sins" "I" "broke.\"" "\"With" -- "draw" "from" "me," "I" "will" "pay," "What" -- "ev" -- "er" "you" "de" -- "mand" "to" -- "day.\"" "Three" "hun" -- "dred" "tal" -- "ents" "of" "sil" -- "ver" "stood," "Thir" -- "ty" "tal" -- "ents" "of" "gold" "ad" -- "ded" "to" "the" "wood." "He" "gave" "the" "sil" -- "ver" "found" "in" -- "side," "The" _ "house" "of" "the" "Lord," "side" "by" "side." _ "From" "pa" -- "lace" "trea" -- "su" -- "ries" "he" "drew," "Ev" -- "ery" "coin" "that" "he" "knew." _ "The" "doors" "of" "the" "tem" -- "ple" "he" "stripped" "bare," "The" "gold" "he" "gave" "him" "there." "He" _ "gave" "the" "doors" "to" "the" "king" "of" "As" -- "syr" -- "ia." }
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
