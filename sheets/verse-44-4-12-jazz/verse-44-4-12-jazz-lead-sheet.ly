\version "2.24.0"
\header {
  title = "No Other Name"
  subtitle = "Acts 4:12"
  tagline = ##f
  copyright = \markup \small \wordwrap { "Melody" "and" "chords" "from" "the" "score" "YuE2" "generated" "the" "song" "from" "(score.abc)." "Lyrics" "placed" "syllable" "by" "syllable" "against" "the" "recording" "with" "Whisper," "which" "heard" "194" "of" "196" "words." "25" "of" "26" "lyric" "lines" "sit" "clearly" "on" "their" "notes;" "1" "are" "uncertain" "and" "printed" "in" "grey" "italics." "Bible" "text:" "Open" "Source" "English" "(OSEN)," "CC" "BY" "4.0," "from" "SBLGNT" "and" "tanach.us." }
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
  \clef treble \key bes \major \tempo 4 = 73
  \time 4/4 \sectionLabel "Intro" R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | \sectionLabel "Verse 1" r8. bes'16 d''8 f''8 f''4 d''8 f''8 | g''8. f''8. bes'8 r2 | r8. bes'16 d''16 d''8 d''8. c''8 c''8 bes'8 | c''8. d''8. bes'8 r2 | r4 d''16 f''16 f''16 f''16 f''4 d''16 f''16 f''16 d''16 | g''8. f''8. bes'8 r4. bes'16 c''16 | d''4 d''8 f''8 ~ f''8 d''8 c''8 bes'8 | c''8. bes'16 bes'8 r2 r8 | r2 r8 bes''8 a''8 a''8 | \sectionLabel "Chorus" a''8 bes''16 bes''8. bes''16 a''16 ~ a''8 f''8 f''8 d''16 g''16 ~ | g''8. r2 r16 bes''16 a''8. | a''8. bes''8. a''8 ~ a''8 f''8 f''16 d''16 g''8 ~ | g''8 r2 d''8 c''8 bes'16 bes'16 ~ | bes'8. r16 bes''8 a''8 ~ a''8 f''4 d''16 f''16 ~ | f''16 g''8. r2 r8 bes'16 c''16 | d''8 d''16 d''8. f''8 ~ f''8 d''8 c''8 bes'16 bes'16 ~ | bes'8 r2. r8 | R1*1 | \sectionLabel "Verse 2" r8. bes'16 d''16 f''8 f''8. c''16 bes'8. bes'8 | g''8. f''8. bes'4 r4. | r16 bes'16 c''16 d''16 d''8 d''16 c''16 d''16 c''8. r4 | c''8 c''8 d''8 bes'4 r4. | r8. bes'16 d''16 f''8 f''8 f''8 f''4 r16 | g''8 f''4 bes'4 r4 r16 bes'16 | d''8. d''8. f''8 ~ f''4 d''8 c''8 ~ | c''8 c''8 bes'8 bes'4 r4. | \sectionLabel "Chorus" r2 r8 bes''8 a''8 a''8 | a''8 bes''16 bes''8. bes''16 a''16 ~ a''8 f''8 f''8 d''16 g''16 | g''8. r2 r16 bes''16 a''8. | a''8. bes''8. a''8 ~ a''8 f''8 f''16 d''16 g''8 ~ | g''4 r4. d''8 c''8 bes'16 bes'16 ~ | bes'8. r16 bes''8 a''8 ~ a''8 f''4 d''16 f''16 ~ | f''16 g''4 r2 r16 bes'16 c''16 | d''8 d''16 d''8. f''8 ~ f''8 d''8 c''8 bes'16 bes'16 ~ | bes'8. r2. r16 | \sectionLabel "Bridge" r8. bes'16 es''8 es''8 es''8 d''16 c''8 bes'16 bes'8 ~ | bes'8 bes'8 d''8 d''8 ~ d''8 c''8 r4 | r4 es''16 es''16 es''16 es''8. d''16 c''16 bes'8 bes'8 | bes'8. d''8. d''16 c''16 ~ c''8. r4 r16 | r4 d''16 es''16 es''16 es''8. d''8 c''8 bes'8 ~ | bes'4 d''8 d''8 ~ d''16 c''8. r8. bes'16 | d''8. c''8. bes'4. bes'8 bes'16 d''16 | \sectionLabel "Chorus" d''4 c''8 bes'4 bes''8 a''8 a''8 | a''8 bes''16 bes''8. bes''16 a''16 ~ a''8 f''8 f''8 d''16 g''16 ~ | g''8. r2 r16 bes''16 a''8. | a''8. bes''8. a''8 ~ a''8 f''8 f''16 d''16 g''8 ~ | g''4 r4. d''8 c''8 bes'16 bes'16 ~ | bes'8. r16 bes''8 a''8 ~ a''8 f''4 d''16 f''16 ~ | f''16 g''4 r2 r16 bes'16 c''16 | d''8 d''16 d''8. f''8 ~ f''8 d''8 c''8 bes'16 bes'16 ~ | \sectionLabel "Outro" bes'8. r2 r8. bes'8 | \time 9/8 d''8 d''16 d''8. f''8 ~ f''4 d''8 c''16 c''16 bes'16 bes'32 r32 | \time 4/4 r2 r8 d''8 c''8 bes'8 | d''4. c''16 bes'16 ~ bes'8 bes'4 r8 | R1*1 |
  \bar "|."
}
harmony = \chordmode { s1*3/4 bes1*5/4 es1 g1:m7 es1 bes1 es1 g1:m7 es1 bes1 es1 g1*1/2:m7 f1*1/2 es1*2 bes1*1/2 f1*1/2 es1 g1*1/2:m7 f1*1/2 es1 g1*1/2:m7 f1*1/2 es1 g1*1/2:m7 f1*1/2 es1*2 bes1 es1 g1:m7 es1 bes1 es1 g1*1/2:m7 f1*1/2 es1 es1 bes1*1/2 f1*1/2 es1 g1*1/2:m7 f1*1/2 es1 g1*1/2:m7 f1*1/2 es1 g1*1/2:m7 f1*1/2 es1 c1:m7 g1*1/2:m7 f1*1/2 c1:m7 g1*1/2:m7 f1*1/2 c1:m7 g1*1/2:m7 f1*1/2 es1 es1 g1*1/2:m7 f1*1/2 es1 g1*1/2:m7 f1*1/2 es1 g1*1/2:m7 f1*1/2 es1 g1*1/2:m7 f1*1/2 es1 g1*1/2:m7 f1*5/8 es1 g1*1/2:m7 f1*3/2 }
words = \lyricmode { \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "Ex" -- _ \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "am" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "ined" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "for" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "a" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "good" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "deed" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "done" \skip 1 \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "to" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "day" "A" "crip" -- "pled" "man" "now" "healed" "and" \skip 1 "stands" "up" "straight" _ _ "Let" "it" "be" "known" "to" "all" "of" "Is" -- "rael" "By" "the" "name" "of" "Je" -- "sus" "Christ" "of" \skip 1 "Na" -- "za" -- "reth" "Whom" "you" "cru" -- "ci" -- "fied" "and" "God" "raised" "from" "the" "dead" "This" "man" "stands" "be" -- "fore" "you" "ful" -- "ly" "healed" "He" "is" "the" "stone" "you" "buil" -- "ders" "re" -- "ject" -- "ed" "Now" "the" "cor" -- "ner" -- "stone" "where" "our" "hope" "is" "met" "There" "is" "sal" -- "va" -- "tion" "in" "no" "one" "else" "No" "oth" -- "er" "name" "un" -- "der" "heav" -- "en" "giv" -- "en" "to" "men" "By" "which" "we" "must" "be" "saved" "from" "our" "sin" "The" "coun" -- "cil" "sees" "their" "bold" -- "ness" "is" "real" "Whom" "you" "cru" -- "ci" -- "fied" "and" "God" "raised" "from" "the" "dead" "This" "man" "stands" "be" -- "fore" "you" "ful" -- "ly" "healed" "He" "is" "the" "stone" "you" "buil" -- "ders" "re" -- "ject" -- "ed" "Now" "the" "cor" -- "ner" -- "stone" "where" "our" "hope" "is" "met" "A" -- "mazed" "by" "or" -- "di" -- "na" -- "ry" "men" "who" "knew" "Je" -- "sus" "See" -- "ing" _ _ "the" "healed" "man" "they" "have" "no" "re" -- "ply" "Or" -- "dered" "to" "leave" "and" "con" -- "fer" "to" -- "geth" -- "er" "The" "truth" "re" -- "mains" "for" _ "the" "world" "to" "see" _ "Whom" "you" "cru" -- "ci" -- "fied" "and" "God" "raised" "from" "the" "dead" "This" "man" "stands" "be" -- "fore" "you" "ful" -- "ly" "healed" "He" "is" "the" "stone" "you" "buil" -- "ders" "re" -- "ject" -- "ed" "Now" "the" "cor" -- "ner" -- "stone" "where" "our" "hope" "is" "met" "No" "oth" -- "er" "name" "un" -- "der" "heav" -- "en" _ _ "By" "which" "we" "must" "be" "saved" _ }
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
