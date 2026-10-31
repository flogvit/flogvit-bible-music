\version "2.24.0"
\header {
  title = "Rejoice in Hope"
  subtitle = "Romans 12:12"
  tagline = ##f
  copyright = \markup \small \wordwrap { "Melody" "and" "chords" "from" "the" "score" "YuE2" "generated" "the" "song" "from" "(score.abc)." "Lyrics" "placed" "syllable" "by" "syllable" "against" "the" "recording" "with" "Whisper," "which" "heard" "99" "of" "100" "words." "19" "of" "22" "lyric" "lines" "sit" "clearly" "on" "their" "notes;" "3" "are" "uncertain" "and" "printed" "in" "grey" "italics." "Bible" "text:" "Open" "Source" "English" "(OSEN)," "CC" "BY" "4.0," "from" "SBLGNT" "and" "tanach.us." }
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
  \clef treble \key d \major \tempo 4 = 80
  \time 4/4 R1*1 | R1*1 | R1*1 | R1*1 | \sectionLabel "Verse 1" r2 r8 d'8 fis'8. g'16 | a'4 a'8 a'4 fis'4 fis'8 ~ | fis'8 r4. d''8. cis''8. a'8 | a'8. fis'16 d'16 r8. d'8. e'8. fis'8 | fis'4 r2 fis'8 a'16 a'16 ~ | a'8 b'4 r8 d'8 e'8 fis'8 fis'8 ~ | fis'8 e'8 r2 r8 fis'8 | fis'8. g'8. fis'16 e'16 d'4 r8 b16 d'16 ~ | d'8 e'4 r2 r8 | \sectionLabel "Verse 2" d''16 cis''8 d''8 cis''16 d''4 fis''4 cis''8 ~ | cis''8 r4 a'8 a'8 b'8 cis''8 cis''8 ~ | cis''8 d''4 r2 r8 | b'4 cis''8 d''4. e''8 fis''8 ~ | fis''4. e''2 e''8 ~ | \sectionLabel "Chorus" e''4 r2 a'8 fis''8 ~ | fis''2 ~ fis''8 a'4 b'8 ~ | b'8 r4 b'8 b'8. cis''8. d''8 | d''4 fis'4 r2 | g'4 fis'8 e'8 ~ e'4 d'8 d'8 ~ | d'4 r2. | R1*1 | \sectionLabel "Verse 3" a'8. a'8. a'16 a'8. g'8 fis'8 fis'8 ~ | fis'8 r4 d''8 d''8. cis''8. a'16 a'16 ~ | a'16 fis'16 e'16 d'8. e'4 fis'4 r8 | r2 fis'8. g'8. a'8 | a'4 d'8 d'4 b8 r4 | fis'8. g'8. fis'8 e'8 d'4 d'8 ~ | \sectionLabel "Chorus" d'8 d'4 r4. d''8 fis''8 ~ | fis''2 ~ fis''8 a'4 b'8 ~ | b'8 r4 b'8 b'8. cis''8. d''8 | d''4 fis'4 r2 | g'4 fis'8 e'8 ~ e'4 d'8 d'8 ~ | d'4 r2. | r2. d''8 fis''8 ~ | \sectionLabel "Bridge" fis''2 ~ fis''8 r8 d''8 e''8 ~ | e''4. fis''4 cis''4 d''16 cis''16 | b'2 r2 | b'4 cis''8 d''4 a''4 fis''8 ~ | fis''2 ~ fis''8 r8 d''8 e''8 ~ | e''4. fis''4 cis''4 d''16 cis''16 | b'2 r2 | \sectionLabel "Outro" r2. d''8 fis''8 ~ | fis''2 ~ fis''8 a'4 b'8 ~ | b'8 r2. r8 | fis'4 g'8 e'8 ~ e'4 d'8 d'8 ~ | \sectionLabel "Outro" d'4 r2. | R1*1 | R1*1 | R1*1 | R1*1 |
  \bar "|."
}
harmony = \chordmode { s1*7/8 d1*25/8 d1*3 b1*2:m7 g1 a1 g1 a1 b1:m7 fis1:m g1*2 a1 a1 d1 g1 b1:m7 g1*1/2 a1*1/2 d1*2 d1*2 b1*2:m7 g1 a1 d1*2 g1 b1:m7 g1*1/2 a1*1/2 d1*2 b1:m7 a1 g1*2 b1:m7 a1 g1 g1 d1 g1 b1*1/2:m7 a1*1/2 d1*5 }
words = \lyricmode { "Let" _ "love" "be" "gen" -- "uine" "and" "true" "Hate" _ "what" "is" "e" -- "vil," "hold" "fast" "to" "good" "Be" "de" -- "vot" -- "ed" "to" "one" "an" -- "oth" -- "er" "Out" -- "do" "one" "an" -- "oth" -- "er" "in" "hon" -- "or" "Ne" -- "ver" "let" "your" "zeal" "grow" "slack" "Be" "fer" -- "vent" "in" "spir" -- "it" "Serve" "the" "Lord" "with" "all" "your" "heart" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "Re" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "joice" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "in" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "hope" "En" -- "dure" "in" "af" -- "flic" -- "tion" "Per" -- "se" -- "vere" "in" "prayer" "Share" "with" "the" "saints" "in" "their" "needs" "Pur" -- _ "sue" "hos" -- "pi" -- "tal" -- "i" -- "ty" "al" -- "ways" "Bless" "those" "who" "per" -- "se" -- "cute" "you" "Bless" "them" "and" "do" "not" "curse" "them" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "Re" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "joice" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "in" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "hope" "En" -- "dure" "in" "af" -- "flic" -- "tion" "Per" -- "se" -- "vere" "in" "prayer" \skip 1 \skip 1 "Re" -- "joice" "with" "those" "who" "re" -- "joice" "Weep" "with" "those" "who" "weep" "U" -- "nit" -- "ed" "in" "faith" _ _ \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "Re" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "joice" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "in" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "hope" "Per" -- "se" -- "vere" "in" "prayer" }
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
