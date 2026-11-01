\version "2.24.0"
\header {
  title = "For God Alone My Soul Waits"
  subtitle = "Psalms 62:2"
  tagline = ##f
  copyright = \markup \small \wordwrap { "Melody" "and" "chords" "from" "the" "score" "YuE2" "generated" "the" "song" "from" "(score.abc)." "Lyrics" "placed" "syllable" "by" "syllable" "against" "the" "recording" "with" "Whisper," "which" "heard" "84" "of" "84" "words." "All" "13" "lyric" "lines" "sit" "on" "their" "notes." "Bible" "text:" "Open" "Source" "English" "(OSEN)," "CC" "BY" "4.0," "from" "SBLGNT" "and" "tanach.us." }
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
  \clef treble \key es \major \tempo 4 = 69
  \time 4/4 R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | \sectionLabel "Verse 1" r2 es'8. f'8. g'8 | g'2 r2 | r4. es'8 as'8. g'8. f'8 | f'4. es'4 r4. | r4. es'8 as'8. g'8. f'8 ~ | f'8 f'8 f'16 r16 f'4 es'8 r4 | r4. es'16 es'16 as'8. g'8. f'8 ~ | f'8 g'4 r8 f'8. f'8. g'8 | g'4. f'4 r4 es'8 | c''4. bes'4 r4 bes'8 | bes'8. bes'8. g'8 g'4. f'8 ~ | f'4 r2. | \sectionLabel "Chorus" r2 es''8 f''8 g''8 f''8 ~ | f''4 d''8 d''4 es''4 r8 | r2 es''8 f''8 g''8 f''8 ~ | f''8 es''4 d''4 es''4. | R1*1 | \sectionLabel "Verse 2" r2 es'8. f'8. g'8 | g'4. r2 r8 | r4 es'16 es'8 as'8. g'16 g'8. f'8 | f'4. es'4 r4. | r4. es'16 es'16 as'8. g'8. f'8 ~ | f'8 es'4 r8 as'8 g'16 g'8. f'16 f'16 ~ | f'8 g'4 f'8 f'8. es'4 r16 | r2 es''8 f''8 g''8 f''8 ~ | f''8 es''4 d''4 es''4. ~ | \sectionLabel "Chorus" es''4. r8 es''8 f''8 g''8 f''8 ~ | f''4 d''8 d''4 es''4. | r2 es''8 f''8 g''8 f''8 ~ | f''8 es''4 d''4 es''4. | r2 es''8 f''8 g''8 f''8 ~ | f''4 d''8 d''4 es''4. | r2 es''8 f''8 g''8 f''8 ~ | f''8 es''4 d''4 es''4. ~ | es''2 ~ es''8 r4. | \sectionLabel "Outro" r2 es'8. f'8. g'8 | g'2. r4 | R1*1 |
  \bar "|."
}
harmony = \chordmode { es1*3 c1*2:m as1:maj7 bes1 es1*2 c1*2:m as1*2:maj7 es1 bes1 as1 bes1*2 es1 bes1 c1:m as1:maj7 es1 es1*3 c1*2:m as1 bes1 as1 bes1 es1 bes1 c1:m as1:maj7 es1 bes1 c1:m as1:maj7 es1 es1*3 }
words = \lyricmode { "For" "God" "a" -- "lone" "my" "soul" "waits" "in" "si" -- "lence" "From" _ "him" "comes" "my" "sal" -- "va" -- "tion" "He" "a" -- "lone" "is" "my" "rock" "and" "my" "sal" -- "va" -- "tion" "My" "for" -- "tress," "I" "shall" "not" "be" "shak" -- "en" "Pour" "out" "your" "heart" "be" -- "fore" "him" "God" "is" "a" "re" -- "fuge" "for" "us" "For" "God" "a" -- "lone," \skip 1 "O" "my" "soul," "wait" "in" "si" -- "lence" "For" "my" "hope" "is" "from" "him" "Trust" "in" "him" "at" "all" "times," "O" "peo" -- "ple" "God" "is" "a" "re" -- "fuge" "for" "us" "Pour" "out" "your" "heart" "be" -- "fore" "him" "God" "is" "a" "re" -- "fuge" "for" "us" \skip 1 \skip 1 \skip 1 \skip 1 \skip 1 \skip 1 \skip 1 \skip 1 \skip 1 \skip 1 \skip 1 \skip 1 \skip 1 \skip 1 "For" "God" "a" -- "lone" }
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
