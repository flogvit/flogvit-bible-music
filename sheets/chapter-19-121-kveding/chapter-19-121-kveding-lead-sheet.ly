\version "2.24.0"
\header {
  title = "Jeg løfter mine øyne mot fjellene"
  subtitle = "Psalm 121"
  tagline = ##f
  copyright = \markup \small \wordwrap { "Melody" "and" "chords" "from" "the" "score" "YuE2" "generated" "the" "song" "from" "(score.abc)." "Lyrics" "placed" "syllable" "by" "syllable" "against" "the" "recording" "with" "Whisper," "which" "heard" "91" "of" "93" "words." "All" "16" "lyric" "lines" "sit" "on" "their" "notes." "Bibeltekst:" "Open" "Source" "Norsk" "Bokmål" "(OSNB)," "CC" "BY" "4.0," "fra" "SBLGNT" "og" "tanach.us." }
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
  \clef treble \key d \minor \tempo 4 = 92
  \time 6/8 R1*3/4 | R1*3/4 | R1*3/4 | R1*3/4 | \sectionLabel "Verse 1" r2 r8 a'8 | d''4 d''8 d''4 e''8 | f''4 e''8 d''4 c''8 | d''4 a'8 a'4 r8 | R1*3/4 | d''4 d''8 d''4 e''8 | f''4. e''8 d''8 c''8 | a''4 a''8 a''4 g''8 | g''8 a''4 r4. | bes''4 bes''8 bes''4 a''8 | g''4. f''4 e''8 | d''2 r4 | \sectionLabel "Verse 2" r2 r8 a'8 | d''4 d''8 d''4 e''8 | f''4. e''8 d''8 c''8 | d''4 d''8 d''4 c''8 | c''8 d''4 r4. | d''4 d''8 d''4 e''8 | f''8 f''8 f''8 e''8 d''8 c''8 | a''4 a''8 a''4 g''8 | g''4 a''8 a''4 r8 | \sectionLabel "Verse 3" bes''4 bes''8 bes''4 a''8 | g''4 g''4 r4 | bes''4 bes''8 bes''4 a''8 | g''8 g''4 f''4 e''8 | f''16 e''16 d''8 d''8 d''4. ~ | d''4. r4 d''8 | bes''8 bes''8 bes''8 bes''8 a''8 g''16 f''16 | g''8 g''8 g''4 r8 f''8 | a''4 g''8 g''8 f''8 e''8 | e''4 d''2 ~ | d''2 r4 | \sectionLabel "Verse 4" d'''4 a''4 a''8 a''8 | c'''4 g''4 f''8 g''8 | a''4. d''4. ~ | d''4. r4. | d'''4 a''4. a''8 | c'''4 g''4 f''8 g''8 | a''2. ~ | a''2. | bes''4 bes''4 bes''8 a''8 | g''4 g''4 r8 f''8 | a''4 g''4 f''8 e''8 | e''4 d''4 r8 c''8 | d''4. r8 d''8 f''8 | e''4. c''4. | d''2. ~ | d''2. | R1*3/4 | R1*3/4 | R1*3/4 |
  \bar "|."
}
harmony = \chordmode { s1*5/8 d1*19/8:m d1*21/4:m f1*3/4 a1*3/4:m bes1*3/4 c1*3/4 d1*3/4:m d1*21/4:m f1*3/4 a1*3/4:m bes1*3/4 c1*3/4 bes1*3/4 c1*3/4 d1*3/2:m bes1*3/4 c1*3/4 d1*9/4:m d1*3/4:m c1*3/4 d1*9/4:m c1*3/4 f1*3/2 bes1*3/4 c1*3/4 d1*3/2:m bes1*3/4 c1*3/4 d1*15/4:m }
words = \lyricmode { "Jeg" "løf" -- "ter" "mi" -- "ne" "øy" -- "ne" _ "mot" "fjel" -- "le" -- "ne" "hvor" -- "fra" "skal" "min" "hjelp" "kom" -- "me" "Min" "hjelp" "kom" -- "mer" "fra" "Her" -- "ren" "han" "som" "skap" -- "te" "him" -- "mel" "og" "jord" "Han" "lar" "ik" -- "ke" "din" "fot" "vak" -- "le" "din" "vok" -- "ter" "slum" -- "rer" "ik" -- "ke" "Se," "han" "slum" -- "rer" "ik" -- "ke" "og" "so" -- "ver" "ik" -- "ke" "han" "som" "vok" -- "ter" "Is" -- "rael" "Her" -- "ren" "er" "din" "vok" -- "ter" "Her" -- "ren" _ "er" "din" "skyg" -- "ge" "ved" "din" "høy" -- "re" "hånd" _ "Om" "da" -- "gen" "skal" "so" -- "len" "ik" -- "ke" "stik" -- "ke" "deg" "og" "må" -- "nen" "ik" -- "ke" "om" "nat" -- "ten" "Her" -- "ren" "skal" "be" -- "va" -- "re" "deg" "fra" "alt" "ondt" "han" "skal" "be" -- "va" -- "re" "din" "sjel" _ "Her" -- "ren" "skal" "be" -- "va" -- "re" "din" "ut" -- "gang" "og" "din" "inn" -- "gang" "fra" "nå" "og" "til" "e" -- "vig" "tid" }
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
