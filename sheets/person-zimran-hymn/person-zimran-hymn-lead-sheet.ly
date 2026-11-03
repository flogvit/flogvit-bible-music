\version "2.24.0"
\header {
  title = "Sent Eastward"
  subtitle = "Genesis 25:1–2; 25:5–6; 25:7–10; 1 Chronicles 1:32–33"
  tagline = ##f
  copyright = \markup \small \wordwrap { "Melody" "and" "chords" "from" "the" "score" "YuE2" "generated" "the" "song" "from" "(score.abc)." "Lyrics" "placed" "syllable" "by" "syllable" "against" "the" "recording" "with" "Whisper," "which" "heard" "99" "of" "101" "words." "19" "of" "21" "lyric" "lines" "sit" "clearly" "on" "their" "notes;" "2" "are" "uncertain" "and" "printed" "in" "grey" "italics." }
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
  \clef treble \key es \major \tempo 4 = 76
  \time 4/4 R1*1 | R1*1 | R1*1 | R1*1 | \sectionLabel "Verse 1" r2. es''8 d''8 | es''4 es''8 f''8 g''4 bes''4 | f''4 r2 r8 es''8 | es''4. d''8 c''4 bes'4 | bes'4 r2 r8 d''8 | es''4 es''8 f''8 g''4 bes''4 | f''4 r2 g''8 f''8 | es''4. d''8 c''4 es''4 | es''4 r2. | \sectionLabel "Verse 2" es''8 f''16 g''8. as''8 bes''4 es''4 | f''2 r4. es''8 | c'''4. bes''8 g''4 f''4 | es''4 r2 r8 bes'8 | es''4 es''8 f''8 g''4 bes''4 | f''2 r4 g''8 f''8 | es''2 c''4 es''4 | es''2 r2 | R1*1 | \sectionLabel "Verse 3" es''8 d''16 es''8. f''8 g''4 bes''4 | f''2 r4. es''8 | es''4. d''8 c''4 bes'4 | bes'4 r4. bes'8 es''8 d''8 | es''4. f''8 g''4 bes''4 | f''2 r2 | es''4. d''8 c''4 es''4 | \sectionLabel "Verse 4" es''2 r4. es''8 | c'''4. bes''8 c'''4 bes''4 | g''2 r4. g''8 | g''4 g''4 f''4. g''8 | es''16 d''16 c''4 r4. bes'4 | c''4. d''8 es''4 bes''4 | g''4 r2 g''8 f''8 | es''2 c''4 es''4 | \sectionLabel "Verse 5" es''2 r4. bes''8 | c'''4. bes''8 c'''4 bes''4 | g''2 r4 g''8 f''8 | g''4 g''4 f''4. g''8 | es''16 d''16 c''4 r2 r8 | c''8 d''8 es''8 d''8 es''8 f''8 g''8 as''8 | g''2 f''4 es''4 | es''2 r2 | \sectionLabel "Outro" r4 bes'4 c''4 es''4 | bes''2 f''2 | es''1 | R1*1 | R1*1 | R1*1 | R1*1 |
  \bar "|."
}
harmony = \chordmode { s1*7/8 es1*25/8 es1*2 bes1 as1 es1*2 bes1 as1 es1 es1 bes1 c1:m as1 es1 bes1 as1 es1*2 es1 bes1 as1 es1*2 bes1 as1 es1 as1 es1 g1:7/b c1:m as1 es1 as1*1/2 bes1*1/2 es1 as1 es1 g1:7/b c1:m as1 es1*1/2 bes1*1/2 as1 as1*3/2 bes1*1/2 es1*5 }
words = \lyricmode { "Ab" -- "ra" -- "ham" "took" "an" -- "oth" -- "er" "wife" "Whose" "name" "was" "Ke" -- "tu" -- "rah" "She" _ "bore" "him" "Zim" -- "ran" "first" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "Jok" -- _ \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "shan" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "and" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "Me" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "dan" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "there" "Mi" -- _ "dian" "and" "Ish" -- "bak" "too" "And" _ "Shuah" "round" "the" "hearth" "Six" "sons" "by" "Ke" -- "tu" -- "rah" "born" "In" "the" "an" -- "cient" "earth" _ "Ab" -- "ra" -- "ham" "gave" "ev" -- "ery" -- "thing" "To" "I" -- "saac" "as" "his" "heir" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "But" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "to" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "the" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "sons" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "of" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "con" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "cu" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "bines" "Gifts" "he" "did" "not" "spare" "While" "he" "was" "still" "a" -- "live" "He" _ "sent" "them" "far" "a" -- "way" _ "From" "I" -- "saac" "and" "his" "son" "To" "the" "land" "of" "the" "day" "He" "breathed" "his" "last" "and" "died" "Old" "and" "sat" -- "is" -- "fied" "with" "life" _ _ "Gath" -- "ered" "to" "his" "peo" -- "ple" "In" "the" "cave" "of" "his" "life" "Sent" "east" -- "ward" "to" "the" "land" }
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
