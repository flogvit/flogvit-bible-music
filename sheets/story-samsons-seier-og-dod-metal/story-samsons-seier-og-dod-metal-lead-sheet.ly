\version "2.24.0"
\header {
  title = "Remember Me"
  subtitle = "Judges 16:23–30"
  tagline = ##f
  copyright = \markup \small \wordwrap { "Melody" "and" "chords" "from" "the" "score" "YuE2" "generated" "the" "song" "from" "(score.abc)." "Lyrics" "placed" "syllable" "by" "syllable" "against" "the" "recording" "with" "Whisper," "which" "heard" "105" "of" "127" "words." "0" "of" "20" "lyric" "lines" "sit" "clearly" "on" "their" "notes;" "20" "are" "uncertain" "and" "printed" "in" "grey" "italics." "Bible" "text:" "Open" "Source" "English" "(OSEN)," "CC" "BY" "4.0," "from" "SBLGNT" "and" "tanach.us." }
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
  \clef treble \key dis \minor \tempo 4 = 72
  \partial 2 \sectionLabel "Intro" r2 | \time 4/4 R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | \sectionLabel "Verse" R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | \sectionLabel "Chorus" R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | \sectionLabel "Interlude" R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | \sectionLabel "Verse" R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | \sectionLabel "Chorus" R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | \sectionLabel "Interlude" R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 |
  \bar "|."
}
harmony = \chordmode { dis1*41/4:m cis1*1/4 b1*7/4 cis1*1/4 dis1*7/4:m cis1*1/4 b1*7/4 cis1*1/4 dis1*7/4:m cis1*1/4 b1*7/4 cis1*1/4 dis1*7/4:m cis1*1/4 b1*7/4 cis1*1/4 dis1*7/4:m cis1*1/4 b1*7/4 cis1*1/4 dis1*7/4:m cis1*1/4 b1*7/4 cis1*1/4 dis1*7/4:m cis1*1/4 b1*7/4 cis1*1/4 dis1*7/4:m cis1*1/4 b1*7/4 cis1*1/4 dis1*7/4:m cis1*1/4 b1*7/4 cis1*1/4 dis1*7/4:m cis1*1/4 b1*7/4 cis1*1/4 dis1*7/4:m cis1*1/4 b1*7/4 cis1*1/4 dis1*7/4:m cis1*1/4 b1*7/4 cis1*1/4 dis1*7/4:m cis1*1/4 b1*7/4 cis1*1/4 dis1*7/4:m cis1*1/4 b1*7/4 cis1*1/4 dis1*7/4:m cis1*1/4 b1*7/4 cis1*1/4 dis1*7/4:m cis1*1/4 b1*7/4 cis1*1/4 dis1*7/4:m cis1*1/4 b1*7/4 cis1*1/4 dis1*7/4:m cis1*1/4 b1*7/4 cis1*1/4 dis1*7/4:m cis1*1/4 b1*7/4 cis1*1/4 dis1*7/4:m cis1*1/4 b1*7/4 cis1*1/4 dis1*7/4:m cis1*1/4 b1*7/4 cis1*1/4 dis1*7/4:m cis1*1/4 }
words = \lyricmode {  }
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
