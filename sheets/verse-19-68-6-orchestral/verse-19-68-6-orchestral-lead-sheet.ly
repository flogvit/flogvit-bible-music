\version "2.24.0"
\header {
  title = "Father to the Fatherless"
  subtitle = "Psalms 68:6"
  tagline = ##f
  copyright = \markup \small \wordwrap { "Melody" "and" "chords" "from" "the" "score" "YuE2" "generated" "the" "song" "from" "(score.abc)." "Lyrics" "placed" "syllable" "by" "syllable" "against" "the" "recording" "with" "Whisper," "which" "heard" "107" "of" "109" "words." "19" "of" "22" "lyric" "lines" "sit" "clearly" "on" "their" "notes;" "3" "are" "uncertain" "and" "printed" "in" "grey" "italics." "Bible" "text:" "Open" "Source" "English" "(OSEN)," "CC" "BY" "4.0," "from" "SBLGNT" "and" "tanach.us." }
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
  \clef treble \key d \minor \tempo 4 = 78
  \time 4/4 R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | \sectionLabel "Verse 1" r2 d''8. e''8. f''8 | a''2 d''4 f''8 e''8 ~ | e''8 r4. c''8. d''8. e''8 | g''4 f''8 e''4. d''8 a'8 ~ | a'8 r4. d''8. e''8. f''8 | a''4. d''4 f''4 e''8 ~ | e''8 r4 c''8 c''8. d''8. e''8 | g''4. f''4. r4 | \sectionLabel "Chorus" e''8 d''4. r4. a''8 | d'''8 d'''8 d'''8 d'''8 c'''4 g''8 a''8 ~ | a''4. r4. a''8 c'''8 | d'''4 d'''8 c'''8 ~ c'''4 g''8 a''8 ~ | a''2 ~ a''8 r4. | d''4 e''8 f''8 g''4 f''8 g''8 ~ | g''8 a''4. r4 d''16 e''8. | f''4 g''4 e''4 c''4 | d''1 | \sectionLabel "Verse 2" r2 d''8. e''8. f''8 | a''2 d''4 f''8 e''8 ~ | e''4 r4 c''2 | g''4. f''8 e''4 d''8 a'8 ~ | a'8 r4 c''8 d''4 f''4 | a''4. d'''4. f'''8 e'''8 | e'''16 d'''16 c'''4. r4 c'''4 | d'''2 c'''4 g''8 a''8 ~ | \sectionLabel "Chorus" a''2 ~ a''8 r4 a''8 | d'''8 d'''8 d'''8 d'''8 c'''4 g''8 a''8 ~ | a''2 ~ a''8 r8 a''8 c'''8 | d'''4 d'''8 c'''8 ~ c'''4 g''8 a''8 ~ | a''2 ~ a''8 r4. | d''4 e''8 f''8 g''4 f''8 g''8 ~ | g''8 a''4. r4 d''16 e''8. | f''4 g''4 e''4 c''4 | d''1 ~ | d''1 | \sectionLabel "Bridge" d'''4 e'''8 f'''8 e'''8 d'''8 c'''8 g''8 | a''2. r8 a''8 | d'''4 e'''8 f'''8 e'''4 c'''4 | g''8 a''16 a''2 r8. a''16 a''16 | d'''4 f'''4 e'''4 c'''4 | g''8. a''16 a''2 r4 | d''4 e''8 f''8 g''16 f''8. e''4 | d''1 | \sectionLabel "Outro" r4. d''8 a''4 g''4 | e''8 d''2 r4. | r2 e''4 c''4 | c''8 d''8 d''2. ~ | d''2. r4 | R1*1 | R1*1 | R1*1 |
  \bar "|."
}
harmony = \chordmode { s1*7/8 d1*9/8:m a1:m/c bes1 f1*1/2 a1*1/2:m7/e d1:m a1:m/c bes1 bes1 d1:m a1:m/c bes1 f1 d1:m a1:m/c bes1 d1:m bes1*1/2 c1*1/2 d1:m bes1*1/2 c1*1/2 d1:m bes1*1/2 c1*1/2 d1:m bes1*1/2 c1*1/2 d1:m d1*2:m a1:m/c bes1 f1 d1:m a1:m/c bes1*1/2 c1*1/2 d1:m bes1*1/2 c1*1/2 d1:m bes1*1/2 c1*1/2 d1:m bes1*1/2 c1*1/2 d1:m bes1*1/2 c1*1/2 d1*2:m bes1*1/2 c1*1/2 d1:m bes1*1/2 c1*1/2 d1:m bes1*1/2 c1*1/2 d1:m bes1*1/2 c1*1/2 d1:m d1:m bes1 c1 d1:m a1:m/c bes1*5/4 d1*7/4:m }
words = \lyricmode { \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "As" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "smoke" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "is" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "driv" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "en" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "a" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "way" "The" "wic" -- "ked" "per" -- "ish" "in" "the" "fire" "But" "let" "the" "right" -- "eous" "be" "glad" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "Ex" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "ult" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "ing" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "be" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "fore" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "Him" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "high" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "er" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "A" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "fa" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "ther" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "to" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "the" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "fa" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "ther" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "less" "A" "de" -- "fend" -- "er" "of" "wid" -- "ows" "God" "in" "his" "ho" -- "ly" "d" -- "welling" "Sin" -- "ging" "prais" -- "es" "to" "his" "name" "Lift" "up" "a" "song" "for" "the" "Lord" "Who" "rides" "through" "the" "de" -- "serts" "Re" -- "joice" "be" -- "fore" "him" "al" -- "ways" _ _ _ "His" "name" "is" "the" "Lord" "A" "fa" -- "ther" "to" "the" "fa" -- "ther" -- "less" "A" "de" -- "fend" -- "er" "of" "wid" -- "ows" "God" "in" "his" "ho" -- "ly" "d" -- "welling" "Sin" -- "ging" "prais" -- "es" "to" "his" "name" "Set" -- "tles" "the" "lone" -- "ly" "in" "a" "home" "Leads" "priso" -- "ners" "to" "pros" -- "per" -- "i" -- "ty" _ "The" "re" -- "bel" -- "lious" "dwell" "in" "scorched" "land" _ "Earth" "shook" "and" "heav" -- "ens" "poured" "rain" "The" "One" "of" "Si" -- "nai" "God" "of" "Is" -- "rael" _ }
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
