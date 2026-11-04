\version "2.24.0"
\header {
  title = "While It Is Day"
  subtitle = "John 9:4"
  tagline = ##f
  copyright = \markup \small \wordwrap { "Melody" "and" "chords" "from" "the" "score" "YuE2" "generated" "the" "song" "from" "(score.abc)." "Lyrics" "placed" "syllable" "by" "syllable" "against" "the" "recording" "with" "Whisper," "which" "heard" "173" "of" "174" "words." "27" "of" "28" "lyric" "lines" "sit" "clearly" "on" "their" "notes;" "1" "are" "uncertain" "and" "printed" "in" "grey" "italics." "Bible" "text:" "Open" "Source" "English" "(OSEN)," "CC" "BY" "4.0," "from" "SBLGNT" "and" "tanach.us." }
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
  \time 4/4 R1*1 | R1*1 | R1*1 | R1*1 | \sectionLabel "Verse 1" r2 r8 f'8 f'4 | f'4 d'8 es'4 d'4 d'8 ~ | d'8 r2 bes8 d'8 f'8 | g'4. f'4 d'4 c'8 ~ | c'8 r2. d'16 f'16 | g'8 g'4 a'4 bes'4 bes'8 ~ | bes'8 r4 bes8 d'4 f'8 f'8 ~ | f'4. d'4 c'4 r8 | \sectionLabel "Verse 2" r2 r8 bes8 d'16 f'8. | f'4. es'4 d'4 d'8 ~ | d'16 c'16 bes16 r4. r16 bes8 d'8 f'8 | g'4. f'4 d'4 c'8 ~ | c'8 r2. r16 bes16 | g'8 g'4 a'4. bes'8 bes'8 ~ | bes'8 d'4 d'8 r8 bes8 d'8 f'8 | g'4. a'4 bes'4 c''8 ~ | \sectionLabel "Chorus" c''4. r8 r4 d''8 f''8 | f''4 f''8 es''4 d''4 d''8 ~ | d''8 r2 bes'8 d''8 f''8 | g''4. f''4 d''4 c''8 ~ | c''4 r2 d''8 f''8 | g''8 g''4 a''4 bes''4 bes''8 ~ | bes''8 r4 bes'8 d''8. es''8. f''8 | f''4. d''8. c''16 c''4. | \sectionLabel "Verse 3" r2 r8. bes16 d'16 f'8. | f'4 f'8 es'4 d'4 d'8 ~ | d'8 r2 bes8 d'8 f'8 | g'4. f'4 d'4 c'8 ~ | c'8 r2. bes8 | g'8 g'8 g'8 a'4 bes'4 bes'8 ~ | bes'8 r4. d'8. es'8. f'8 | f'4. d'4 c'4 r8 | \sectionLabel "Chorus" r2 r4 d''8 f''8 | f''4 f''8 es''4 d''4 d''8 | d''8 r2 bes'8 d''8 f''8 | g''4. f''4 d''4 c''8 ~ | c''8 r2 r8 d''8 f''8 | g''8 g''4 a''4 bes''4 bes''8 ~ | bes''8 r4 bes'8 d''8. es''8. f''8 | f''4. d''8. c''16 c''4. | \sectionLabel "Bridge" r2 r4. bes8 | g'8 g'16 g'8. a'16 a'8. bes'4 bes'8 | bes'8 f'16 f'16 f'8 d'16 d'8. r4 bes16 bes16 | g'4. a'4 bes'4 bes'8 ~ | bes'8 r2 bes8 d'8 f'8 | f'4. d'4 c'4 c'8 | \sectionLabel "Outro" r2 r4. bes16 bes16 | g'4. a'4 bes'4 bes'8 ~ | bes'8 r4 bes8 d'4 f'4 | f'4. d'4 c'4 c'8 | R1*1 | f'4 f'8 es'4 d'4 d'8 | r2 r8 bes8 d'8 f'8 | g'4. f'4. d'16 c'16 c'8 ~ | c'8 r2. r8 | R1*1 | R1*1 | R1*1 |
  \bar "|."
}
harmony = \chordmode { s1*7/8 bes1*25/8 bes1*3 es1 f1 es1 g1:m7 es1 f1*1/2:sus4 f1*1/2 bes1*2 es1 f1 es1 g1:m es1 f1*1/2:sus4 f1*1/2 bes1*2 es1 f1 g1*2:m es1 f1*1/2:sus4 f1*1/2 bes1*2 es1 f1 es1 g1:m es1 f1*1/2:sus4 f1*1/2 bes1*2 es1 f1 g1*2:m es1 f1*1/2:sus4 f1*1/2 es1 g1:m7 es1 g1:m es1 f1*1/2:sus4 f1*1/2 es1 g1:m es1 f1*1/2:sus4 f1*1/2 bes1 g1:m es1 f1 bes1*3 }
words = \lyricmode { "He" "passed" "by" "and" "saw" "a" "man" "Blind" "from" "his" "ear" -- "li" -- "est" "days" "The" "dis" -- "ci" -- "ples" "stood" "and" "asked" "Who" "sinned" "to" "cause" "such" "pain" "Nei" -- "ther" _ "this" "man" "nor" "his" "par" -- "ents" "Did" _ "sin" "to" "bring" "this" "state" "It" "hap" -- "pened" "so" "the" "works" "of" "God" "Might" "be" "re" -- "vealed" "in" "his" "fate" "We" "must" "do" "the" "works" "of" "him" "Who" "sent" "me" "while" "it" "is" "day" "Night" "is" "com" -- "ing" "when" "no" "one" "Can" _ "work" "in" "the" "fad" -- "ing" "light" "As" "long" "as" "I" "am" "in" "the" "world" "I" "am" "the" "light" "of" "the" "world" "He" "spat" "on" "the" "ground" "and" "made" "Mud" "with" "his" "sa" -- "li" -- "va" "poured" "We" "must" "do" "the" "works" "of" "him" "Who" "sent" "me" "while" "it" "is" "day" "Night" "is" "com" -- "ing" "when" "no" "one" "Can" _ "work" "in" "the" "fad" -- "ing" "light" "He" "spread" "it" "on" "the" "man's" "eyes" "And" "told" "him" "to" "go" "and" "wash" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "In" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "the" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "pool" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "of" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "Si" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "loam" "Which" "means" "the" "one" "who" "was" "sent" "So" "the" "man" "went" "and" "washed" "And" "came" "back" "see" -- "ing" "the" "light" "Work" "while" "it" "is" "day" "Be" -- "fore" "the" "night" "ar" -- "rives" _ _ }
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
