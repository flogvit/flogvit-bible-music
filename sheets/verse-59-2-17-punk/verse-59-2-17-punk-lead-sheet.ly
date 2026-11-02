\version "2.24.0"
\header {
  title = "Faith Without Works"
  subtitle = "James 2:17"
  tagline = ##f
  copyright = \markup \small \wordwrap { "Melody" "and" "chords" "from" "the" "score" "YuE2" "generated" "the" "song" "from" "(score.abc)." "Lyrics" "placed" "syllable" "by" "syllable" "against" "the" "recording" "with" "Whisper," "which" "heard" "122" "of" "122" "words." "All" "20" "lyric" "lines" "sit" "on" "their" "notes." "Bible" "text:" "Open" "Source" "English" "(OSEN)," "CC" "BY" "4.0," "from" "SBLGNT" "and" "tanach.us." }
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
  \clef treble \key d \major \tempo 4 = 156
  \time 4/4 \sectionLabel "Verse 1" r4. d'8 fis'8 a'4 a'8 ~ | a'8 fis'4 e'4 d'4 r8 | r4. d'8 fis'8 a'4 a'8 ~ | a'8 fis'4 e'4 d'4 r8 | r4. d'8 fis'8 a'4 a'8 ~ | a'8 fis'4 e'4 d'4. | fis'4. g'8 fis'4. e'8 ~ | e'4 r2. | \sectionLabel "Verse 2" r4 fis'8 fis'8 fis'8 a'8 a'8 a'8 ~ | a'8 fis'4 e'4 d'4 d'8 | d'4 r8 d'8 fis'8 a'4 a'8 ~ | a'8 fis'4 e'4 d'8 d'8 d'8 | fis'8 a'4 a'4. fis'8 e'8 ~ | e'8 d'4 d'4 d'8 d'4 | fis'4. g'4. r4 | fis'4. g'4. a'4 | \sectionLabel "Chorus" r2 fis''8 e''8 d''4 | e''4. cis''4. d''4 ~ | d''2 r2 | R1*1 | r2 fis''8 e''8 d''4 | e''4. cis''4. d''4 ~ | d''2 r2 | R1*1 | fis''4. e''4. d''4 | e''2 r4 d''4 | fis''4. e''4. d''4 | d''2 r4 a'4 | fis''4. e''4. d''4 | e''4 fis''4 e''8 d''4 d''8 ~ | d''4. r2 r8 | R1*1 | \sectionLabel "Verse 3" r4. d'8 fis'8 a'4 a'8 ~ | a'8 fis'4 e'4 d'4 r8 | r4. d'8 fis'8 a'4 a'8 ~ | a'8 fis'4 e'4. d'4 | d'4 r2 d'4 | d'4 r2 d''4 | fis''2. g''8 e''8 | e''2. r4 | \sectionLabel "Chorus" r2 fis''8 e''8 d''4 | e''4. cis''4. d''4 ~ | d''2 r2 | R1*1 | r2 fis''8 e''8 d''4 | e''4. cis''4. d''4 ~ | d''2 r2 | R1*1 | fis''4. e''4. d''4 | e''2 r4 d''4 | fis''4. e''4. d''4 | d''2 r4 a'4 | fis''4. e''4. d''4 | e''4 fis''4 e''8 d''4 d''8 ~ | d''4. r2 r8 | R1*1 | \sectionLabel "Outro" R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 |
  \bar "|."
}
harmony = \chordmode { d1*4 g1*2 a1*2 d1*4 g1*2 a1*2 d1 a1 g1*2 d1 a1 g1*2 d1 a1 g1*2 d1 a1 g1*2 d1*4 g1*2 a1*2 d1 a1 g1*2 d1 a1 g1*2 d1 a1 g1*2 d1 a1 g1*2 d1 a1 g1*2 d1 a1 g1*2 }
words = \lyricmode { "What" "good" "is" "it," "my" "broth" -- "ers" "If" "some" -- "one" "says" "he" "has" "faith" "But" _ "does" "not" "have" "works" "Can" "that" "faith" "save" "him" "If" "a" "broth" -- "er" "or" "sis" -- "ter" "is" "poor" -- "ly" "clothed" "And" "lack" -- "ing" "dai" -- "ly" "food" "And" "you" "say," "go" "in" "peace," "be" "warm" "and" "filled" "With" -- "out" "giv" -- "ing" "what" "they" "need" "Faith" "with" -- "out" "works" "is" "dead" "Faith" "with" -- "out" "works" "is" "dead" "Show" "me" "your" "faith" "with" "noth" -- "ing" "to" "show" "I'll" "show" "you" "my" "faith" "by" "what" "I" "do" "So" "al" -- "so" "faith" "by" "it" -- "self" "If" "it" "does" "not" "have" "works" "Is" "dead," "is" "dead" "Get" "up" "and" "give" _ "Faith" "with" -- "out" "works" "is" "dead" "Faith" "with" -- "out" "works" "is" "dead" "Show" "me" "your" "faith" "with" "noth" -- "ing" "to" "show" "I'll" "show" "you" "my" "faith" "by" "what" "I" "do" }
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
