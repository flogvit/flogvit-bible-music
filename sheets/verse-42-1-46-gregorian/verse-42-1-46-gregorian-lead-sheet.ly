\version "2.24.0"
\header {
  title = "Holy Is His Name"
  subtitle = "Luke 1:46–50"
  tagline = ##f
  copyright = \markup \small \wordwrap { "Melody" "and" "chords" "from" "the" "score" "YuE2" "generated" "the" "song" "from" "(score.abc)." "Lyrics" "placed" "syllable" "by" "syllable" "against" "the" "recording" "with" "Whisper," "which" "heard" "59" "of" "59" "words." "8" "of" "10" "lyric" "lines" "sit" "clearly" "on" "their" "notes;" "2" "are" "uncertain" "and" "printed" "in" "grey" "italics." "Bible" "text:" "Open" "Source" "English" "(OSEN)," "CC" "BY" "4.0," "from" "SBLGNT" "and" "tanach.us." }
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
  \time 4/4 R1*1 | R1*1 | R1*1 | R1*1 | \sectionLabel "Verse 1" r2. ais4 | dis'2 eis'8 fis'16 gis'8. eis'8 | dis'4. r4. fis'8 gis'8 | ais'2 gis'4. eis'8 | eis'8 fis'16 eis'16 dis'4 r4 fis'8 gis'8 | ais'2 gis'4. eis'8 | eis'8 fis'16 eis'16 dis'4 r2 | \sectionLabel "Verse 2" r8. dis'16 ais'8 ais'8 gis'8 fis'16 eis'8. cis'8 | dis'8 dis'8 dis'16 eis'16 fis'8 gis'4 eis'8 cis'8 | dis'4 ais'4 gis'4 fis'8 eis'16 eis'16 ~ | eis'8 fis'4 r4 ais8 fis'8 eis'8 | \sectionLabel "Verse 3" eis'4 dis'4 r4. dis'16 dis'16 | ais'8 ais'16 ais'8. ais'8 gis'4 cis''4 | cis''4 fis'16 eis'16 dis'4. r4 | ais'4 cis''4 cis''4 eis'4 | dis'2 r4. dis'8 | ais'4 ais'8 ais'8 gis'4. eis'8 | fis'8 eis'8 eis'8 dis'8 r8 ais8 fis'8 eis'16 eis'16 ~ | eis'8 dis'4. r8 ais8 fis'8 eis'16 eis'16 ~ | eis'8 dis'2. ~ dis'8 ~ | dis'8 r2. r8 |
  \bar "|."
}
harmony = \chordmode { s1*3/4 dis1*3/4:m dis1*5/2:m7 dis1:m7 dis1*2:m fis1*1/2 cis1*1/2 b1 fis1*1/2 cis1*1/2 dis1:m b1*1/2 cis1*1/2 dis1*1/2:m cis1*1/2 b1*1/2 cis1*1/2 dis1:m b1 fis1*1/2 cis1*1/2 b1 fis1*1/2 cis1*1/2 b1 dis1*1/2:m cis1*1/2 b1*4 }
words = \lyricmode { \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "My" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "soul" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "mag" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "ni" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "fies" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "the" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "Lord" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "And" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "my" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "spir" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "it" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "re" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "joic" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "es" _ _ "In" _ "God" "my" "Sav" -- "ior" _ _ _ "For" _ "he" "has" "looked" "up" -- "on" "the" "hum" -- "ble" "state" "of" "his" "ser" -- "vant" "From" "now" "on" "all" "gen" -- "er" -- "a" -- "tions" "Will" "call" "me" "blessed" "For" _ "the" "Mig" -- "hty" "One" "has" "done" "great" "things" "for" "me" "Ho" -- "ly" "is" "his" "name" "His" "mer" -- "cy" "ex" -- "tends" "to" "those" "who" "fear" "him" "From" "gen" -- "er" -- "a" -- "tion" "to" "gen" -- "er" -- "a" -- "tion" }
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
