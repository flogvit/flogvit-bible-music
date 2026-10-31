\version "2.24.0"
\header {
  title = "Nothing but Joy"
  subtitle = "James 1:2–3"
  tagline = ##f
  copyright = \markup \small \wordwrap { "Melody" "and" "chords" "from" "the" "score" "YuE2" "generated" "the" "song" "from" "(score.abc)." "Lyrics" "placed" "syllable" "by" "syllable" "against" "the" "recording" "with" "Whisper," "which" "heard" "152" "of" "152" "words." "21" "of" "22" "lyric" "lines" "sit" "clearly" "on" "their" "notes;" "1" "are" "uncertain" "and" "printed" "in" "grey" "italics." "Bible" "text:" "Open" "Source" "English" "(OSEN)," "CC" "BY" "4.0," "from" "SBLGNT" "and" "tanach.us." }
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
  \clef treble \key bes \major \tempo 4 = 76
  \time 3/4 \sectionLabel "Intro" R1*3/4 | R1*3/4 | R1*3/4 | R1*3/4 | \sectionLabel "Verse 1" bes'16 c''16 d''4 d''16 es''8. f''8 | f''4 d''8 c''16 bes'8. r16 bes'16 | bes'16 c''16 d''4 d''16 es''8. f''16 f''16 ~ | f''8. r16 d''16 c''4 r16 bes'16 g'16 | g'8 r4 g''8 a''8 bes''16 f''16 ~ | f''8 d''4 c''8 bes'8 c''8 | r4 r16 bes'16 es''8 d''8 c''16 c''16 ~ | c''8 bes'8 bes'16 d''8. c''8 bes'16 bes'16 ~ | bes'8 r2 r8 | \sectionLabel "Chorus" r4. d''16 es''8. f''8 | d''4. d''16 es''8. f''8 | f''4 r8 d''16 es''16 f''8 d''16 g''16 ~ | g''8. r16 f''4 d''8 c''16 c''16 ~ | c''8 bes'8 r8 d''16 es''8. f''8 | d''4. d''16 es''8. f''8 | f''4 r8 d''8 es''8 d''8 | c''8. bes'16 d''4 c''16 bes'8 c''16 ~ | c''8 bes'4 r4. | \sectionLabel "Verse 2" r2 bes'8 c''8 | d''8 f''4 f''16 bes''8. a''8 | a''4 g''16 f''8. d''8 f''8 | g''8 f''4 d''4 c''16 c''16 ~ | c''8 bes'8 d''8 d''8 r4 | d''8 f''4 f''16 bes''16 bes''8 a''8 | a''8. g''8. f''8. d''16 f''8 | g''4 f''4 d''8 c''16 c''16 ~ | c''8 bes'4 bes'4 r8 | \sectionLabel "Chorus" r4. d''16 es''8. f''8 | d''4. d''16 es''8. f''8 | f''4 r8 d''16 es''16 f''8 d''16 g''16 ~ | g''8. r16 f''4 d''8 c''16 c''16 ~ | c''8 bes'8 r8 d''16 es''8. f''8 | d''4. d''16 es''8. f''8 | f''4 r8 d''8 es''8 d''8 | c''8. bes'16 d''4 c''16 bes'8 c''16 ~ | c''8 bes'4 r4. | \sectionLabel "Bridge" r2 r8. bes'16 | g''16 a''16 bes''4 bes''8 a''4 | a''8 g''16 f''8. f''4 d''16 d''16 ~ | d''8 d''16 c''16 d''8 d''4 f''16 g''16 ~ | g''8 f''16 f''8. bes'4 r8 | g''8 a''8 bes''4 bes''16 c'''8. | a''8 g''8 f''8 f''8. d''16 f''8 | g''2 r4 | \time 3/8 r4 bes'16 c''16 ~ | \time 3/4 c''8 d''8 es''16 d''8. c''4 | \sectionLabel "Outro" r2 r8. bes'16 | d''8 es''8 f''8 f''4. ~ | f''4. r8 g''8 d''8 | d''8 c''4 r4. | r4. d''16 es''8. f''8 | d''4. d''16 es''8. f''8 | c''2. | bes'4 r2 | R1*3/4 | R1*3/4 | R1*3/4 |
  \bar "|."
}
harmony = \chordmode { bes1*1/4 bes1*1/2:maj7 es1*3/4:sus2 bes1*3/4:maj7 es1*3/4:sus2 bes1*3/4 f1*3/4/a g1*3/4:m f1*3/4/a es1*3/4 bes1*3/4/d c1*3/4:m7 f1*3/4:sus4 bes1*3/4 es1*3/4 bes1*3/4 f1*3/4/a g1*3/4:m7 es1*3/4 bes1*3/4 f1*3/4/a g1*3/4:m7 es1*3/4 es1*3/4 bes1*3/4 f1*3/4/a g1*3/4:m7 es1*3/4 bes1*3/4 f1*3/4/a g1*3/4:m7 es1*3/4 es1*3/4 bes1*3/4 f1*3/4/a g1*3/4:m7 es1*3/4 bes1*3/4 f1*3/4/a g1*3/4:m7 es1*3/4 es1*3/4 g1*3/4:m f1*3/4/a bes1*3/4 es1*3/4 g1*3/4:m f1*3/4/a es1*15/8 f1*3/4 g1*3/4:m bes1*3/4:maj7 es1*3/2 g1*3/4:m f1*3/4 es1*7/4 bes1*5/4 }
words = \lyricmode { "Con" -- "sid" -- "er" "it" "noth" -- "ing" "but" "joy," "my" "broth" -- "ers" "When" -- "ev" -- "er" "we" "fall" "in" -- "to" "trials" "of" "ev" -- "ery" "kind" "You" "know" "the" "test" -- "ing" "of" "your" "faith" "Pro" -- "du" -- "ces" "en" -- "du" -- "rance" "in" "our" "dai" -- "ly" "life" "Noth" -- "ing" "but" "joy," "noth" -- "ing" "but" "joy" "E" -- _ "ven" "when" "the" "trials" "come" "to" "find" "us" "Noth" -- "ing" "but" "joy," "noth" -- "ing" "but" "joy" "En" -- "du" -- "rance" "grows" "and" "our" "spir" -- "its" "bind" "us" "Let" "en" -- "du" -- "rance" "fin" -- "ish" "its" "ho" -- "ly" "work" "So" "that" "we" "may" "be" "ma" -- "ture" "and" "com" -- "plete" "Lack" -- "ing" "noth" -- "ing" "in" "this" "sa" -- "cred" "path" "Where" "our" "faith" "is" "test" -- "ed" "and" "made" "sweet" "Noth" -- "ing" "but" "joy," "noth" -- "ing" "but" "joy" "E" -- "ven" "when" "the" "trials" "come" _ "to" "find" "us" "Noth" -- "ing" "but" "joy," "noth" -- "ing" "but" "joy" "En" -- "du" -- "rance" "grows" "and" "our" "spir" -- "its" "bind" "us" "If" "a" -- "ny" "of" "you" "lacks" "wis" -- "dom," "ask" "God" "He" "gives" "gen" -- "er" -- "ous" -- "ly" "to" "all" "with" -- "out" "fault" "Ask" "in" "faith," "with" -- "out" "doubt" -- "ing" "or" "fear" "Like" "a" "wave," "do" "not" "let" "the" "wind" "halt" "Ma" -- "ture" "and" "com" -- "plete," "lack" -- "ing" "noth" -- "ing" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "Noth" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "ing" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "but" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "joy," \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "noth" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "ing" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "but" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "joy" _ }
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
