\version "2.24.0"
\header {
  title = "Han skal tørke bort hver tåre"
  subtitle = "Revelation 21:4"
  tagline = ##f
  copyright = \markup \small \wordwrap { "Melody" "and" "chords" "from" "the" "score" "YuE2" "generated" "the" "song" "from" "(score.abc)." "Lyrics" "placed" "syllable" "by" "syllable" "against" "the" "recording" "with" "Whisper," "which" "heard" "93" "of" "94" "words." "All" "16" "lyric" "lines" "sit" "on" "their" "notes." "Bibeltekst:" "Open" "Source" "Norsk" "Bokmål" "(OSNB)," "CC" "BY" "4.0," "fra" "SBLGNT" "og" "tanach.us." }
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
  \clef treble \key g \major \tempo 4 = 82
  \time 3/4 R1*3/4 | R1*3/4 | R1*3/4 | R1*3/4 | R1*3/4 | R1*3/4 | R1*3/4 | R1*3/4 | R1*3/4 | R1*3/4 | \sectionLabel "Verse 1" r2 r8 d'8 | d'8 d'16 d'16 d'8 d'4 c'8 | c'8 b8 r4 b8 b8 | a4 a8 a4 g8 | b4 r4 b8 c'8 | d'4 d'8 d'4 c'8 | c'8 b16 b16 r8. b16 b8 b8 | a4 a8 a4 g8 | \sectionLabel "Chorus" g4 r4 g'8 a'8 | a'4 g'8 g'4 e'8 | e'8. g'8. r4 a'8 | a'4 g'8 g'4 e'16 d'16 ~ | d'8. r4. r16 d'8 | d'8 d'8 d'8 d'4 c'8 | c'8 b16 b8. r8 b16 b16 b16 b16 | a4 a8 a4 g16 g16 ~ | g8. r2 r16 | R1*3/4 | R1*3/4 | R1*3/4 | \sectionLabel "Verse 2" r2 b8 c'8 | d'4 d'8 d'4 c'16 c'16 ~ | c'8 b8 r4 b8 b8 | a4 a8 a4 g8 | b4 r4 b8 c'8 | d'4 d'8 d'4 c'8 | c'8 b16 b8. r16 b16 b8 b8 | a4 a8 a4 g8 | \sectionLabel "Chorus" g4 r4 g'8 a'8 | a'4 g'8 g'4 e'8 | e'8. g'8. r4 a'8 | a'4 g'8 g'4 e'16 d'16 ~ | d'8. r4. r16 d'8 | d'8 d'8 d'8 d'4 c'8 | c'8 b16 b8. r8 b16 b16 b16 b16 | a4 a8 a4 g16 g16 ~ | g8. r2 r16 | \sectionLabel "Outro" R1*3/4 | R1*3/4 | R1*3/4 | R1*3/4 |
  \bar "|."
}
harmony = \chordmode { s1*5/8 g1*25/8 d1*3/4:7 g1*9/4 d1*3/4:7 g1*9/4 d1*3/4:7 g1*9/4 d1*3/4:7 g1*3/4 c1*9/4 g1*9/4 d1*3/4:7 g1*9/4 d1*3/4:7 g1*9/4 d1*3/4:7 g1*9/4 d1*3/4:7 g1*3/4 c1*9/4 g1*9/4 d1*3/4:7 g1*3/4 g1*3/2 d1*3/4:7 g1*3/4 }
words = \lyricmode { "Jeg" _ "hør" -- "te" "en" "røst" "fra" "tro" -- "nen" "Se," "Guds" "bo" -- "lig" "er" "hos" "oss" "Han" _ "skal" "bo" "hos" "si" -- "ne" "eg" -- "ne" "og" _ "de" "skal" "væ" -- "re" "hans" "folk" "Han" "skal" "tør" -- "ke" "bort" "hver" "tå" -- "re" "fra" "vå" -- "re" "øy" -- "ne" "der" "Og" "dø" -- "den" "skal" "ik" -- "ke" "væ" -- "re" "mer" "hel" -- "ler" "ik" -- "ke" "sorg" "og" "smer" -- "te" "mer" "Når" "jeg" "går" "min" "sis" -- "te" "vand" -- "ring" "og" "min" "rei" -- "se" "her" "er" "slutt" "Da" _ "skal" "jeg" "se" "ham" "som" "han" "er" "og" "hjem" -- "me" "væ" -- "re" "hos" "min" "Gud" "Han" "skal" "tør" -- "ke" "bort" "hver" "tå" -- "re" "fra" "vå" -- "re" "øy" -- "ne" "der" "Og" "dø" -- "den" "skal" "ik" -- "ke" "væ" -- "re" "mer" "hel" -- "ler" "ik" -- "ke" "sorg" "og" "smer" -- "te" "mer" }
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
