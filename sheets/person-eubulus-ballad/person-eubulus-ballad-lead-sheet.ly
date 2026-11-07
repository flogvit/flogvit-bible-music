\version "2.24.0"
\header {
  title = "Eubulus Sends You Greetings"
  subtitle = "2 Timothy 4:21; 4:6–21; 4:10–21"
  tagline = ##f
  copyright = \markup \small \wordwrap { "Melody" "and" "chords" "from" "the" "score" "YuE2" "generated" "the" "song" "from" "(score.abc)." "Lyrics" "placed" "syllable" "by" "syllable" "against" "the" "recording" "with" "Whisper," "which" "heard" "111" "of" "119" "words." "19" "of" "22" "lyric" "lines" "sit" "clearly" "on" "their" "notes;" "3" "are" "uncertain" "and" "printed" "in" "grey" "italics." }
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
  \clef treble \key bes \major \tempo 4 = 72
  \time 4/4 \sectionLabel "Intro" R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | \sectionLabel "Verse 1" r4 d'16 f'16 f'4 bes'8 c''8 a'8 ~ | a'8 r4 f'16 f'8. r4. | r4 es'16 d'16 es'4 d'16 es'8. d'16 es'16 | d'16 d'16 d'4 r2 r8 | r8. bes16 d'16 f'8 f'8. bes'4 c''8 ~ | c''4. a'16 g'16 f'4 r4 | r4. r16 bes16 es'8 d'16 c'8 bes16 bes8 ~ | bes8 r2 r8 r4 | \sectionLabel "Chorus" r4 d''8 d''16 d''8. c''8 bes'8 c''8 ~ | c''8 d''4 r2 r8 | r8. f'16 g'16 bes'8 bes'8. g'8 f'8 c''8 ~ | c''8 d''4 r4. r4 | r4 d''8 d''16 d''8. c''16 c''8. bes'16 c''16 ~ | c''16 d''8. r4 d''8 c''16 c''8 bes'16 bes'16 bes'16 ~ | bes'2 ~ bes'8. r4 r16 | R1*1 | \sectionLabel "Verse 2" r4 d'16 f'8 d'16 f'4 r16 d'16 f'16 d'16 | g'8 f'16 f'8. r2 r8 | r4 es'16 es'8 d'16 es'4. es'16 d'16 | es'8 d'16 d'8. r2 r8 | r4 d'16 f'8 f'8. bes'4 c''8 ~ | c''4 a'8 g'16 f'8. r4. | r4. es'8 es'4 d'8 c'8 ~ | c'8 bes4 r4. r4 | \sectionLabel "Chorus" r4 d''8 d''16 d''8. c''8 bes'8 c''8 ~ | c''8 d''4 r2 r8 | r8. f'16 g'16 bes'8 bes'8. g'8 f'8 c''8 ~ | c''8 d''4 r4. r4 | r4 d''8 d''16 d''8. c''16 c''8. bes'16 c''16 ~ | c''16 d''8. r4 d''8 c''16 c''8 bes'16 bes'16 bes'16 ~ | bes'2 ~ bes'8. r4 r16 | R1*1 | \sectionLabel "Bridge" r4. bes'16 g'16 bes'8 g'16 bes'8 bes'8 c''16 | c''16 r8. a'8 g'16 f'8. f'8 r4 | r2 bes'8 g'16 bes'8. g'16 c''16 ~ | c''8. r16 a'8 g'16 f'8. r4. | r4. bes'16 g'16 bes'8. bes'8 c''8. ~ | c''16 r16 g'16 f'8. r2 r8 | r4. r16 bes16 es'8 d'16 c'8 bes16 bes8 ~ | bes8 r2 r8 r4 | \sectionLabel "Outro" r4 c''16 d''8 d''8. c''16 c''8 bes'16 bes'8 | c''8 d''4 r2 r8 | r4 g'16 bes'16 bes'4 g'8 f'8 c''8 ~ | c''8 bes'2 r4. | R1*1 |
  \bar "|."
}
harmony = \chordmode { s1*7/8 bes1*9/8 d1:m7 es1 es1:m bes1 d1:m7 es1 bes1*2 d1:m7 es1 bes1*3/4 f1*1/4/a g1:m d1:m7 es1 bes1*3/4 f1*1/4/a g1:m d1:m7 es1*2 bes1 d1:m7 es1 bes1*2 d1:m7 es1 bes1*3/4 f1*1/4/a g1:m d1:m7 es1 bes1*3/4 f1*1/4/a g1:m d1:m7 es1*2 c1:m7 g1:m c1:m7 g1:m es1 f1 es1 bes1*3/4 f1*1/4/a g1:m d1:m7 es1*3 }
words = \lyricmode { "In" "the" "cold" "Ro" -- "man" "cell" "I" "wait" "Win" -- "ter" _ "comes" "be" -- "fore" "the" "day" "is" "done" "The" "world" "has" "turned" "its" "face" "a" -- "way" _ "But" "I" "have" "kept" "the" "faith" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "Eu" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "bu" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "lus" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "sends" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "you" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "greet" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "ings" "And" "so" "do" "Pu" -- "dens" "and" "Li" -- "nus" "Clau" -- "dia" _ "and" "all" "the" "broth" -- "ers" "Greet" -- "ing" "you" "from" "Rome" _ "De" -- "mas" "has" "gone" "to" "Thes" -- "sa" -- "lo" -- "ni" -- "ca" "Cres" -- "cens" "has" "gone" "to" "Ga" -- "la" -- "tia" _ "On" -- "ly" "Luke" "re" -- "mains" "with" "me" _ "Bring" "Mark" "for" "ser" -- "vice" "Eu" -- "bu" -- "lus" "sends" "you" "greet" -- "ings" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "And" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "so" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "do" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "Pu" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "dens" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "and" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "Li" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "nus" "Clau" -- _ "dia" "and" "all" "the" "broth" -- "ers" "Greet" -- "ing" "you" "from" "Rome" _ "At" _ _ "my" "first" "de" -- "fense" "no" "one" "stood" "by" "me" "Ev" -- "ery" -- "one" "a" -- "ban" -- "doned" "me" _ "But" _ "the" "Lord" "stood" "by" "me" "And" "gave" "me" "strength" "to" "speak" "Do" "your" "best" "to" "come" "be" -- "fore" "win" -- "ter" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "Eu" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "bu" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "lus" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "sends" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "you" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "greet" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "ings" }
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
