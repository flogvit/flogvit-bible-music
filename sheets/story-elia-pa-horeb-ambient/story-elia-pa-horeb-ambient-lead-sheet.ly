\version "2.24.0"
\header {
  title = "A Low Whisper"
  subtitle = "1 Kings 19:9–13"
  tagline = ##f
  copyright = \markup \small \wordwrap { "Melody" "and" "chords" "from" "the" "score" "YuE2" "generated" "the" "song" "from" "(score.abc)." "Lyrics" "placed" "syllable" "by" "syllable" "against" "the" "recording" "with" "Whisper," "which" "heard" "81" "of" "84" "words." "All" "13" "lyric" "lines" "sit" "on" "their" "notes." "Bible" "text:" "Open" "Source" "English" "(OSEN)," "CC" "BY" "4.0," "from" "SBLGNT" "and" "tanach.us." }
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
  \clef treble \key dis \minor \tempo 4 = 70
  \time 4/4 \sectionLabel "Intro" R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | \sectionLabel "Verse 1" dis''8 dis''8 dis''8 dis''4 cis''8 ais'8 ais'8 ~ | ais'8 r4 ais'8 ais'8. gis'8. ais'8 ~ | ais'8 r2. r8 | r2. ais'8 cis''8 | dis''4. dis''8 dis''8. cis''8. ais'8 ~ | ais'8 r4 r16 ais'16 ais'8 cis''4 cis''8 ~ | cis''8 gis'4 r4 ais'4 gis'16 gis'16 ~ | gis'8 fis'4 r4. dis'8 fis'8 | gis'4 ais'8 gis'4 fis'8 eis'8 dis'8 ~ | dis'8 r2. r8 | R1*1 | \sectionLabel "Verse 2" r2 ais''8 gis''8 fis''8 gis''8 ~ | gis''4 fis''8 gis''4 ais''4 r8 | r4. fis''16 fis''16 gis''4 fis''8 gis''8 ~ | gis''8 fis''8 eis''8 eis''4 dis''4 r8 | r2 ais''8 gis''8 fis''8 gis''8 ~ | gis''8 gis''8 fis''8 gis''4 ais''4 r8 | r4. fis''16 fis''16 gis''4 fis''8 gis''8 ~ | gis''8 fis''8 eis''8 eis''4 dis''4 r8 | \sectionLabel "Chorus" r4. dis''8 ais''8 gis''8 fis''8 gis''8 ~ | gis''8 ais''2. ~ ais''8 ~ | ais''8 r4 fis''8 ais''4 gis''16 fis''16 gis''8 ~ | gis''4. fis''4 eis''4 r8 | r4. dis''8 ais''8 gis''8 fis''8 gis''8 ~ | gis''8 ais''2. ~ ais''8 ~ | ais''8 r4 fis''8 ais''4 gis''16 fis''16 gis''8 ~ | gis''4. fis''4 eis''4 r8 | R1*1 | \sectionLabel "Outro" r2 dis''8 eis''8 fis''8 gis''8 ~ | gis''8 ais''4 eis''4 r4. | r4. dis''8 eis''4 dis''4 | R1*1 | R1*1 |
  \bar "|."
}
harmony = \chordmode { dis1*8:m dis1:m fis1 dis1*3:m fis1 cis1 b1 gis1:m dis1*2:m dis1:m fis1 cis1 b1 dis1:m fis1 cis1 b1 b1 dis1:m fis1 cis1 b1 dis1:m fis1 cis1 b1 dis1:m fis1 cis1 b1*2 }
words = \lyricmode { "Go" "out" "and" "stand" "on" "the" "mount" "be" -- "fore" "the" "Lord" "And" "be" -- "hold," "the" "Lord" "passed" "by" "A" "great" "and" "strong" "wind" "tore" "the" "moun" -- "tains" "But" "the" "Lord" "was" "not" "in" "the" "wind" "Af" -- "ter" "the" "wind" "an" "earth" -- "quake" "But" "the" "Lord" "was" "not" "in" "the" "earth" -- "quake" "Af" -- "ter" _ "the" "earth" -- "quake" "a" "fire" "But" _ "the" "Lord" "was" "not" "in" "the" "fire" "And" _ "af" -- "ter" "the" "fire" "The" "sound" "of" "a" "low" "whis" -- "per" "And" _ "af" -- "ter" "the" "fire" "The" "sound" "of" "a" "low" "whis" -- "per" "What" "are" "you" "do" -- "ing" "here," "E" -- "li" -- "jah" }
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
