\version "2.24.0"
\header {
  title = "Not a Marketplace"
  subtitle = "John 2:13–17"
  tagline = ##f
  copyright = \markup \small \wordwrap { "Melody" "and" "chords" "from" "the" "score" "YuE2" "generated" "the" "song" "from" "(score.abc)." "Lyrics" "placed" "syllable" "by" "syllable" "against" "the" "recording" "with" "Whisper," "which" "heard" "104" "of" "104" "words." "All" "20" "lyric" "lines" "sit" "on" "their" "notes." "Bible" "text:" "Open" "Source" "English" "(OSEN)," "CC" "BY" "4.0," "from" "SBLGNT" "and" "tanach.us." }
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
  \clef treble \key e \major \tempo 4 = 180
  \time 4/4 \sectionLabel "Intro" R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | \sectionLabel "Verse 1" r4 gis'4 gis'4 gis'4 | a'4 gis'8 fis'4 e'4 fis'8 ~ | fis'4 r2 fis'8 fis'8 | gis'4 fis'8 e'4 dis'4 e'8 ~ | e'8 b4. gis'8 gis'4. | a'8 gis'4 fis'4. e'8 fis'8 ~ | fis'4 r2 fis'8 fis'8 | gis'4. e'4. dis'8 e'8 ~ | e'8 b4 r2 r8 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | \sectionLabel "Verse 2" r4 gis''4 gis''4 gis''8 a''8 ~ | a''8 r4. fis''8 e''4 fis''8 ~ | fis''4 r4 fis''4 fis''8 gis''8 ~ | gis''4 fis''8 e''4 dis''4 e''8 ~ | e''8 b'4. gis''8 gis''4. | a''4 gis''8 fis''4. e''8 fis''8 ~ | fis''4 r2. | gis''4 fis''8 e''4 dis''4 e''8 ~ | \sectionLabel "Chorus" e''8 b'4. gis''4 gis''8 fis''8 ~ | fis''4 r4 fis''4 gis''8 fis''8 ~ | fis''4 e''8 cis''4. r4 | a''4 a''8 a''4 gis''4 gis''8 ~ | gis''4 gis''4 gis''8 e''4 fis''8 ~ | fis''4 fis''4 gis''8 dis''4 e''8 ~ | e''4. r2 r8 | r4 e''8 e''8 e''8 dis''4 e''8 ~ | \sectionLabel "Interlude" e''4. r8 r2 | R1*1 | R1*1 | R1*1 | \sectionLabel "Verse 3" r2 gis'4 gis'8 a'8 ~ | a'4. fis'4. e'8 fis'8 ~ | fis'8 fis'4. fis'4 fis'4 | gis'8 fis'4. e'4 dis'8 e'8 ~ | e'4 gis'4 gis'4 gis'8 a'8 ~ | a'4. r8 fis'4 e'8 fis'8 ~ | fis'8 fis'4. r2 | R1*1 | r4 gis''4 gis''4 gis''8 a''8 ~ | a''4. r8 fis''4 e''8 fis''8 ~ | \sectionLabel "Chorus" fis''8 e''4. gis''4 gis''8 fis''8 ~ | fis''4 r4 fis''4 gis''8 fis''8 ~ | fis''4 e''8 cis''4. r4 | a''4 a''8 a''4 gis''4 gis''8 ~ | gis''4 gis''4 gis''8 e''4 fis''8 ~ | fis''4 fis''4 gis''8 dis''4 e''8 ~ | e''4. r2 r8 | r4 e''8 e''8 e''8 dis''4 e''8 ~ | \sectionLabel "Outro" e''2 ~ e''2 ~ | e''2. ~ e''8 r8 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 |
  \bar "|."
}
harmony = \chordmode { e1*1/2 a1*1/2 b1 e1*1/2 a1*1/2 b1 e1*1/2 a1*1/2 b1 e1*1/2 a1*1/2 b1 e1 a1 b1*2 e1 a1 b1*2 e1 a1 b1*2 e1 a1 b1*2 e1 a1 b1*2 e1 a1 b1*2 e1 b1 a1*2 e1 b1 a1*2 e1*1/2 a1*1/2 b1 e1*1/2 a1*1/2 b1 e1 a1 b1*2 e1 a1 b1*4 e1 b1 a1*2 e1 b1 a1*2 e1*1/2 a1*1/2 b1 e1*1/2 a1*1/2 b1 e1*1/2 a1*1/2 b1 e1*1/2 a1*1/2 b1 e1*4 }
words = \lyricmode { "Pas" -- "so" -- "ver" "in" "Je" -- "ru" -- "sa" -- "lem" "Mon" -- "ey" "chang" -- "ers" "at" "their" "ta" -- "bles" "Cat" -- "tle," "sheep" "and" "doves" "for" "sale" "In" "the" "courts" "of" "the" "tem" -- "ple" "He" "made" "a" "whip" "out" "of" "cords" "Drove" "them" "out" "with" "all" "their" "cat" -- "tle" "Scat" -- "tered" "coins" "ac" -- "ross" "the" "floor" "Over" -- "tur" -- "ned" "their" "ta" -- "bles" "Get" "it" "out," "get" "it" "out" "of" "here" "Not" "a" "mar" -- "ket" -- "place" "My" "Fa" -- "ther's" "house," "my" "Fa" -- "ther's" "house" "Not" "a" "mar" -- "ket" -- "place" "His" "dis" -- "ci" -- "ples" "re" -- "mem" -- "bered" "What" "was" "writ" -- "ten" "long" "a" -- "go" "Zeal" "for" "your" "house" "will" "con" -- "sume" "me" "Zeal" "for" "your" "house" "will" "con" -- "sume" "me" "Get" "it" "out," "get" "it" "out" "of" "here" "Not" "a" "mar" -- "ket" -- "place" "My" "Fa" -- "ther's" "house," "my" "Fa" -- "ther's" "house" "Not" "a" "mar" -- "ket" -- "place" }
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
