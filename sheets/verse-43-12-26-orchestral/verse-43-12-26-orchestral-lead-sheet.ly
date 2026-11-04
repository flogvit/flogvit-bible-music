\version "2.24.0"
\header {
  title = "Where I Am"
  subtitle = "John 12:26"
  tagline = ##f
  copyright = \markup \small \wordwrap { "Melody" "and" "chords" "from" "the" "score" "YuE2" "generated" "the" "song" "from" "(score.abc)." "Lyrics" "placed" "syllable" "by" "syllable" "against" "the" "recording" "with" "Whisper," "which" "heard" "169" "of" "170" "words." "18" "of" "19" "lyric" "lines" "sit" "clearly" "on" "their" "notes;" "1" "are" "uncertain" "and" "printed" "in" "grey" "italics." "Bible" "text:" "Open" "Source" "English" "(OSEN)," "CC" "BY" "4.0," "from" "SBLGNT" "and" "tanach.us." }
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
  \clef treble \key d \minor \tempo 4 = 75
  \time 4/4 R1*1 | R1*1 | R1*1 | \sectionLabel "Verse 1" r2 r4. a'8 | d''4 e''8 f''8 a''4 r8 g''16 f''16 | e''4 c''4 a'4 r4 | d''2 c''2 | c''4 bes'8 a'4. r8. a'16 | d''4 e''8 f''8 a''4. g''8 | e''4 c''4 a'4 c''8 d''8 ~ | d''4. r2 r8 | r4 d''8 e''8 f''4 bes''8 a''8 ~ | a''4 r4 d''8 e''8 f''8 a''8 ~ | a''8 g''4. r4. r16 c''16 | d''4 e''4 f''4. d''8 | cis''4 d''4 e''4 f''8. e''16 | d''1 | \sectionLabel "Pre-Chorus" r2. r8 d''8 | d''8 e''8 f''8 g''8 a''2 | g''8. f''16 e''4 d''4 c''4 | a'2 r2 | r2. r8 d''8 | d''8 e''8 f''8 g''8 a''2 | g''8. f''16 e''8. d''16 d''4 c''4 | d''1 ~ | \sectionLabel "Chorus" d''2 r4. d''8 | d'''8. c'''8. bes''8 a''4 f''4 | g''4 bes''4 a''16 g''16 f''16 e''16 d''4 | d''4 bes''4 a''8 r8 f''8 a''8 | g''8 f''8 e''8 d''8 f''4 e''8 d''8 | d'''8. c'''8. bes''8 a''8 g''16 f''16 f''4 | g''2 r8 f''8 e''8. c''16 | d''1 ~ | \sectionLabel "Verse 2" d''2 r4. a'8 | d''4 e''4 f''8 e''8 d''4 | e''8. e''8. f''8 g''4. r8 | f''8 g''8 a''8 bes''8 a''4 f''4 | e''4 d''4 cis''4. r8 | d''2 e''4 f''4 | g''8 a''4 a''8 c'''4. a''16 g''16 | g''8 a''8 a''2. ~ | \sectionLabel "Chorus" a''2. r8 d''8 | d'''8. c'''8. bes''8 a''4 f''4 | g''4 bes''4 a''16 g''16 f''16 e''16 d''4 | d''4 bes''4 a''8 r8 f''8 a''8 | g''8 f''8 e''8 d''8 f''4 e''8 d''8 | d'''8. c'''8. bes''8 a''8 g''16 f''16 f''4 | g''2 r8 f''8 e''8. c''16 | d''1 ~ | d''1 | \sectionLabel "Bridge" d'''4 d'''4 d'''8 c'''8 bes''8 a''8 | g''4 g''8 f''8 a''4 g''8 f''8 | d'''4 d'''8 c'''8 bes''8 a''8 g''8 f''8 | g''4 f''4 a''4 g''8 f''8 | d''2 r8 e''8 f''8 g''8 | g''4. f''4. e''4 | d''2 r4 f''8. e''16 | d''1 | \sectionLabel "Outro" d''4 bes''4 a''4 f''8 a''8 | g''8 f''8 e''8 d''8 f''4 e''4 | d''4 bes''4 a''4 f''8 a''8 | g''8 f''8 e''8 d''8 f''4 e''4 | d''4 bes''4 a''4 f''8 a''8 | g''1 | r2 r8 f''8 e''8. c''16 | \sectionLabel "Outro" d''1 ~ | d''2 r2 | R1*1 | R1*1 |
  \bar "|."
}
harmony = \chordmode { d1*1/2:m c1*1/2:6 bes1*1/2 f1*1/2/a g1:m a1*1/2:sus4 a1*1/2 d1:m a1:m/c bes1*1/2 c1*1/2 f1 d1:m a1:m/c bes1 g1:m d1:m c1 bes1 a1 d1:m d1:m bes1 c1 d1*2:m bes1 c1 d1:m d1:m bes1*1/2 f1*1/2 c1*1/2 d1*1/2:m bes1*1/2 f1*1/2 c1*1/2 d1*1/2:m bes1*1/2 f1*1/2 c1 d1:m d1*2:m c1 bes1 a1 bes1 c1 d1:m d1:m bes1*1/2 f1*1/2 c1*1/2 d1*1/2:m bes1*1/2 f1*1/2 c1*1/2 d1*1/2:m bes1*1/2 f1*1/2 c1 d1*2:m bes1 c1 bes1 c1 bes1 c1 d1*2:m bes1*1/2 f1*1/2 c1*1/2 d1*1/2:m bes1*1/2 f1*1/2 c1*1/2 d1*1/2:m bes1*1/2 f1*1/2 c1*2 d1*4:m }
words = \lyricmode { "The" _ "hour" "has" "come" "for" "the" "Son" "of" "Man" "to" "be" "glo" -- "ri" -- "fied" "A" "grain" "of" "wheat" "falls" "in" -- "to" "the" "earth" "and" "dies" "It" "re" -- "mains" "a" -- "lone" "if" "it" "does" "not" "break" "But" "if" "it" "dies," "it" "bears" "much" "fruit" "in" "the" "end" "Who" -- "ev" -- "er" "loves" "his" "life" "los" -- "es" "it" "in" "this" "world" "Who" -- "ev" -- "er" "hates" "his" "life" "keeps" "it" "for" "e" -- "ter" -- "nal" "life" "If" _ "a" -- "ny" -- "one" "serves" "me," "he" "must" "fol" -- "low" "me" _ _ "Where" "I" \skip 1 "am," "there" "my" "ser" -- "vant" "will" "be" "al" -- "so" "The" "Fa" -- "ther" "will" "hon" -- "or" "him" "who" "serves" "me" "here" "My" "soul" "is" "trou" -- "bled" "now," "what" "shall" "I" "say" "Fa" -- "ther," "save" "me" "from" "this" "hour" "of" "pain" "No," "for" _ "this" "pur" -- "pose" "I" "came" "to" "this" "hour" _ "If" _ "a" -- "ny" -- "one" "serves" "me," "he" "must" "fol" -- "low" "me" _ _ "Where" "I" \skip 1 "am," "there" "my" "ser" -- "vant" "will" "be" "al" -- "so" "The" "Fa" -- "ther" "will" "hon" -- "or" "him" "who" "serves" "me" "here" _ "Fa" -- "ther," _ "glo" -- "ri" -- "fy" "your" "name" "in" "this" "mo" -- "ment" "A" "voice" "came" "from" "heav" -- "en," "I" "have" "glo" -- "ri" -- "fied" "it" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "And" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "I" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "will" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "glo" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "ri" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "fy" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "it" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "a" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "gain," \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "said" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "the" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "voice" "Where" "I" "am," "there" "my" "ser" -- "vant" "will" "be" _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ \skip 1 \skip 1 \skip 1 \skip 1 }
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
