\version "2.24.0"
\header {
  title = "Herren er min hyrde"
  subtitle = "Psalm 23"
  tagline = ##f
  copyright = \markup \small \wordwrap { "Melody" "and" "chords" "from" "the" "score" "YuE2" "generated" "the" "song" "from" "(score.abc)." "Lyrics" "placed" "syllable" "by" "syllable" "against" "the" "recording" "with" "Whisper," "which" "heard" "91" "of" "98" "words." "All" "13" "lyric" "lines" "sit" "on" "their" "notes." "Bibeltekst:" "Open" "Source" "Norsk" "Bokmål" "(OSNB)," "CC" "BY" "4.0," "fra" "SBLGNT" "og" "tanach.us." }
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
  \clef treble \key g \minor \tempo 4 = 66
  \partial 2 \sectionLabel "Intro" r2 | \time 4/4 R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | \sectionLabel "Verse 1" g''8 g''8 g''8 f''8 g''8 d''4 d''8 | c''8. d''16 c''8 bes'8 g'8 r4 d''8 | d''8. d''16 g''16 g''16 g''8 f''8 g''8 d''8 d''16 d''16 | c''16 c''16 c''16 d''16 c''8 bes'8 g'8 r4. | \sectionLabel "Verse 2" g''8. g''16 g''16 g''16 f''8 g''4 r8 d''8 | c''8. d''16 c''8 c''16 d''16 c''16 c''16 bes'8 c''8 d''8 ~ | d''4 d''8 d''8 c''4 r4 | g'8 r4. r2 | \sectionLabel "Verse 3" r2 r4 g''16 g''16 g''8 | g''8 g''16 g''16 g''8 f''16 f''16 g''4 d''16 d''16 d''8 | c''16 c''16 c''16 bes'16 c''8 r8 r8. c''16 c''8 bes'8 | g'8 d''8 d''16 d''16 d''8 c''8. d''16 c''8 bes'8 | g'8 r4. r2 | \sectionLabel "Verse 4" g''16 g''8 g''16 g''8 g''16 g''16 g''16 bes''16 bes''16 bes''16 bes''8 a''8 | g''8. f''16 d''4 r8. d''16 d''16 d''16 d''8 | g''8 g''16 g''16 g''8 g''8 ~ g''16 bes''16 bes''16 bes''16 bes''8 a''8 | \sectionLabel "Verse 5" g''8. f''16 d''4 r4. d''16 d''16 | g''8 g''16 g''16 g''8 g''16 g''16 bes''8 bes''16 bes''16 bes''16 a''16 g''16 f''16 | g''8. f''16 d''4 r4 r16 d''16 d''16 d''16 | d''8. c''16 c''8 bes'8 c''8. d''16 c''8 bes'8 | g'4 g'4 r2 | \sectionLabel "Interlude" R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 |
  \bar "|."
}
harmony = \chordmode { s1*1/2 g1*3:m c1:m g1:m g1:m c1:m g1:m c1:m g1:m c1:m bes1*1/2 f1*1/2/a g1:m g1*2:m c1:m g1*1/2:m f1*1/2 g1:m es1 g1:m es1 g1:m es1 g1:m es1*1/2 f1*1/2 g1:m es1 g1:m es1 g1:m es1 g1:m es1 g1*2:m }
words = \lyricmode { "Her" -- "ren" "er" "min" "hyr" -- "de," "jeg" "mang" -- "ler" "in" -- "gen" -- "ting" "Han" "lar" "meg" "lig" -- "ge" "i" "grøn" -- "ne" "en" -- "ger" "han" "le" -- "der" "meg" "til" "stil" -- "le" "vann" "Han" "for" -- "nyer" "min" "sjel" _ "Han" _ "le" -- "der" "meg" "på" "rett" -- "fer" -- "dig" -- "hets" "stier" "for" "sitt" "navns" "skyld" "Om" _ "jeg" "enn" "vand" -- "rer" "i" "døds" -- "skyg" -- "gens" "dal" "fryk" -- "ter" "jeg" "ik" -- "ke" "noe" "ondt," "for" "du" "er" "med" "meg" "Din" "kjepp" "og" "din" "stav," "de" "trøs" -- "ter" "meg" "Du" "dek" -- "ker" "bord" "for" "meg" "li" -- "ke" "fo" -- "ran" "mi" -- "ne" "fien" -- "der" "Du" _ "sal" -- "ver" "mitt" "ho" -- "de" "med" "ol" -- "je," "mitt" "be" -- "ger" "fly" -- "ter" "o" -- "ver" "Ba" -- _ "re" "god" -- "het" "og" "nå" -- "de" "skal" "føl" -- "ge" "meg" "al" -- "le" "mi" -- "ne" "da" -- "ger" "og" "jeg" "skal" "bo" "i" "Her" -- "rens" "hus" "i" "lan" -- "ge" "ti" -- "der" }
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
