\version "2.24.0"
\header {
  title = "Is It Nothing to You"
  subtitle = "Lamentations 1:12"
  tagline = ##f
  copyright = \markup \small \wordwrap { "Melody" "and" "chords" "from" "the" "score" "YuE2" "generated" "the" "song" "from" "(score.abc)." "Lyrics" "placed" "syllable" "by" "syllable" "against" "the" "recording" "with" "Whisper," "which" "heard" "47" "of" "47" "words." "6" "of" "7" "lyric" "lines" "sit" "clearly" "on" "their" "notes;" "1" "are" "uncertain" "and" "printed" "in" "grey" "italics." "Bible" "text:" "Open" "Source" "English" "(OSEN)," "CC" "BY" "4.0," "from" "SBLGNT" "and" "tanach.us." }
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
  \clef treble \key dis \minor \tempo 4 = 75
  \time 3/4 \sectionLabel "Intro" R1*3/4 | R1*3/4 | R1*3/4 | r2 dis''8 eis''8 | \sectionLabel "Verse 1" fis''4 ais''4 fis''8 gis''8 ~ | gis''8 r4. eis''4 | fis''4 ais''4 fis''8 eis''8 | eis''4 r4 dis''8 cis''8 | dis''4 ais''2 ~ | ais''4 r2 | \sectionLabel "Verse 2" ais''8 ais''8 dis'''8 cis'''8 ais''16 gis''16 fis''8 | gis''4 gis''8 ais''8 fis''16 eis''16 dis''8 ~ | dis''4 r4 ais''8 ais''8 | dis'''8 cis'''8 ais''16 gis''16 fis''8 gis''4 | gis''8 ais''8 fis''16 eis''16 dis''4. ~ | dis''8 r2 r8 | \sectionLabel "Verse 3" r4 dis''8 eis''8 fis''4 | ais''4 fis''8 gis''8 ~ gis''4 | r4 eis''4 fis''4 | ais''4 fis''8 eis''8 eis''4 | r4 dis''8 cis''8 dis''4 | \time 7/8 ais''2. ~ ais''8 ~ | \time 3/4 ais''2 r4 | \sectionLabel "Outro" ais''8 ais''8 dis'''8 cis'''8 ais''16 gis''16 fis''8 | gis''4 gis''8 ais''8 fis''16 eis''16 dis''8 ~ | dis''4. r4. | R1*3/4 |
  \bar "|."
}
harmony = \chordmode { dis1*3:m dis1*3/4:m cis1*3/4 b1*3/4 ais1*3/4:m dis1*3/2:m dis1*1/2:m cis1*3/4 b1*3/4 dis1*1/2:m cis1*3/4 b1*5/4:maj7 b1*1/2:maj7 dis1*3/4:m cis1*3/4 b1*3/4 ais1*3/4:m dis1*15/8:m dis1*1/2:m cis1*3/4 b1*7/4:maj7 }
words = \lyricmode { \skip 1 \skip 1 "Is" "it" "noth" -- "ing" "to" "you," "all" "you" "who" "pass" "by" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "Look" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "and" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "see" \skip 1 \skip 1 \skip 1 \skip 1 \skip 1 "Is" "there" "a" -- "ny" "suf" -- "fering" "like" "my" "suf" -- "fering" _ "Is" "there" "a" -- "ny" "suf" -- "fering" "like" "my" "suf" -- "fering" "Is" "it" "noth" -- "ing" "to" "you," "all" "you" "who" "pass" "by" _ "Look" "and" "see" _ "Is" _ "there" "a" -- "ny" "suf" -- "fering" "like" "my" "suf" -- "fering" _ _ }
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
