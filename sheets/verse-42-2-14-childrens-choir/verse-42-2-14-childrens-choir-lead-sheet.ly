\version "2.24.0"
\header {
  title = "Glory in the Highest"
  subtitle = "Luke 2:14"
  tagline = ##f
  copyright = \markup \small \wordwrap { "Melody" "and" "chords" "from" "the" "score" "YuE2" "generated" "the" "song" "from" "(score.abc)." "Lyrics" "placed" "syllable" "by" "syllable" "against" "the" "recording" "with" "Whisper," "which" "heard" "82" "of" "82" "words." "All" "16" "lyric" "lines" "sit" "on" "their" "notes." "Bible" "text:" "Open" "Source" "English" "(OSEN)," "CC" "BY" "4.0," "from" "SBLGNT" "and" "tanach.us." }
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
  \clef treble \key d \major \tempo 4 = 103
  \time 4/4 \sectionLabel "Intro" R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | \sectionLabel "Verse 1" d''4 a''4 e''4 a''4 | fis''4 d''4 a'4 r4 | b'4 d''4 d''4 fis''4 | e''2 r4. d''8 | d''4 a''4 e''4 a''4 | fis''4 d''4 a'4 r8 a'8 | b'4 g''4 fis''8 e''16 r16 e''8 d''8 | d''2 r2 | \sectionLabel "Chorus" fis''4 fis''8 r8 e''8 fis''8 g''8 a''8 | fis''4 d''8 r8 cis'''4 a''4 | b''4. a''8 a''4 r4 | b'4. e''8 e''4 r4 | fis''4 fis''8 r8 e''8 fis''8 g''8 a''8 | fis''4 d''8 r8 cis'''4 a''4 | b''4 g''4 fis''4 e''8 d''8 | d''2 r2 | \sectionLabel "Verse 2" d''4 a''4 e''4 a''4 | fis''4 d''4 a'4 r8 a'8 | b'4 d''4 d''4 fis''4 | e''2 r4. d''8 | d''4 a''4 e''4 a''4 | fis''4 d''4 a'4 r8 a'8 | b'4 g''4 fis''8 e''8 e''8 d''8 | d''2 r2 | \sectionLabel "Chorus" fis''4 fis''8 r8 e''8 fis''8 g''8 a''8 | fis''4 d''8 r8 cis'''4 a''4 | b''4. a''8 a''4 r4 | b'4. e''8 e''4 r4 | fis''4 fis''8 r8 e''8 fis''8 g''8 a''8 | fis''4 d''8 r8 cis'''4 a''4 | b''4 g''4 fis''4 e''8 d''8 | d''2 r2 | \sectionLabel "Outro" R1*1 | R1*1 | R1*1 | R1*1 | R1*1 |
  \bar "|."
}
harmony = \chordmode { s1*1 d1*1/2 a1*1/2/cis b1*1/2:m a1*1/2 g1*1/2 d1*1/2/fis a1 d1*1/2 a1*1/2/cis b1*1/2:m a1*1/2 g1 a1 d1*1/2 a1*1/2/cis b1*1/2:m a1*1/2 g1 d1 d1*1/2 a1*1/2 b1*1/2:m fis1*1/2:m g1*1/2 d1*1/2 g1*1/2 a1*1/2 d1*1/2 a1*1/2 b1*1/2:m fis1*1/2:m g1*1/2 a1*1/2 d1 d1*1/2 a1*1/2/cis b1*1/2:m a1*1/2 g1 a1 d1*1/2 a1*1/2/cis b1*1/2:m a1*1/2 g1 d1 d1*1/2 a1*1/2 b1*1/2:m fis1*1/2:m g1*1/2 d1*1/2 g1*1/2 a1*1/2 d1*1/2 a1*1/2 b1*1/2:m fis1*1/2:m g1*1/2 a1*1/2 d1 d1*1/2 a1*1/2/cis b1*1/2:m a1*1/2 g1 a1*2 }
words = \lyricmode { "Shep" -- "herds" "in" "the" "field" "at" "night" "Watch" -- "ing" "all" "their" "sheep" "An" "an" -- "gel" "came" "with" "shin" -- "ing" "light" "And" _ "woke" "them" "from" "their" "sleep" _ "Glo" -- "ry," "glo" -- "ry" "in" "the" "high" -- "est" "Peace" "on" "earth" "to" -- "night" \skip 1 \skip 1 \skip 1 "Glo" -- "ry," "glo" -- "ry" "in" "the" "high" -- "est" "Je" -- "sus" "Christ" "is" "born" "to" -- "night" _ "Do" "not" "be" "af" -- "raid," "he" "said" "I" "bring" "you" "news" "of" "joy" "In" "Beth" -- "le" -- "hem," "a" "man" -- "ger" "bed" "Now" _ "holds" "a" "ba" -- "by" "boy" _ "Glo" -- "ry," "glo" -- "ry" "in" "the" "high" -- "est" "Peace" "on" "earth" "to" -- "night" \skip 1 \skip 1 \skip 1 "Glo" -- "ry," "glo" -- "ry" "in" "the" "high" -- "est" "Je" -- "sus" "Christ" "is" "born" "to" -- "night" _ }
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
