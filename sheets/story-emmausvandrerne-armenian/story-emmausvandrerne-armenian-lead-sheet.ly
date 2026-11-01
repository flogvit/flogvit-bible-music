\version "2.24.0"
\header {
  title = "Stay With Us"
  subtitle = "Luke 24:28–35"
  tagline = ##f
  copyright = \markup \small \wordwrap { "Melody" "and" "chords" "from" "the" "score" "YuE2" "generated" "the" "song" "from" "(score.abc)." "Lyrics" "placed" "syllable" "by" "syllable" "against" "the" "recording" "with" "Whisper," "which" "heard" "95" "of" "96" "words." "All" "13" "lyric" "lines" "sit" "on" "their" "notes." "Bible" "text:" "Open" "Source" "English" "(OSEN)," "CC" "BY" "4.0," "from" "SBLGNT" "and" "tanach.us." }
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
  \clef treble \key c \minor \tempo 4 = 62
  \time 4/4 \sectionLabel "Intro" R1*1 | R1*1 | R1*1 | R1*1 | \sectionLabel "Verse 1" r2 c''8 c''8 es''8 f''8 | g''4 g''8 f''8 es''8 d''8 c''8 bes'8 | c''4 es''8 f''8 g''4 g''8 f''8 | es''8 d''8 c''8 bes'8 c''4 c''4 | r2 c''8 c''8 es''8 f''8 | g''4 g''16 f''16 f''16 r16 es''8 d''8 c''8 bes'8 | c''4 es''8 f''8 g''4 g''16 f''16 r8 | es''8 d''8 c''8 bes'8 c''4 c''4 | \sectionLabel "Chorus" r2 c''4 es''8 f''8 | g''4 g''16 f''16 f''16 r16 es''8 d''8 c''8 bes'8 | c''4 es''8 f''8 g''4 g''16 f''16 f''16 r16 | es''8 d''8 c''8 bes'8 c''4 c''4 | \sectionLabel "Verse 2" r2 c''8 c''16 c''16 es''8 f''8 | g''4 g''8 f''8 es''8 d''16 d''16 c''8 bes'16 bes'16 | c''4 es''8 f''8 g''4 g''16 f''16 r8 | es''8 d''8 c''8 bes'8 c''4 c''4 | r2 c''8 c''8 es''8 f''8 | \sectionLabel "Chorus" g''8 g''8 g''16 f''16 r8 es''8 d''16 d''16 c''8 bes'8 | c''4 es''8 f''8 g''4 g''16 f''16 r8 | es''8 d''8 c''8 bes'8 c''4 c''4 | r2 c''4 es''8 f''8 | g''4 g''16 f''16 r8 es''8 d''8 c''8 bes'8 | c''4 es''8 f''8 g''4 g''16 f''16 r8 | es''8 d''8 c''8 bes'8 c''4 c''4 | \sectionLabel "Outro" r2 c''4 es''8 f''8 | g''2 es''8 d''8 c''8 bes'8 | c''4 es''8 f''8 g''4. f''8 | es''8 d''8 c''8 bes'8 c''4 r4 | \time 2/4 R1*1/2 |
  \bar "|."
}
harmony = \chordmode { s1*3/8 c1*29/8:m c1*8:m c1*4:m c1*5:m c1*7:m c1*9/2:m }
words = \lyricmode { "They" _ _ "drew" "near" "the" "vil" -- "lage" "where" "they" "were" "go" -- "ing" "And" "he" "act" -- "ed" "as" "though" "he" "would" "go" "far" -- \skip 1 "ther" "But" "they" "urged" "him" "strong" -- "ly" \skip 1 \skip 1 "Stay" "with" "us," "for" "it" "is" "eve" -- "ning" \skip 1 \skip 1 \skip 1 \skip 1 \skip 1 \skip 1 "Stay" _ "with" "us," _ "Lord," _ "for" "it" "is" "eve" -- "ning" _ "And" "the" "day" _ "is" \skip 1 "now" "far" "spent" _ _ "He" _ "took" "the" "bread" "and" "blessed" "it" _ "He" "broke" "it" "and" "gave" "it" "to" "them" "Their" "eyes" "were" "ope" -- "ned" "and" "they" "knew" "him" "And" _ "he" "van" -- "ished" "from" "their" "sight" "Stay" _ "with" "us," "Lord," "for" "it" "is" "eve" -- "ning" _ "And" "the" "day" "is" "now" "far" \skip 1 "spent" _ _ _ _ \skip 1 \skip 1 \skip 1 \skip 1 \skip 1 \skip 1 \skip 1 \skip 1 \skip 1 \skip 1 \skip 1 \skip 1 \skip 1 \skip 1 \skip 1 \skip 1 "Would" "not" "our" "hearts" "burn" "with" -- "in" "us" _ _ _ _ _ _ _ _ _ _ }
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
