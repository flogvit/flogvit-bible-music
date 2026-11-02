\version "2.24.0"
\header {
  title = "Have Mercy on Me, O God"
  subtitle = "Psalms 51:3–4"
  tagline = ##f
  copyright = \markup \small \wordwrap { "Melody" "and" "chords" "from" "the" "score" "YuE2" "generated" "the" "song" "from" "(score.abc)." "Lyrics" "placed" "syllable" "by" "syllable" "against" "the" "recording" "with" "Whisper," "which" "heard" "37" "of" "37" "words." "All" "7" "lyric" "lines" "sit" "on" "their" "notes." "Bible" "text:" "Open" "Source" "English" "(OSEN)," "CC" "BY" "4.0," "from" "SBLGNT" "and" "tanach.us." }
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
  \clef treble \key dis \minor \tempo 4 = 68
  \time 4/4 R1*1 | r2 fis'4 eis'8 cis'8 | R1*1 | r2 fis'4 gis'8 eis'8 | R1*1 | R1*1 | R1*1 | R1*1 | \sectionLabel "Verse 1" r2. r8 ais8 | dis'4 eis'8 dis'8 fis'4 eis'8 cis'8 | dis'2 r4. ais8 | dis'8 dis'8 eis'8 dis'8 fis'4 gis'8 eis'8 | dis'2 r2 | \sectionLabel "Verse 2" ais'4 ais'4 ais'4. ais'8 | gis'4 eis'4 r2 | fis'4 fis'4 gis'4. fis'8 | eis'16 fis'16 dis'4. r2 | \sectionLabel "Verse 3" dis'4 dis'4 eis'16 fis'16 eis'8 dis'8 cis'8 | dis'2 r4. ais8 | dis'4 dis'4 eis'8 dis'8 cis'8 dis'8 | \sectionLabel "Outro" dis'2 r4. ais8 | dis'4 eis'8 dis'8 fis'4 eis'8 cis'8 | dis'1 | R1*1 |
  \bar "|."
}
harmony = \chordmode { s1*3/4 dis1*21/4:m cis1 b1 dis1*3:m b1*3/4:maj7/dis cis1*1/4 dis1:m dis1:m cis1 b1 dis1:m b1*1/2 cis1*1/2 dis1:m b1*1/2 cis1*1/2 dis1*4:m }
words = \lyricmode { \skip 1 \skip 1 \skip 1 \skip 1 \skip 1 \skip 1 "Have" "mer" -- "cy" _ "on" "me," "O" "God" "Ac" -- "cord" -- "ing" _ "to" "your" "stead" -- "fast" "love" "In" "your" "great" "com" -- "pas" -- "sion" "Blot" "out" "my" "trans" -- "gres" -- "sions" _ "Wash" "me" "thor" -- "ough" -- "ly" "from" "my" "guilt" "And" "cleanse" "me" "from" "my" "sin" _ _ "Have" "mer" -- "cy" "on" "me," "O" "God" _ }
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
