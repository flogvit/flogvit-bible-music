\version "2.24.0"
\header {
  title = "Unto Us a Child Is Born"
  subtitle = "Isaiah 9:5"
  tagline = ##f
  copyright = \markup \small \wordwrap { "Melody" "and" "chords" "from" "the" "score" "YuE2" "generated" "the" "song" "from" "(score.abc)." "Lyrics" "placed" "syllable" "by" "syllable" "against" "the" "recording" "with" "Whisper," "which" "heard" "73" "of" "73" "words." "All" "13" "lyric" "lines" "sit" "on" "their" "notes." "Bible" "text:" "Open" "Source" "English" "(OSEN)," "CC" "BY" "4.0," "from" "SBLGNT" "and" "tanach.us." }
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
  \clef treble \key bes \major \tempo 4 = 120
  \time 4/4 R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | \sectionLabel "Verse 1" r2 r8 f'4 f'8 | f'4. bes'8 bes'4 c''4 | d''2 r4 d''4 | es''4. d''8 c''4 a'4 | g'4 f'4 r4 d'8 f'8 | g'4. g'8 a'4 bes'4 | f'2 r4 f'4 | es'2 bes'2 | bes'2 c''4 r4 | \sectionLabel "Chorus" d'''8. c'''8. d'''8 es'''8. d'''16 c'''8 r8 | d'''4 c'''4 d'''4 r4 | g''4. a''8 bes''4 g'''4 | f'''4 c'''4 es'''4 a''4 | bes''1 | \sectionLabel "Verse 2" r2 r8 f'8 f'8 f'8 | f'4 bes'4 bes'4 c''4 | d''2 r4 d''4 | es''4. d''8 c''4 a'4 | g'4 f'4 r4 d'8 f'8 | g'4. g'8 a'4 bes'4 | f'4 bes'4 d''4 r8 d''8 | es''8. d''8. c''8 bes'4 g'4 | c''1 ~ | c''2 r2 | \sectionLabel "Chorus" d'''8. c'''8. d'''8 es'''8. d'''16 c'''8 r8 | d'''4 c'''4 d'''4 r4 | g''4. a''8 bes''4 g'''4 | f'''4 c'''4 es'''4 a''4 | bes''1 | \sectionLabel "Outro" r2 r8 bes'8 c''8 d''8 | es''4. d''8 c''4 bes'4 | c''2 d''2 | c''4 bes'2. ~ | bes'4 r2. | R1*1 | R1*1 |
  \bar "|."
}
harmony = \chordmode { s1*7/8 bes1*9/8 es1*1/4 f1*1/4 bes1*1/4 f1*1/4/a bes1*3 es1*1/4 f1*1/4 bes1*1/4 f1*1/4/a bes1 bes1*3 c1*1/2:m f1*1/2 bes1 es1 bes1/d c1:m7 f1 bes1*5/4 f1*1/4 bes1*1/2 es1 f1 bes1 bes1*3 c1*1/2:m f1*1/2 bes1 es1 bes1/d c1:m7 f1*2 bes1*5/4 f1*1/4 bes1*1/2 es1 f1 bes1 bes1 es1 f1 bes1*4 }
words = \lyricmode { "For" "to" "us" "a" "child" "is" "born" "To" "us" "a" "son" "is" "giv" -- "en" "And" "the" "gov" -- "ern" -- "ment" "shall" "rest" "Up" -- "on" "his" "shoul" -- "ders" "Won" -- "der" -- "ful" "Coun" -- "se" -- "lor," "Mig" -- "hty" "God" "Ev" -- "er" -- "last" -- "ing" "Fa" -- "ther," "Prince" "of" "Peace" "Of" _ "the" "in" -- "crease" "of" "his" "reign" "And" "peace" "there" "is" "no" "end" -- "ing" "On" "the" "throne" "of" "Da" -- "vid" "he" "will" "rule" "With" "jus" -- "tice" "and" "right" -- "eous" -- "ness" "Won" -- "der" -- "ful" "Coun" -- "se" -- "lor," "Mig" -- "hty" "God" "Ev" -- "er" -- "last" -- "ing" "Fa" -- "ther," "Prince" "of" "Peace" "The" _ "zeal" "of" "the" "Lord" "of" "hosts" "will" "do" "this" }
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
