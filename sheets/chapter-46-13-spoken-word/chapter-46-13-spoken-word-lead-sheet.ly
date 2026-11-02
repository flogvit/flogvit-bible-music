\version "2.24.0"
\header {
  title = "Love Is Patient"
  subtitle = "1 Corinthians 13"
  tagline = ##f
  copyright = \markup \small \wordwrap { "Melody" "and" "chords" "from" "the" "score" "YuE2" "generated" "the" "song" "from" "(score.abc)." "Lyrics" "placed" "syllable" "by" "syllable" "against" "the" "recording" "with" "Whisper," "which" "heard" "130" "of" "130" "words." "17" "of" "19" "lyric" "lines" "sit" "clearly" "on" "their" "notes;" "2" "are" "uncertain" "and" "printed" "in" "grey" "italics." "Bible" "text:" "Open" "Source" "English" "(OSEN)," "CC" "BY" "4.0," "from" "SBLGNT" "and" "tanach.us." }
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
  \clef treble \key d \major \tempo 4 = 71
  \time 3/4 R1*3/4 | R1*3/4 | R1*3/4 | \sectionLabel "Verse 1" r2 r8 d''8 | fis''4 fis''16 fis''16 fis''4 e''8 | d''8 r2 d''16 cis''16 | cis''4 b'8 r4. | r2 a'16 a'16 d''8 | d''4 r2 | r2 d''8 e''16 d''16 | fis''4 fis''16 fis''8. r8. d''16 | e''8 fis''4 e''8 d''8 r8 | r8 d''16 d''16 fis''8 fis''8 r8. d''16 | e''8 e''16 e''16 fis''8 e''8 d''4 | r8 a'16 a'16 d''8 d''8 r4 | r2 b'8 a'8 | a'8 d''4 r4. | r2 fis''8 a''8 | \sectionLabel "Chorus" b''4. b''4 r8 | r2 b''8 a''8 | fis''2 r4 | r4 fis''4 e''16 d''16 d''8 | d''8 r2 r8 | R1*3/4 | \sectionLabel "Verse 2" fis''8 fis''16 fis''8. fis''8 e''16 d''8 d''16 | d''8 r2 r8 | r16 d''16 d''16 fis''8. fis''16 e''16 e''8 d''8 | d''4 r2 | r8 d''16 d''16 e''16 d''16 fis''8 e''16 d''16 d''8 ~ | d''8 b'8 r4. r16 d''16 | e''8 fis''4 fis''4 r16 d''16 | e''8 fis''4 fis''4 r8 | e''8 fis''4 fis''4 d''16 e''16 ~ | e''8 fis''4 fis''4. | R1*3/4 | \sectionLabel "Chorus" r2 fis''8 a''8 | b''4. b''4 r8 | r2 b''8 a''8 | fis''2 r4 | r4 fis''4 e''16 d''16 d''8 ~ | d''8 r2 r8 | \sectionLabel "Verse 3" r2 r8. d''16 | fis''8 fis''4 fis''4 e''16 d''16 | e''16 fis''4 r16 e''8 d''8 r8 | r8. d''16 d''8 fis''4 d''16 d''16 ~ | d''8 r2 r8 | r8 d''16 d''16 e''16 d''16 fis''8. e''16 d''8 | e''8 fis''4 e''16 d''8. r8 | r8. d''16 fis''8 fis''4 r8 | e''4 fis''8 e''16 d''16 d''8 b'8 | b'4 r2 | r4 a'16 a'16 fis''8 e''16 d''8. | b'2 d''4 | d''4 r2 | R1*3/4 | R1*3/4 |
  \bar "|."
}
harmony = \chordmode { d1*9/4 d1*9/4 b1*3/2:m7 g1*3/2 d1*3/2 b1*3/2:m7 g1*3/2 d1*3/2 g1*3/2 d1*3 d1*3/2 b1*3/2:m7 g1*3/2 d1*3/2 b1*3/2:m7 g1*3/4 g1*9/4 d1*9/4 d1*9/4 b1*3/2:m7 g1*3/2 d1*3/2 g1*9/4 d1*9/4 }
words = \lyricmode { "If" "I" "speak" "in" "the" "tongues" "of" "men" "and" "of" "an" -- "gels" "But" "have" "not" "love" "I" "am" "a" "noi" -- "sy" "gong," "a" "clang" -- "ing" "cym" -- "bal" "If" "I" "have" "all" "faith," "so" "as" "to" "re" -- "move" "moun" -- "tains" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "But" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "have" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "not" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "love," \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "I" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "am" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "noth" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "ing" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "Love" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "is" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "pa" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "tient," \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "love" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "is" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "kind" "Love" "ne" -- "ver" "ends" "Love" "does" "not" "en" -- "vy" "or" "boast" "It" "is" "not" "ar" -- "ro" -- "gant" "or" "rude" "It" "does" "not" "in" -- "sist" "on" "its" "own" "way" "It" "bears" "all" "things," "be" -- "lieves" "all" "things" "Hopes" "all" "things," "en" -- "dures" "all" "things" "Love" "is" "pa" -- "tient," "love" "is" "kind" "Love" "ne" -- "ver" "ends" "For" "now" "we" "see" "in" "a" "mir" -- "ror" "dim" -- "ly" "But" "then" "face" "to" "face" "Now" "I" "know" "in" "part," "then" "I" "shall" "know" "ful" -- "ly" "So" "now" "faith," "hope" "and" "love" "a" -- "bide," "these" "three" "But" "the" "great" -- "est" "of" "these" "is" "love" }
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
