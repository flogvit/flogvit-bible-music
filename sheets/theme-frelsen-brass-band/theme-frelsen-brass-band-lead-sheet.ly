\version "2.24.0"
\header {
  title = "Marching to Zion's Gate"
  subtitle = "Romans 10:9–13; Psalms 118:14–15"
  tagline = ##f
  copyright = \markup \small \wordwrap { "Melody" "and" "chords" "from" "the" "score" "YuE2" "generated" "the" "song" "from" "(score.abc)." "Lyrics" "placed" "syllable" "by" "syllable" "against" "the" "recording" "with" "Whisper," "which" "heard" "112" "of" "113" "words." "All" "19" "lyric" "lines" "sit" "on" "their" "notes." "Bible" "text:" "Open" "Source" "English" "(OSEN)," "CC" "BY" "4.0," "from" "SBLGNT" "and" "tanach.us." }
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
  \clef treble \key d \minor \tempo 4 = 118
  \time 4/4 \sectionLabel "Intro" R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | \sectionLabel "Verse 1" d'4 d'8. e'16 f'4 f'8 g'8 | a'2 r4. a'8 | bes'4. a'8 g'4 f'4 | e'2 r2 | d'4. e'8 f'8 d'8 f'8 g'8 | a'2 r4. a'8 | bes'4. a'8 g'4 f'4 | e'4 r4 e'8. f'8. e'8 | d'2. r4 | \sectionLabel "Chorus" r2. r8 d'8 | d'4 a'8 a'8 bes'4 a'8 g'8 | a'2 r2 | bes'4 bes'8 c''16 c''16 d''4 c''8 bes'8 | a'2 g'4 r4 | d'4. e'8 f'4 f'8 g'8 | a'4 bes'8. a'16 g'4 c'8. c'16 | bes4. c'8 d'4 f'4 | e'2. cis'4 | d'1 | R1*1 | \sectionLabel "Verse 2" d'4. e'8 f'8 d'16 d'16 f'8 g'8 ~ | g'8 a'2 r4 a'8 | bes'4 bes'8. a'16 g'4 f'4 | e'2. r4 | d'4. e'8 f'4 f'8 g'8 | a'2 r4. a'8 | bes'4. a'8 g'4 f'4 | e'4 r4 e'8. f'8. e'8 | d'1 ~ | \sectionLabel "Chorus" d'2 r4. d'8 | d'4 a'8 a'8 bes'4 a'8 g'8 | a'2 r2 | bes'4 bes'8 c''8 d''4 c''8 bes'8 | a'2 g'4 r4 | d'4. e'8 f'4 f'8 g'8 | a'4 bes'8. a'16 g'4 c'8. c'16 | bes4. c'8 d'4 f'4 | e'2. cis'4 | d'1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | \sectionLabel "Outro" r2 e''4 f''4 ~ | f''2 e''2 | d''1 ~ | d''1 ~ | d''1 | R1*1 | R1*1 |
  \bar "|."
}
harmony = \chordmode { s1*7/8 d1*53/8:m bes1*1/2 f1*1/2 c1*1/2 g1:m a1 d1*2:m g1:m a1 d1:m f1 bes1 a1 d1:m d1*3:m bes1 f1*1/2 c1*1/2 d1:m f1*1/2 c1*1/2 g1:m a1 d1*2:m d1*2:m g1:m a1 d1:m f1 bes1 a1 d1:m d1*3:m bes1 f1*1/2 c1*1/2 d1:m f1*1/2 c1*1/2 g1:m a1 d1*3:m bes1*1/2 d1*3/2:m bes1*1/2 d1:m bes1*1/2 f1*1/2 c1*1/2 g1:m a1*2 a1*2 d1*5:m }
words = \lyricmode { "If" "you" "con" -- "fess" "with" "your" "mouth" "That" "Je" -- "sus" "Christ" "is" "Lord" "And" "be" -- "lieve" "with" -- "in" "your" "heart" "That" "God" "has" "raised" "him" "up" "You" "will" "be" "saved" "The" "Lord" "is" "my" "strength" "and" "my" "song" "He" _ "has" "be" -- "come" "my" "sal" -- "va" -- "tion" "Shouts" "of" "joy" "in" "the" "tents" "of" "the" "right" -- "eous" "The" "Lord's" "right" "hand" "does" "va" -- "lian" -- "tly" "Ev" -- "ery" -- "one" "who" "calls" "on" "him" _ "Will" "ne" -- "ver" "be" "put" "to" "shame" "There" "is" "no" "Jew" "or" "Greek" "For" "he" "is" "Lord" "of" "all" "Call" "on" "his" "name" "The" "Lord" "is" "my" "strength" "and" "my" "song" "He" "has" "be" -- "come" "my" "sal" -- "va" -- "tion" "Shouts" "of" "joy" "in" "the" "tents" "of" "the" "right" -- "eous" "The" "Lord's" "right" "hand" "does" "va" -- "lian" -- "tly" "Call" "on" "his" "name" }
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
