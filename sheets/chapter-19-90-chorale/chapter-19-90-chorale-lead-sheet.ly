\version "2.24.0"
\header {
  title = "Herre, du har vært vår bolig"
  subtitle = "Psalm 90"
  tagline = ##f
  copyright = \markup \small \wordwrap { "Melody" "and" "chords" "from" "the" "score" "YuE2" "generated" "the" "song" "from" "(score.abc)." "Lyrics" "placed" "syllable" "by" "syllable" "against" "the" "recording" "with" "Whisper," "which" "heard" "104" "of" "104" "words." "11" "of" "16" "lyric" "lines" "sit" "clearly" "on" "their" "notes;" "5" "are" "uncertain" "and" "printed" "in" "grey" "italics." "Bible" "text:" "Open" "Source" "English" "(OSEN)," "CC" "BY" "4.0," "from" "SBLGNT" "and" "tanach.us." }
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
  \clef treble \key bes \major \tempo 4 = 78
  \time 3/4 R1*3/4 | R1*3/4 | R1*3/4 | R1*3/4 | \sectionLabel "Verse 1" r2 r8 f'8 | f'4 bes'8 bes'4 c''8 | d''4 c''16 bes'16 bes'4 bes'8 | g'4 g'8 f'4 f'8 | d'4 r4. f'8 | f'4 bes'8 bes'4 c''8 | d''4 c''16 bes'16 bes'8 r8 bes'16 c''16 | d''4 c''8 c''4 bes'8 | bes'2 r4 | \sectionLabel "Verse 2" r2 r8 f'8 | f'4 bes'8 bes'4 c''8 | d''4 c''8 bes'8 r8 bes'8 | g'4 g'8 f'4 f'8 | d'8 c'8 bes4 r8 f'8 | f'4 bes'8 bes'4 c''8 | d''4 c''8 bes'8 r8 bes'8 | d''8 es''16 d''8. d''8 c''8. bes'16 | bes'2 r4 | \sectionLabel "Verse 3" r2 r8 f''8 | f''4 d''8 d''4 c''8 | c''4 bes'8 bes'8 r8 bes'8 | d''8 es''16 d''8. d''8 c''8. bes'16 | c''4. r4 f''8 | f''4 d''8 d''4 c''8 | c''4 bes'8 bes'4 bes'8 | g'4 a'8 bes'4 c''8 | \sectionLabel "Verse 4" d''2 r16 es''16 d''8 | c''2 r4 | r2 r8 f'8 | f'4 bes'8 bes'4 c''8 | d''4 c''8 bes'4 bes'8 | g'4 g'8 f'4 f'8 | d'4 r4. f'8 | f'4 bes'8 bes'4 c''8 | d''4 c''8 bes'8 r8 bes'16 c''16 | d''2 r16 es''16 d''8 | c''2 r4 | \time 7/8 r2 bes'8 d''4 ~ | \time 3/4 d''8 c''16 c''16 c''2 | \sectionLabel "Outro" bes'2. ~ | bes'4 r2 | R1*3/4 | R1*3/4 | R1*3/4 |
  \bar "|."
}
harmony = \chordmode { s1*5/8 bes1*13/8 g1*3/4:m7 bes1*9/4 es1*3/4 bes1*3/4 g1*3/2:m7 es1*1/4 f1*1/2:7 bes1*3/4 bes1*3/2 g1*3/4:m es1*3/4 bes1*3/2 g1*3/4:m es1*1/2 f1*1/4:7 bes1*3/4 bes1*3/4 g1*3/4:m es1*3/4 bes1*3/4 f1*3/4 g1*3/4:m es1*3/2 f1*9/4 bes1*3/4 g1*3/4:m es1*3/4 bes1*3/2 g1*3/4:m es1*3/4 f1*19/8 bes1*3/2 g1*3/4:m bes1*3/2 }
words = \lyricmode { "Lord," _ "you" "have" "been" "our" "d" -- "welling" "place" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "Through" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "ev" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "ery" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "age" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "and" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "year" "Be" -- "fore" _ "the" "moun" -- "tains" "came" "to" "birth" "You" "are" "God," "and" "you" "are" "here" "You" "turn" "us" "back" "to" "dust" "a" -- "gain" "You" "say," "Re" -- "turn," "and" "so" "we" "go" "A" "thou" -- "sand" "years" "are" "in" "your" "sight" "Like" "yes" -- "ter" -- "day," "gone" "long" "a" -- "go" "At" "morn" -- "ing" "grass" "is" "fresh" "and" "green" "By" "eve" -- "ning" "it" "is" "dry" "and" "gone" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "So" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "teach" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "us," \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "Lord," \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "to" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "count" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "our" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "days" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "And" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "give" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "us" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "hearts" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "of" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "wis" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "dom" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "Lord," \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "you" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "have" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "been" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "our" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "d" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "welling" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "place" "Through" "ev" -- "ery" "age" "and" "year" "Be" -- "fore" "the" "moun" -- "tains" "came" "to" "birth" _ _ \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "You" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "are" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "God," \skip 1 \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "and" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "you" \skip 1 \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "are" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "here" _ _ _ }
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
