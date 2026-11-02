\version "2.24.0"
\header {
  title = "Our Dwelling Place"
  subtitle = "Psalm 90"
  tagline = ##f
  copyright = \markup \small \wordwrap { "Melody" "and" "chords" "from" "the" "score" "YuE2" "generated" "the" "song" "from" "(score.abc)." "Lyrics" "placed" "syllable" "by" "syllable" "against" "the" "recording" "with" "Whisper," "which" "heard" "100" "of" "102" "words." "All" "16" "lyric" "lines" "sit" "on" "their" "notes." "Bible" "text:" "Open" "Source" "English" "(OSEN)," "CC" "BY" "4.0," "from" "SBLGNT" "and" "tanach.us." }
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
  \clef treble \key es \major \tempo 4 = 75
  \time 4/4 \sectionLabel "Intro" R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | \sectionLabel "Verse 1" es'2 g'4 bes'4 | bes'4. c''8 bes'4 g'16 f'16 es'8 | es'4 r8 es'8 g'4. f'8 | es'4 c'4 bes4 r4 | r4. es'8 g'4 bes'4 | bes'4. c''8 bes'4 g'16 f'16 es'8 | es'4 r8 g'8 f'4. es'8 | \time 2/4 es'4 f'4 | \time 4/4 es'2 r2 | \sectionLabel "Verse 2" r4. es'8 g'4 bes'4 | bes'4. c''8 bes'4 g'16 f'16 es'8 | es'4 r8 es'8 g'4. f'8 | es'4 c'4 bes4 r4 | r4. es'8 g'4 bes'4 | bes'4. c''8 bes'4 g'16 f'16 es'8 | es'4 r8 g'8 f'8 es'16 es'8. es'16 es'16 | \time 2/4 es'8. es'16 ~ es'8 f'8 | \time 4/4 es'2 r2 | \sectionLabel "Verse 3" r4. es'8 g'4 bes'4 | bes'4. c''8 bes'4 g'16 f'16 es'8 | es'4 r8 es'8 g'4. f'8 | es'4 c'4 bes2 | r4. es'8 g'4 bes'4 | bes'4. c''8 bes'4 g'16 f'16 es'8 | es'4 r8 g'8 f'4. es'8 | \time 2/4 es'4 f'4 | \time 4/4 es'2 r2 | R1*1 | \sectionLabel "Verse 4" es'2 g'4 bes'4 | bes'4. c''8 bes'4 g'16 f'16 es'8 | es'4 r8 es'8 g'4. f'8 | es'4 c'4 bes4 r4 | r4. es'8 g'4 bes'4 | bes'4. c''8 bes'4 g'16 f'16 es'8 | es'4 r8 g'8 f'4. es'8 | \time 2/4 es'4 f'8. es'16 | \time 4/4 es'2 r2 | R1*1 | R1*1 |
  \bar "|."
}
harmony = \chordmode { s1*3/4 es1*5/4 bes1/d c1:m as1*1/2 bes1*1/2 es1 bes1/d c1:m as1*1/2 bes1*1/2 es1 bes1/d c1*1/2:m bes1*1/2 as1*1/4 bes1*1/4 es1 es1 bes1/d c1:m as1*1/2 bes1*1/2 es1 bes1/d c1*1/2:m bes1*1/2 as1*1/4 bes1*1/4 es1 es1 bes1/d c1:m as1*1/2 bes1*1/2 es1 bes1/d c1*1/2:m bes1*1/2 as1*1/4 bes1*1/4 es1*2 es1 bes1/d c1:m as1*1/2 bes1*1/2 es1 bes1/d c1*1/2:m bes1*1/2 as1*1/4 bes1*1/4 es1*3 }
words = \lyricmode { "Lord," "you" "have" "been" "our" "d" -- "welling" "place" _ _ "Through" "all" "the" "years" "gone" "by" "Be" -- "fore" "the" "moun" -- "tains" "rose" "in" "space" _ _ "You" "were," "and" "you" "are" "nigh" "You" "turn" _ "us" "back" "to" "dust" "a" -- "gain" _ "Re" -- "turn," "you" "sons" "of" "men" "A" _ "thou" -- "sand" "years" "are" "in" "your" "sight" _ "Like" "yes" -- "ter" -- "day," "like" "a" "watch" "in" "the" "night" "We" _ "flour" -- "ish" "like" "the" "morn" -- "ing" "grass" _ "By" "eve" -- "ning" "it" "is" "dry" "So" _ "teach" "us" "how" "our" "days" "will" "pass" _ "That" "wise" "our" "hearts" "may" "lie" "Lord," "you" "have" "been" "our" "d" -- "welling" "place" _ _ "Through" "all" "the" "years" "gone" "by" "Be" -- "fore" "the" "moun" -- "tains" "rose" "in" "space" _ _ "You" "were," "and" "you" "are" "nigh" _ }
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
