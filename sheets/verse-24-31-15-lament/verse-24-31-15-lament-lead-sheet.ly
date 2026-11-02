\version "2.24.0"
\header {
  title = "Rachel Weeping"
  subtitle = "Jeremiah 31:15"
  tagline = ##f
  copyright = \markup \small \wordwrap { "Melody" "and" "chords" "from" "the" "score" "YuE2" "generated" "the" "song" "from" "(score.abc)." "Lyrics" "placed" "syllable" "by" "syllable" "against" "the" "recording" "with" "Whisper," "which" "heard" "67" "of" "68" "words." "All" "13" "lyric" "lines" "sit" "on" "their" "notes." "Bible" "text:" "Open" "Source" "English" "(OSEN)," "CC" "BY" "4.0," "from" "SBLGNT" "and" "tanach.us." }
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
  \clef treble \key dis \minor \tempo 4 = 60
  \time 4/4 \sectionLabel "Verse 1" r2 r8 ais'8 dis''8 eis''8 | fis''4 eis''4 cis''8 dis''4. ~ | dis''8 r2 ais'8 dis''8 eis''8 | fis''4 eis''4 cis''8 dis''4 r8 | r4. ais''16 ais''16 ais''8 gis''16 fis''16 eis''16 fis''16 eis''8 | eis''8 dis''4. r2 | gis''8 fis''16 eis''8. dis''8 cis''8 dis''8 eis''8. cis''16 | \sectionLabel "Chorus" cis''8 dis''4 r4 r16 ais'16 dis''16 eis''16 fis''8 | eis''4 dis''4 r8. ais'16 dis''16 eis''16 fis''8 | eis''4 fis''4. r4. | \sectionLabel "Verse 2" ais''4 gis''8 fis''8 eis''8 dis''8 r8 dis''8 | ais''4 gis''8 fis''8 eis''8. dis''16 cis''8 dis''8 | eis''8. dis''16 dis''4 r4 dis''8 ais''8 | ais''4 gis''4 eis''8 dis''4 r8 | dis''8 ais''8 gis''8 fis''8 eis''4 cis''4 | \time 3/8 cis''4 r8 | \time 4/4 \sectionLabel "Chorus" r2 r8. ais'16 dis''16 eis''16 fis''8 | eis''4 dis''4 r8. ais'16 dis''16 eis''16 fis''8 | \sectionLabel "Outro" eis''4 fis''4. r8 dis''16 eis''16 fis''8 | eis''4 dis''4 cis''8 dis''8 eis''8. cis''16 | cis''8 dis''2 r4. | R1*1 |
  \bar "|."
}
harmony = \chordmode { dis1*5:m b1 gis1*1/2:m ais1*1/2:m dis1:m b1 cis1*1/4 dis1*3/4:m dis1:m b1*1/2 cis1*1/2 dis1:m b1*1/2 cis1*1/2 gis1*1/2:m ais1*7/8:m ais1:m b1 cis1*1/4 dis1*3/4:m b1*1/2 cis1*1/2 dis1*2:m }
words = \lyricmode { "A" "voice" "is" "heard" "in" "Ra" -- "mah" "La" -- "men" -- "ta" -- "tion" "and" "bit" -- "ter" "weep" -- "ing" "Rac" -- "hel" "is" "weep" -- "ing" "for" "her" "chil" -- "dren" "She" "re" -- "fus" -- "es" "to" "be" "com" -- "fort" -- "ed" "Be" -- "cause" "they" "are" "no" "more" "Be" -- "cause" "they" "are" "no" "more" "He" -- "rod" "was" "fu" -- "ri" -- "ous" "He" "sent" "and" "killed" "all" "the" "boys" "in" "Beth" -- "le" -- "hem" "And" "in" "all" "that" "re" -- "gion" "Two" "years" "old" "and" "un" -- "der" "Be" -- "cause" "they" "are" "no" "more" "Be" -- "cause" "they" "are" "no" "more" "Rac" -- "hel" "weep" -- "ing" "for" "her" "chil" -- "dren" _ _ _ }
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
