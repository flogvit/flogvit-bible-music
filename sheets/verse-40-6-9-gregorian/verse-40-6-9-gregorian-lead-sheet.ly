\version "2.24.0"
\header {
  title = "Pater Noster"
  subtitle = "Matthew 6:9–13"
  tagline = ##f
  copyright = \markup \small \wordwrap { "Melody" "and" "chords" "from" "the" "score" "YuE2" "generated" "the" "song" "from" "(score.abc)." "Lyrics" "placed" "syllable" "by" "syllable" "against" "the" "recording" "with" "Whisper," "which" "heard" "51" "of" "52" "words." "10" "of" "11" "lyric" "lines" "sit" "clearly" "on" "their" "notes;" "1" "are" "uncertain" "and" "printed" "in" "grey" "italics." "Bible" "text:" "Open" "Source" "English" "(OSEN)," "CC" "BY" "4.0," "from" "SBLGNT" "and" "tanach.us." }
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
  \clef treble \key d \minor \tempo 4 = 59
  \time 2/4 R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | \sectionLabel "Verse 1" r4. d'8 | d'4 a'8 a'8 | g'8 f'16 e'16 d'4 | d'8 a'8 g'8 bes'8 | a'4 r8 d'8 | d'8 e'8 f'8. g'16 | f'8 e'8 d'8. c'16 | d'8 d'16 e'16 f'8 g'8 | f'16 e'16 d'8 ~ d'8 r8 | \sectionLabel "Verse 2" d'16 d'8 a'16 a'8. g'16 | g'8 bes'8 a'4 | d'8. a'16 a'16 a'16 g'8 | a'4 r8 d'16 d'16 | d'8 e'8 f'8. g'16 | f'16 e'16 d'8 d'8 c'8 | d'2 ~ | \sectionLabel "Verse 3" d'4 r8 d'8 | d'8 e'8 f'4 | g'4 f'8 e'8 | f'16 e'16 d'4. ~ | d'8 r4. | d'8. e'16 f'8 a'8 | g'4 f'4 | \sectionLabel "Outro" f'16 e'16 d'4. | d'8 r4. | \sectionLabel "Interlude" R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 | R1*1/2 |
  \bar "|."
}
harmony = \chordmode { d1*11/2:m d1*5/2:m bes1*1/2 c1*1/2 g1*1/2:m a1*1/4:m d1*1/4:m d1*2:m bes1*1/2 c1*1/2 g1*1/2:m g1*1/2:m bes1*1/2 c1*1/2 d1:m bes1*1/2 c1*1/2 d1:m d1*2:m bes1*1/2 c1*1/2 d1*3:m bes1*1/2 c1*1/2 d1*3:m bes1*1/2 c1*1/2 d1*3:m bes1*1/2 c1*1/2 d1*3:m bes1*1/2:maj7 c1*1/2 d1*2:m }
words = \lyricmode { "Our" "Fa" -- "ther" "in" "heav" -- "en" _ _ "Hal" -- "lowed" "be" "your" "name" "Your" _ "kin" -- "gdom" "come" "Your" "will" "be" "done" "On" "earth" "as" "it" "is" "in" "heav" -- "en" "Give" "us" "to" -- "day" "our" "dai" -- "ly" "bread" "And" "for" -- "give" "us" "our" "debts" "As" _ "we" "al" -- "so" "have" "for" -- "giv" -- "en" "our" "deb" -- "tors" "And" "lead" "us" "not" "in" -- "to" "temp" -- "ta" -- "tion" _ "But" "de" -- "liv" -- "er" "us" "from" "e" -- "vil" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "A" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "men" }
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
