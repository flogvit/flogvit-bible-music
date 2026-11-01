\version "2.24.0"
\header {
  title = "He Was Despised"
  subtitle = "Isaiah 53:3"
  tagline = ##f
  copyright = \markup \small \wordwrap { "Melody" "and" "chords" "from" "the" "score" "YuE2" "generated" "the" "song" "from" "(score.abc)." "Lyrics" "placed" "syllable" "by" "syllable" "against" "the" "recording" "with" "Whisper," "which" "heard" "79" "of" "79" "words." "10" "of" "12" "lyric" "lines" "sit" "clearly" "on" "their" "notes;" "2" "are" "uncertain" "and" "printed" "in" "grey" "italics." "Bible" "text:" "Open" "Source" "English" "(OSEN)," "CC" "BY" "4.0," "from" "SBLGNT" "and" "tanach.us." }
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
  \clef treble \key g \minor \tempo 4 = 75
  \time 4/4 R1*1 | R1*1 | R1*1 | \sectionLabel "Verse 1" r2 r8 d''8 d''4 | d''4 r4. c''16 bes'16 c''8 bes'16 a'16 | g'4 r2 r8. g'16 | g'4 g''4 f''4 c''8. bes'16 | c''8. d''8. es''8 d''4 r4 | r4 c''8 d''8 es''4 d''8 c''8 | bes'4 a'8 bes'8 c''4 d''4 | r8 g'8 a'8 bes'8 c''8. bes'16 a'8 g'8 | a'4 bes'4 a'4 r4 | \sectionLabel "Chorus" d'''4. bes''8 a''4. f''8 | g''4 a''4 bes''4 r8 bes''8 | a''4 g''2 a''4 | bes''2 a''2 | R1*1 | R1*1 | R1*1 | \sectionLabel "Verse 2" d''4. d''8 d''8. c''16 bes'8 a'8 | a'8 a'16 g'16 g'4 r2 | g'4 g''4 f''8. c''16 c''8. bes'16 | c''8 d''16 d''2 r4 d''16 | es''8. d''16 es''8. d''16 es''8 bes''4 a''8 | g''8 a''8 g''8 g''4. r8 g''8 | g''4 a''4 bes''4 a''8 g''8 | a''1 | \sectionLabel "Chorus" d'''4. bes''8 a''4. f''8 | g''4 a''4 bes''4 r8 bes''8 | a''4 g''2 a''4 | bes''2 a''2 | R1*1 | R1*1 | R1*1 | \sectionLabel "Interlude" R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 |
  \bar "|."
}
harmony = \chordmode { g1*3:m g1*3:m es1*1/2 f1*1/2 bes1 c1:m g1:m es1 d1 g1*1/2:m f1*1/2 es1*1/2 g1*1/2:m es1 d1*2 g1*2:m g1*2:m es1*1/2 f1*1/2 bes1 c1:m g1:m es1 d1 g1*1/2:m f1*1/2 es1*1/2 g1*1/2:m es1 d1*4 g1*14:m }
words = \lyricmode { "He" "was" "de" -- "spised" "and" "re" -- "ject" -- "ed" "by" "men" "A" "man" "of" "sor" -- "rows," "ac" -- "quaint" -- "ed" "with" "grief" "And" "as" "one" "from" "whom" "men" "hide" "their" "fa" -- "ces" "He" "was" "de" -- "spised," "and" "we" "es" -- "teemed" "him" "not" "Sure" -- "ly" "he" "has" "borne" "our" "griefs" "And" "car" -- "ried" "our" "sor" -- "rows" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "He" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "was" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "pierced" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "for" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "our" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "trans" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "gres" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "sions" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "He" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "was" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "crushed" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "for" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "our" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "in" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "iq" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "ui" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "ties" "Up" -- "on" "him" "was" "the" "chas" -- "ti" -- "se" -- "ment" "that" "brought" "us" "peace" "And" "by" "his" "wounds" "we" "are" "healed" "Sure" -- "ly" "he" "has" "borne" "our" "griefs" "And" "car" -- "ried" "our" "sor" -- "rows" }
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
