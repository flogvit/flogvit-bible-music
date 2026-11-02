\version "2.24.0"
\header {
  title = "A Thousand Years in Your Sight"
  subtitle = "Psalms 90:4"
  tagline = ##f
  copyright = \markup \small \wordwrap { "Melody" "and" "chords" "from" "the" "score" "YuE2" "generated" "the" "song" "from" "(score.abc)." "Lyrics" "placed" "syllable" "by" "syllable" "against" "the" "recording" "with" "Whisper," "which" "heard" "77" "of" "78" "words." "11" "of" "12" "lyric" "lines" "sit" "clearly" "on" "their" "notes;" "1" "are" "uncertain" "and" "printed" "in" "grey" "italics." "Bible" "text:" "Open" "Source" "English" "(OSEN)," "CC" "BY" "4.0," "from" "SBLGNT" "and" "tanach.us." }
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
  \clef treble \key d \minor \tempo 4 = 79
  \time 3/4 R1*3/4 | R1*3/4 | R1*3/4 | R1*3/4 | R1*3/4 | R1*3/4 | \time 7/8 R1*7/8 | \time 3/4 \sectionLabel "Verse 1" r2 d'4 | a'4 a'4 a'8 g'16 f'16 | g'4 f'8 d'16 r16 d'4 | r2 r8 d'8 | d'4 a'4 c''4 | d''4 a'4 r8 a'8 | a'4 c''8 d''8 d''8 c''8 | a'4 g'8 f'8 f'4 | r4. d'8 d'8 a'8 | g'4 f'4 r8 d'8 | d'8 a'8 g'8 f'8 e'16 d'16 c'16 d'16 | d'4 r2 | R1*3/4 | \sectionLabel "Verse 2" d'4 a'4 a'4 | g'8 g'8 f'8 d'4 r8 | d'8 a'8 a'8 c''4 c''8 | d''8 d''8 c''8 a'4 a'16 c''16 | d''4 d''4 d''16 c''16 a'8 | a'4 g'8 f'16 r16 f'4 | r4. d'8 d'8 a'8 | g'8. f'16 e'4 d'8 c'16 d'16 | d'4 r2 | \sectionLabel "Verse 3" r2 r8 d'8 | d'4 a'4 a'8 g'8 | g'4 f'8 e'8 e'8 d'8 | d'4 r2 | r2 d'8 d'8 | d'8 a'8 a'4 a'8 g'8 | g'4 f'8 e'8 e'4 | d'4 r2 | r2 r8 d'8 | d'8 a'8 a'4 a'4 | \sectionLabel "Outro" g'8 g'8 f'4 e'8 d'8 | d'4 r2 | r4. d'8 d'8 a'8 | g'4 f'4 r8 d'8 | d'8 a'8 g'8 f'8 e'16 d'16 c'16 d'16 | d'4 r2 | R1*3/4 | R1*3/4 |
  \bar "|."
}
harmony = \chordmode { d1*43/8:m d1*39/4:m d1*27/4:m d1*3/4:m bes1*3/4 c1*3/4 d1*3/2:m bes1*3/4 c1*3/4 d1*3/2:m bes1*3/4 c1*3/4 d1*21/4:m }
words = \lyricmode { "Lord," _ _ "you" "have" "been" "our" "d" -- "welling" "place" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "Through" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "all" \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "gen" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "er" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "a" -- \once \override LyricText.color = #(rgb-color 0.5 0.5 0.5) \once \override LyricText.font-shape = #'italic "tions" "Be" -- _ "fore" _ "the" _ "moun" -- "tains" "were" "born" "From" _ "ev" -- "er" -- "last" -- \skip 1 "ing" "to" "ev" -- "er" -- "last" -- "ing" "you" "are" "God" "You" "re" -- "turn" "mor" -- "tals" "to" "dust" "Say" -- _ "ing," "Re" -- "turn," "you" "chil" -- "dren" "of" "man" _ "For" "a" "thou" -- "sand" "years" "in" "your" "sight" \skip 1 "Are" _ "like" "a" "day" "that" "has" "just" "gone" "by" "Like" "grass" "that" "springs" "up" "in" "the" "morn" -- "ing" _ _ "In" "the" "morn" -- "ing" "it" "blooms" "and" "flour" -- "ish" -- "es" _ _ "By" "eve" -- "ning" "it" "with" -- "ers" "and" "dries" "up" "From" "ev" -- \skip 1 "er" -- "last" -- "ing" "to" "ev" -- "er" -- "last" -- "ing" "you" "are" "God" _ _ _ }
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
