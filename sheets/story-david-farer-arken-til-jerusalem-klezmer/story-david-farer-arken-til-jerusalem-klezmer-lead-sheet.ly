\version "2.24.0"
\header {
  title = "With All His Might"
  subtitle = "2 Samuel 6:12–16; 6:21–22"
  tagline = ##f
  copyright = \markup \small \wordwrap { "Melody" "and" "chords" "from" "the" "score" "YuE2" "generated" "the" "song" "from" "(score.abc)." "Lyrics" "placed" "syllable" "by" "syllable" "against" "the" "recording" "with" "Whisper," "which" "heard" "101" "of" "103" "words." "All" "17" "lyric" "lines" "sit" "on" "their" "notes." "Bible" "text:" "Open" "Source" "English" "(OSEN)," "CC" "BY" "4.0," "from" "SBLGNT" "and" "tanach.us." }
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
  \clef treble \key d \minor \tempo 4 = 140
  \time 4/4 \sectionLabel "Intro" R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | \sectionLabel "Verse 1" r8 a'8 a'8 a'8 bes'8 a'8 g'8 f'8 | f'8 d'4 r2 r8 | r8 a'8 a'8 a'8 bes'8 a'8 g'4 | bes'4. a'8 g'2 | r4 g'8 a'8 bes'8. a'16 g'8 f'8 | e'4. d'8 cis'4 d'4 | e'4 r8 bes8 f'4 e'4 | d'1 | R1*1 | \sectionLabel "Chorus" d''4 r4 d''8. e''16 f''8 a''8 | g''2 r2 | c''4 r8 c''8 c''8. d''16 e''8 g''8 | f''2 r2 | bes'4. bes'8 bes'8. c''16 d''8 f''8 | e''4. d''8 cis''4 a'8 bes'8 | a'4. g'8 f'4 e'4 | d'1 | R1*1 | \sectionLabel "Interlude" R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | \sectionLabel "Verse 2" r4 a'8 a'8 bes'8 a'8 g'8 f'8 | f'8 d'4 r2 r8 | r4 a'8 a'8 bes'8 a'8 g'8 a'8 | bes'4. a'8 g'2 | r8 g'8 g'8 a'8 bes'8 a'8 g'8 f'8 | e'4. d'8 cis'4. d'8 | e'4 r4 f'4 e'4 | d'1 | R1*1 | \sectionLabel "Chorus" d''4 r4 d''8. e''16 f''8 a''8 | g''2 r2 | c''4 r8 c''8 c''8. d''16 e''8 g''8 | f''2 r2 | bes'4. bes'8 bes'8. c''16 d''8 f''8 | e''4. d''8 cis''4 a'8 bes'8 | a'4. g'8 f'4 e'4 | d'1 | R1*1 | R1*1 | \sectionLabel "Outro" r4. a8 f'4 e'4 | d'4 r2. | \sectionLabel "Interlude" R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 | R1*1 |
  \bar "|."
}
harmony = \chordmode { s1*1/2 d1*9/2:m g1:m c1 f1 bes1 e1:dim a1:7 d1*2:m d1*3:m g1*2:m a1*2 d1*2:m d1:m g1:m c1 f1 bes1 a1*2 d1*2:m d1*2:m g1*2:m a1*2 d1*2:m d1*3:m g1*2:m a1*2 d1*2:m d1:m g1:m c1 f1 bes1 a1*2 d1*3:m d1*2:m d1:m g1:m c1 f1 bes1 a1*2 d1*5:m }
words = \lyricmode { "They" "brought" "the" "ark" "up" "to" "the" "c" -- "ity" "With" "shout" -- "ing" "and" "the" "sound" "of" "the" "horn" "Da" -- "vid" "danced" "be" -- "fore" "the" "Lord" "With" "all" "his" "might," "with" "all" "his" "might" "Dance," "dance" "be" -- "fore" "the" "Lord" "Leap" "for" "joy" "be" -- "fore" "the" "Lord" "I" "will" "cel" -- "e" -- "brate" "be" -- "fore" "the" "Lord" "I" "will" "dance" "be" -- "fore" "the" "Lord" "Mic" -- "hal" "watched" "him" "from" "the" "win" -- "dow" "Saw" _ "the" "king" "leap" -- "ing" "in" "the" "street" "I" "will" "be" "e" -- "ven" "more" "un" -- "dig" -- "ni" -- "fied" "Than" "this" "for" "the" "Lord" "Dance," "dance" "be" -- "fore" "the" "Lord" "Leap" "for" "joy" "be" -- "fore" "the" "Lord" "I" "will" "cel" -- "e" -- "brate" "be" -- "fore" "the" "Lord" "I" "will" "dance" "be" -- "fore" "the" "Lord" "With" "all" "his" "might" }
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
