#!/usr/bin/env python3
"""Make a chord sheet (PDF + ChordPro) and a lead sheet (PDF) for finished YuE songs.

Melody and chords come from the song's score.abc; the lyrics from its request.json.
Whisper (word timestamps) listens to audio.flac to find where each lyric line is sung,
and the syllables are then laid on the score's vocal notes in order.

    .venv-sheets/bin/python scripts/song-sheets.py YuE/outputs/pilot/verse-40-11-28-folk [...]

Writes sheets/<id>/ (see README.md).
"""
from __future__ import annotations

import argparse
import difflib
import hashlib
import html
import json
import os
import re
import subprocess
import sys
from dataclasses import dataclass, field
from fractions import Fraction
from pathlib import Path

import numpy as np

REPO = Path(__file__).resolve().parent.parent
WHISPER_MODEL = "large-v3"
SAMPLE_RATE = 16000

BOOKS = [
    "Genesis", "Exodus", "Leviticus", "Numbers", "Deuteronomy", "Joshua", "Judges", "Ruth",
    "1 Samuel", "2 Samuel", "1 Kings", "2 Kings", "1 Chronicles", "2 Chronicles", "Ezra",
    "Nehemiah", "Esther", "Job", "Psalms", "Proverbs", "Ecclesiastes", "Song of Songs", "Isaiah",
    "Jeremiah", "Lamentations", "Ezekiel", "Daniel", "Hosea", "Joel", "Amos", "Obadiah", "Jonah",
    "Micah", "Nahum", "Habakkuk", "Zephaniah", "Haggai", "Zechariah", "Malachi", "Matthew", "Mark",
    "Luke", "John", "Acts", "Romans", "1 Corinthians", "2 Corinthians", "Galatians", "Ephesians",
    "Philippians", "Colossians", "1 Thessalonians", "2 Thessalonians", "1 Timothy", "2 Timothy",
    "Titus", "Philemon", "Hebrews", "James", "1 Peter", "2 Peter", "1 John", "2 John", "3 John",
    "Jude", "Revelation",
]

# ---------------------------------------------------------------- ABC score

SHARP_ORDER, FLAT_ORDER = "FCGDAEB", "BEADGCF"
MAJOR_FIFTHS = {"C": 0, "G": 1, "D": 2, "A": 3, "E": 4, "B": 5, "F#": 6, "C#": 7,
                "F": -1, "Bb": -2, "Eb": -3, "Ab": -4, "Db": -5, "Gb": -6, "Cb": -7}
MODE_OFFSET = {"": 0, "maj": 0, "ion": 0, "mix": -1, "dor": -2, "m": -3, "min": -3, "aeo": -3,
               "phr": -4, "loc": -5, "lyd": 1}
TOKEN = re.compile(r'"(?P<chord>[^"]*)"|(?P<bar>\|)|(?P<tie>-)|(?P<space>\s+)'
                   r"|(?P<note>(?P<acc>\^\^|__|[\^_=])?(?P<letter>[A-Ga-g])(?P<oct>[,']*)(?P<num>\d*)(?P<den>/\d*)?)"
                   r"|(?P<rest>z(?P<rnum>\d*)(?P<rden>/\d*)?)|(?P<mrest>Z(?P<mnum>\d*))")


@dataclass
class Note:
    start: Fraction            # quarter notes from the top of the song
    dur: Fraction
    letter: str | None = None  # None for a rest
    alter: int = 0
    octave: int = 4            # scientific octave, C4 = middle C
    tie_next: bool = False
    tie_prev: bool = False
    bar: int = 0

    @property
    def is_rest(self):
        return self.letter is None


@dataclass
class Bar:
    start: Fraction
    length: Fraction
    meter: tuple[int, int]
    label: str | None = None   # section comment from the score, e.g. "verse"
    notes: list[int] = field(default_factory=list)
    chords: list[tuple[Fraction, str]] = field(default_factory=list)  # (offset in bar, symbol)


@dataclass
class Score:
    key_tonic: str
    key_mode: str
    fifths: int
    bpm: float
    bars: list[Bar]
    notes: list[Note]

    def seconds(self, quarters) -> float:
        return float(quarters) * 60.0 / self.bpm


def _length(num: str, den: str | None, unit: Fraction) -> Fraction:
    n = Fraction(int(num) if num else 1)
    if den is not None:
        n /= int(den[1:]) if len(den) > 1 else 2
    return n * unit


def _key_signature(fifths: int) -> dict[str, int]:
    if fifths >= 0:
        return {l: 1 for l in SHARP_ORDER[:fifths]}
    return {l: -1 for l in FLAT_ORDER[:-fifths]}


def parse_abc(text: str, voice: str = "Vocal") -> Score:
    unit = Fraction(1, 8) * 4  # L:1/8 is the ABC default; in quarter notes
    meter, bpm, tonic, mode, fifths = (4, 4), 120.0, "C", "", 0
    bars: list[Bar] = []
    notes: list[Note] = []
    current, label, pos = None, None, Fraction(0)
    bar = None
    accidentals: dict[tuple[str, int], int] = {}

    def open_bar():
        nonlocal bar, label
        bar = Bar(start=pos, length=Fraction(0), meter=meter, label=label)
        label = None
        accidentals.clear()

    def close_bar():
        nonlocal bar
        if bar is not None and (bar.notes or bar.chords):
            bar.length = pos - bar.start
            bars.append(bar)
        bar = None

    for raw in text.splitlines():
        line = raw.strip()
        if not line:
            continue
        if line.startswith("%"):
            label = line[1:].strip() or label
            continue
        field_match = re.match(r"^([A-Za-z]):\s*(.*)$", line)
        if field_match:
            key, value = field_match.groups()
            if key == "V":
                current = value.split()[0]
            elif key == "L":
                a, b = value.split("/")
                unit = Fraction(int(a), int(b)) * 4
            elif key == "M" and current in (None, voice):
                a, b = value.split("/")
                meter = (int(a), int(b))
            elif key == "Q":
                q = re.match(r"(?:(\d+)/(\d+)=)?(\d+)", value)
                if q:
                    beat = Fraction(int(q.group(1)), int(q.group(2))) * 4 if q.group(1) else Fraction(1)
                    bpm = float(q.group(3)) * float(beat)
            elif key == "K":
                k = re.match(r"([A-G][b#]?)\s*([A-Za-z]*)", value)
                tonic, mode = k.group(1), k.group(2).lower()[:3]
                if mode not in MODE_OFFSET:
                    raise ValueError(f"unsupported key mode {value!r}")
                fifths = MAJOR_FIFTHS[tonic] + MODE_OFFSET[mode]
            continue
        if current != voice:
            continue
        signature = _key_signature(fifths)
        for m in TOKEN.finditer(line):
            if m.group("space"):
                continue
            if m.group("bar"):
                close_bar()
                continue
            if bar is None:
                open_bar()
            if m.group("chord") is not None:
                bar.chords.append((pos - bar.start, m.group("chord").strip()))
            elif m.group("tie"):
                if notes:
                    notes[-1].tie_next = True
            elif m.group("note"):
                letter = m.group("letter")
                octave = (4 if letter.isupper() else 5) + m.group("oct").count("'") - m.group("oct").count(",")
                acc = m.group("acc")
                slot = (letter.upper(), octave)
                if acc:
                    accidentals[slot] = {"^": 1, "^^": 2, "_": -1, "__": -2, "=": 0}[acc]
                alter = accidentals.get(slot, signature.get(letter.upper(), 0))
                dur = _length(m.group("num"), m.group("den"), unit)
                prev = notes[-1] if notes else None
                tie_prev = bool(prev and prev.tie_next and not prev.is_rest)
                notes.append(Note(pos, dur, letter.upper(), alter, octave, tie_prev=tie_prev, bar=len(bars)))
                bar.notes.append(len(notes) - 1)
                pos += dur
            elif m.group("rest"):
                dur = _length(m.group("rnum"), m.group("rden"), unit)
                notes.append(Note(pos, dur, bar=len(bars)))
                bar.notes.append(len(notes) - 1)
                pos += dur
            elif m.group("mrest"):
                count = int(m.group("mnum") or 1)
                for i in range(count):
                    if bar is None:
                        open_bar()
                    full = Fraction(meter[0] * 4, meter[1])
                    notes.append(Note(pos, full, bar=len(bars)))
                    bar.notes.append(len(notes) - 1)
                    pos += full
                    if i < count - 1:
                        close_bar()
            else:
                raise ValueError(f"unsupported ABC in {line!r}")
        consumed = "".join(m.group(0) for m in TOKEN.finditer(line))
        if consumed != line:
            raise ValueError(f"unsupported ABC in {line!r}")
    close_bar()
    if not bars:
        raise ValueError(f"no bars for voice {voice!r}")
    return Score(tonic, mode, fifths, bpm, bars, notes)


# ---------------------------------------------------------------- lyrics

@dataclass
class Syllable:
    text: str            # what is printed under the note (punctuation kept)
    word: int            # index into Lyrics.words
    first: bool          # first syllable of its word
    last: bool
    time: float = 0.0    # estimated sung time, in score seconds
    weight: float = 0.0  # how much to trust `time` (0 = interpolated)
    note: int | None = None


@dataclass
class Word:
    text: str
    norm: str
    line: int
    syllables: list[int] = field(default_factory=list)
    heard: dict | None = None   # matched Whisper word


@dataclass
class Line:
    section: int
    words: list[int] = field(default_factory=list)


@dataclass
class Section:
    name: str            # as written, e.g. "Verse"
    label: str = ""      # numbered for print, e.g. "Verse 2"
    lines: list[int] = field(default_factory=list)


@dataclass
class Lyrics:
    sections: list[Section]
    lines: list[Line]
    words: list[Word]
    syllables: list[Syllable]


_cmu = None
_pyphen = None


def _syllable_count(core: str) -> int:
    global _cmu
    if _cmu is None:
        import cmudict
        _cmu = cmudict.dict()
    prons = _cmu.get(core.lower())
    if prons:  # the shortest pronunciation: songs say ev'ry and ev'ning
        return min(sum(ch[-1].isdigit() for ch in pron) for pron in prons)
    return max(1, len(_vowel_groups(core)))


def _vowel_groups(core: str) -> list[tuple[int, int]]:
    w = core.lower()
    groups = [(m.start(), m.end()) for m in re.finditer(r"[aeiou]+|(?<=[^aeiou])y", w)]
    if len(groups) > 1 and w.endswith("e") and groups[-1] == (len(w) - 1, len(w)) and not w.endswith("le"):
        groups.pop()  # silent final e
    if len(groups) > 1 and w.endswith("es") and groups[-1][0] == len(w) - 2 and w[-3:-2] not in "szxcg":
        groups.pop()
    return groups


def _split_by_vowels(core: str, count: int) -> list[str] | None:
    groups = _vowel_groups(core)
    while len(groups) > count:  # join the two vowel groups closest together (even-ing)
        k = min(range(len(groups) - 1), key=lambda i: groups[i + 1][0] - groups[i][1])
        groups[k:k + 2] = [(groups[k][0], groups[k + 1][1])]
    if len(groups) != count:
        return None
    cuts = []
    for (_, end), (start, _) in zip(groups, groups[1:]):
        consonants = start - end
        cuts.append(end + (consonants // 2 if consonants > 1 else 0))
    return [core[a:b] for a, b in zip([0] + cuts, cuts + [len(core)])]


def syllabify(word: str) -> list[str]:
    """Split a word for singing: CMUdict gives the count, pyphen or vowel groups the cut points."""
    global _pyphen
    m = re.match(r"^(\W*)(.*?)(\W*)$", word)
    lead, core, trail = m.groups()
    if not re.search(r"[A-Za-z]", core):
        return [word]
    if "-" in core:
        parts = [p for part in core.split("-") for p in syllabify(part)]
        parts = [p + ("-" if i < len(parts) - 1 and not p.endswith("-") else "") for i, p in enumerate(parts)]
        pieces = parts
    else:
        if _pyphen is None:
            import pyphen
            _pyphen = pyphen.Pyphen(lang="en_US", left=1, right=2)
        count = _syllable_count(core)
        pieces = _pyphen.inserted(core).split("-")
        if len(pieces) != count:
            pieces = _split_by_vowels(core, count) or pieces
    pieces[0] = lead + pieces[0]
    pieces[-1] = pieces[-1] + trail
    return pieces


def normalize(word: str) -> str:
    return re.sub(r"[^a-z0-9']", "", word.lower().replace("’", "'"))


def parse_lyrics(text: str) -> Lyrics:
    sections: list[Section] = []
    lines: list[Line] = []
    words: list[Word] = []
    syllables: list[Syllable] = []
    for raw in text.splitlines():
        raw = raw.strip()
        header = re.match(r"^\[(.+)\]$", raw)
        if header:
            sections.append(Section(header.group(1).strip()))
            continue
        if not raw:
            continue
        if not sections:
            sections.append(Section("Verse"))
        line = Line(len(sections) - 1)
        for token in raw.split():
            if not normalize(token) and words and line.words:
                words[line.words[-1]].text += " " + token  # stray punctuation such as "—"
                syllables[words[line.words[-1]].syllables[-1]].text += " " + token
                continue
            w = Word(token, normalize(token), len(lines))
            pieces = syllabify(token)
            for i, piece in enumerate(pieces):
                w.syllables.append(len(syllables))
                syllables.append(Syllable(piece, len(words), i == 0, i == len(pieces) - 1))
            line.words.append(len(words))
            words.append(w)
        sections[-1].lines.append(len(lines))
        lines.append(line)
    sections = [s for s in sections if s.lines]
    for i, s in enumerate(sections):
        for li in s.lines:
            lines[li].section = i
    counts: dict[str, int] = {}
    for s in sections:
        counts[base_name(s.name)] = counts.get(base_name(s.name), 0) + 1
    seen: dict[str, int] = {}
    for s in sections:
        b = base_name(s.name)
        seen[b] = seen.get(b, 0) + 1
        s.label = f"{s.name} {seen[b]}" if b == "verse" and counts[b] > 1 and not re.search(r"\d", s.name) else s.name
    return Lyrics(sections, lines, words, syllables)


def base_name(name: str) -> str:
    return re.sub(r"[\s\d]+$", "", name.strip().lower())


# ---------------------------------------------------------------- Whisper

def load_audio(path: Path) -> np.ndarray:
    pcm = subprocess.run(["ffmpeg", "-nostdin", "-v", "error", "-i", str(path), "-ac", "1",
                          "-ar", str(SAMPLE_RATE), "-f", "f32le", "-"], capture_output=True, check=True).stdout
    return np.frombuffer(pcm, np.float32)


class Listener:
    """Whisper passes over the song, cached in whisper.json so a rerun only redoes the layout."""

    def __init__(self, audio_path: Path, cache_path: Path):
        self.audio_path, self.cache_path = audio_path, cache_path
        self.cache = json.loads(cache_path.read_text()) if cache_path.exists() else {}
        self.audio = None
        self.model = None

    def words(self, start: float | None, end: float | None, prompt: str) -> list[dict]:
        key = f"{WHISPER_MODEL}|{start}|{end}|" + hashlib.sha1(prompt.encode()).hexdigest()[:12]
        if key not in self.cache:
            if self.audio is None:
                self.audio = load_audio(self.audio_path)
            if self.model is None:
                from faster_whisper import WhisperModel
                print(f"  loading Whisper {WHISPER_MODEL} (CPU)", flush=True)
                self.model = WhisperModel(WHISPER_MODEL, device="cpu", compute_type="int8", cpu_threads=8)
            offset = start or 0.0
            clip = self.audio[int(offset * SAMPLE_RATE): int(end * SAMPLE_RATE) if end else None]
            print(f"  listening {offset:.1f}-{end or len(self.audio) / SAMPLE_RATE:.1f} s", flush=True)
            segments, _ = self.model.transcribe(clip, language="en", word_timestamps=True, initial_prompt=prompt,
                                                condition_on_previous_text=False, beam_size=5)
            # plain floats: Whisper hands back numpy numbers, which json cannot write further on
            self.cache[key] = [dict(w=w.word.strip(), s=round(float(w.start) + offset, 3),
                                    e=round(float(w.end) + offset, 3), p=round(float(w.probability), 3))
                               for seg in segments for w in seg.words]
            self.cache_path.write_text(json.dumps(self.cache, indent=1))
        return self.cache[key]

    def duration(self) -> float:
        out = subprocess.run(["ffprobe", "-v", "error", "-show_entries", "format=duration", "-of", "csv=p=0",
                              str(self.audio_path)], capture_output=True, text=True, check=True).stdout
        return float(out)


def match_words(lyric: list[int], words: list[Word], heard: list[dict]) -> int:
    """Attach heard words to lyric words (in order). Returns how many matched."""
    a = [words[i].norm for i in lyric]
    b = [normalize(h["w"]) for h in heard]
    matched = 0
    sm = difflib.SequenceMatcher(None, a, b, autojunk=False)
    for tag, a0, a1, b0, b1 in sm.get_opcodes():
        if tag == "equal" or (tag == "replace" and a1 - a0 == b1 - b0 and a1 - a0 <= 4):
            for k in range(a1 - a0):
                if tag == "replace" and difflib.SequenceMatcher(None, a[a0 + k], b[b0 + k]).ratio() < 0.6:
                    continue
                words[lyric[a0 + k]].heard = heard[b0 + k]
                matched += 1
    return matched


def listen(lyrics: Lyrics, listener: Listener) -> None:
    all_words = list(range(len(lyrics.words)))
    prompt = " ".join(" ".join(lyrics.words[w].text for w in line.words) for line in lyrics.lines)
    match_words(all_words, lyrics.words, listener.words(None, None, prompt))
    # Whisper sometimes hallucinates over a stretch of singing; listen again to each run of lines
    # it missed, with just those lines as the prompt.
    total = listener.duration()
    runs, run = [], []
    for li, line in enumerate(lyrics.lines):
        if not any(lyrics.words[w].heard for w in line.words):
            run.append(li)
        elif run:
            runs.append(run)
            run = []
    if run:
        runs.append(run)
    for run in runs:
        first_word = lyrics.lines[run[0]].words[0]
        last_word = lyrics.lines[run[-1]].words[-1]
        before = [w.heard for w in lyrics.words[:first_word] if w.heard]
        after = [w.heard for w in lyrics.words[last_word + 1:] if w.heard]
        start = max(0.0, (before[-1]["e"] if before else 0.0) - 1.0)
        end = min(total, (after[0]["s"] if after else total) + 1.0)
        if end - start < 1.0:
            continue
        ids = [w for li in run for w in lyrics.lines[li].words]
        prompt = ". ".join(" ".join(lyrics.words[w].text for w in lyrics.lines[li].words) for li in run)
        match_words(ids, lyrics.words, listener.words(round(start, 2), round(end, 2), prompt))


# ---------------------------------------------------------------- alignment

@dataclass
class Onset:
    note: int
    time: float          # score seconds
    tie_cont: bool
    phrase_start: bool
    rest_before: float   # seconds of rest right before


def onsets(score: Score) -> list[Onset]:
    out, rest, first = [], 0.0, True
    for i, n in enumerate(score.notes):
        if n.is_rest:
            rest += score.seconds(n.dur)
            continue
        beat = 60.0 / score.bpm
        out.append(Onset(i, score.seconds(n.start), n.tie_prev, first or rest >= beat / 2 - 1e-6, rest))
        rest, first = 0.0, False
    return out


def estimate_offset(lyrics: Lyrics, ons: list[Onset]) -> float:
    """Audio time minus score time, from where lines start in the audio vs where phrases start in the score."""
    starts = []
    for line in lyrics.lines:
        h = lyrics.words[line.words[0]].heard
        if h and h["p"] >= 0.3:
            starts.append(h["s"])
    phrases = np.array([o.time for o in ons if o.phrase_start])
    if not starts or not len(phrases):
        return 0.0
    starts = np.array(starts)
    grid = np.arange(-12.0, 12.0, 0.02)
    cost = [np.minimum(np.abs((starts - b)[:, None] - phrases[None, :]).min(axis=1), 1.0).sum() for b in grid]
    return float(grid[int(np.argmin(cost))])


def place_times(lyrics: Lyrics, offset: float) -> None:
    """Give every syllable an estimated time in score seconds; interpolate the ones Whisper did not hear."""
    for w in lyrics.words:
        if not w.heard:
            continue
        h = w.heard
        dur = h["e"] - h["s"]
        # A long word usually means Whisper put its start at the end of the previous word.
        weight = max(0.15, h["p"]) * (1.0 if dur < 1.5 else 0.4)
        step = min(dur / len(w.syllables), 0.35)
        for k, si in enumerate(w.syllables):
            s = lyrics.syllables[si]
            s.time = h["s"] - offset + k * step
            s.weight = weight
    known = [i for i, s in enumerate(lyrics.syllables) if s.weight > 0]
    if not known:
        return
    for i, s in enumerate(lyrics.syllables):
        if s.weight > 0:
            continue
        prev = max((k for k in known if k < i), default=None)
        nxt = min((k for k in known if k > i), default=None)
        if prev is None:
            s.time = lyrics.syllables[nxt].time - 0.4 * (nxt - i)
        elif nxt is None:
            s.time = lyrics.syllables[prev].time + 0.4 * (i - prev)
        else:
            a, b = lyrics.syllables[prev].time, lyrics.syllables[nxt].time
            s.time = a + (b - a) * (i - prev) / (nxt - prev)


P_SKIP, P_TIE, P_LINE, P_BREATH, P_PAUSE, CAP = 0.5, 1.5, 1.2, 0.3, 0.8, 3.0
# Notes left over at the end of a line are a held last syllable (or a vocalise), which is common.
P_SKIP_LINE_END = 0.15
# Whisper finds where a line starts well, but drifts late inside it; inside a line the note count leads.
W_INNER = 0.3


def align(lyrics: Lyrics, ons: list[Onset], beat: float) -> None:
    """Lay syllables on note onsets in order (dynamic programming).

    Cost: distance between the heard time and the note, notes left without a syllable
    (cheaper at the end of a line), a line that does not start on a phrase, a line that
    runs across a long rest, and re-articulating a tied note."""
    syl = lyrics.syllables
    n = len(ons)
    if not syl or not n:
        return
    t = np.array([o.time for o in ons])
    tie = np.array([o.tie_cont for o in ons], float)
    pstart = np.array([o.phrase_start for o in ons])
    pause = np.array([P_PAUSE if o.rest_before > beat * 1.01 else P_BREATH for o in ons]) * pstart
    counted = np.cumsum(1.0 - tie)  # onsets that would be left unsung if skipped
    line_start = {lyrics.lines[li].words[0] for li in range(len(lyrics.lines))}

    def node(i):
        s = syl[i]
        starts_line = s.first and s.word in line_start
        weight = max(s.weight, 0.15) * (1.0 if starts_line else W_INNER)
        cost = weight * np.minimum(np.abs(s.time - t), CAP) + P_TIE * tie
        if starts_line:
            cost = cost + P_LINE * (~pstart)
        else:
            cost = cost + pause
        return cost

    cost = node(0)
    back = np.zeros((len(syl), n), dtype=np.int64)
    for i in range(1, len(syl)):
        skip = P_SKIP_LINE_END if syl[i].first and syl[i].word in line_start else P_SKIP
        shifted = cost - skip * counted
        best = np.full(n, np.inf)
        arg = np.zeros(n, dtype=np.int64)
        run_min, run_arg = np.inf, -1
        for j in range(n):
            best[j], arg[j] = run_min, run_arg
            if shifted[j] < run_min:
                run_min, run_arg = shifted[j], j
        prev_counted = np.concatenate([[0.0], counted[:-1]])
        cost = node(i) + skip * prev_counted + best
        back[i] = arg
    j = int(np.argmin(cost))
    for i in range(len(syl) - 1, -1, -1):
        syl[i].note = ons[j].note
        j = int(back[i][j])


@dataclass
class LineReport:
    line: int
    heard: int
    words: int
    error: float | None   # median seconds between where Whisper heard a syllable and its note
    tie_split: bool       # a tied note was split to carry an extra syllable
    uncertain: bool


def report(lyrics: Lyrics, score: Score, beat: float) -> list[LineReport]:
    """A line is uncertain when Whisper heard too little of it, or heard it away from the notes it got.

    Whisper runs about a beat late inside sung lines, so the limit is 1.5 beats (at least a second)."""
    limit = max(1.5 * beat, 1.0)
    out = []
    for li, line in enumerate(lyrics.lines):
        heard = sum(1 for w in line.words if lyrics.words[w].heard)
        sylls = [lyrics.syllables[s] for w in line.words for s in lyrics.words[w].syllables]
        errors = [abs(s.time - score.seconds(score.notes[s.note].start))
                  for s in sylls if s.note is not None and s.weight >= 0.5]
        error = float(np.median(errors)) if errors else None
        first = sylls[0]
        start_off = first.note is not None and first.weight >= 0.5 and \
            abs(first.time - score.seconds(score.notes[first.note].start)) > limit
        tie_split = any(s.note is not None and score.notes[s.note].tie_prev for s in sylls)
        uncertain = heard < len(line.words) / 2 or error is None or error > limit or start_off
        out.append(LineReport(li, heard, len(line.words), error, tie_split, uncertain))
    return out


# ---------------------------------------------------------------- layout bars

@dataclass
class OutBar:
    meter: tuple[int, int]
    bars: list[int]           # score bars in this printed bar
    partial: bool = False

    def length(self, score: Score) -> Fraction:
        return sum((score.bars[b].length for b in self.bars), Fraction(0))


def layout_bars(score: Score) -> list[OutBar]:
    """Print 2/4 as 4/4 when the chords change every other bar (YuE writes slow songs in 2/4)."""
    bars = score.bars
    if not all(b.meter == (2, 4) for b in bars) or len(bars) < 4:
        return [OutBar(b.meter, [i]) for i, b in enumerate(bars)]
    changes = [0, 0]
    last = None
    for i, b in enumerate(bars):
        for off, sym in b.chords:
            if sym != last and off == 0:
                changes[i % 2] += 1
            last = sym
    if max(changes) < 0.75 * sum(changes):
        return [OutBar(b.meter, [i]) for i, b in enumerate(bars)]
    phase = 0 if changes[0] >= changes[1] else 1
    out = [OutBar((2, 4), [0], partial=True)] if phase else []
    i = phase
    while i < len(bars):
        group = list(range(i, min(i + 2, len(bars))))
        out.append(OutBar((4, 4) if len(group) == 2 else (2, 4), group))
        i += 2
    return out


# ---------------------------------------------------------------- LilyPond lead sheet

LY_DURATIONS = sorted([(Fraction(8), "\\breve"), (Fraction(7), "1.."), (Fraction(6), "1."), (Fraction(4), "1"),
                       (Fraction(7, 2), "2.."), (Fraction(3), "2."), (Fraction(2), "2"), (Fraction(7, 4), "4.."),
                       (Fraction(3, 2), "4."), (Fraction(1), "4"), (Fraction(7, 8), "8.."), (Fraction(3, 4), "8."),
                       (Fraction(1, 2), "8"), (Fraction(3, 8), "16."), (Fraction(1, 4), "16"),
                       (Fraction(3, 16), "32."), (Fraction(1, 8), "32"), (Fraction(1, 16), "64")], reverse=True)


def ly_pieces(dur: Fraction) -> list[str]:
    out = []
    while dur > 0:
        for length, name in LY_DURATIONS:
            if length <= dur:
                out.append(name)
                dur -= length
                break
        else:
            raise ValueError(f"duration {dur} too short to print")
    return out


def ly_pitch(n: Note) -> str:
    name = n.letter.lower()
    if n.alter > 0:
        name += "is" * n.alter
    elif n.alter < 0:
        name += ("s" if name in "ae" else "es") + "es" * (-n.alter - 1)
    marks = n.octave - 3
    return name + ("'" * marks if marks > 0 else "," * -marks)


CHORD = re.compile(r"^([A-G])([b#]?)(.*?)(?:/([A-G])([b#]?))?$")
LY_QUALITY = {"": "", "maj": "", "m": ":m", "min": ":m", "7": ":7", "m7": ":m7", "maj7": ":maj7",
              "6": ":6", "m6": ":m6", "9": ":9", "m9": ":m9", "maj9": ":maj9", "sus4": ":sus4",
              "sus2": ":sus2", "sus": ":sus4", "7sus4": ":7sus4", "dim": ":dim", "dim7": ":dim7",
              "aug": ":aug", "m7b5": ":m7.5-", "add9": ":5.9"}


def ly_root(letter: str, acc: str) -> str:
    name = letter.lower()
    if acc == "#":
        return name + "is"
    if acc == "b":
        return name + ("s" if name in "ae" else "es")
    return name


def ly_chord(symbol: str, dur: Fraction) -> str:
    length = f"1*{dur / 4}" if dur != 4 else "1"
    m = CHORD.match(symbol)
    if m and m.group(3) in LY_QUALITY:
        bass = "/" + ly_root(m.group(4), m.group(5)) if m.group(4) else ""
        return f"{ly_root(m.group(1), m.group(2))}{length}{LY_QUALITY[m.group(3)]}{bass}"
    return f'\\once \\override ChordName.text = \\markup {{ "{ly_text(symbol)}" }} c{length}'


def ly_text(s: str) -> str:
    return s.replace("\\", "\\\\").replace('"', '\\"')


def lead_sheet(score: Score, lyrics: Lyrics, out_bars: list[OutBar], lines: list[LineReport],
               meta: dict, note_text: str) -> str:
    uncertain_lines = {r.line for r in lines if r.uncertain}
    note_syllable = {s.note: (i, s) for i, s in enumerate(lyrics.syllables) if s.note is not None}
    for _, s in note_syllable.values():  # a syllable on a tied note re-articulates it
        if score.notes[s.note].tie_prev:
            score.notes[s.note - 1].tie_next = False
            score.notes[s.note].tie_prev = False

    # Section labels: lyric sections where they start, score sections for instrumental stretches.
    bar_of_note = {}
    for k, ob in enumerate(out_bars):
        for b in ob.bars:
            for ni in score.bars[b].notes:
                bar_of_note[ni] = k
    labels: dict[int, str] = {}
    sung_bars = {bar_of_note[s.note] for s in lyrics.syllables if s.note is not None}
    for k, ob in enumerate(out_bars):
        lab = next((score.bars[b].label for b in ob.bars if score.bars[b].label), None)
        if lab:
            end = next((j for j in range(k + 1, len(out_bars))
                        if any(score.bars[b].label for b in out_bars[j].bars)), len(out_bars))
            if not sung_bars.intersection(range(k, end)):
                labels[k] = lab.capitalize()
    for sec in lyrics.sections:
        s0 = lyrics.syllables[lyrics.words[lyrics.lines[sec.lines[0]].words[0]].syllables[0]]
        if s0.note is not None:
            labels[bar_of_note[s0.note]] = sec.label

    music, chords, words = [], [], []
    meter = None
    last_chord = None
    chord_pos = Fraction(0)
    pos = Fraction(0)
    sung_line = {}
    for li, line in enumerate(lyrics.lines):
        for w in line.words:
            for s in lyrics.words[w].syllables:
                sung_line[s] = li
    current = None  # syllable index sounding (for melisma)
    for k, ob in enumerate(out_bars):
        if ob.partial and k == 0:
            music.append(f"\\partial {ly_pieces(ob.length(score))[0]}")
        elif ob.meter != meter:
            music.append(f"\\time {ob.meter[0]}/{ob.meter[1]}")
        meter = ob.meter
        if k in labels:
            music.append(f'\\sectionLabel "{ly_text(labels[k])}"')
        bar_start = pos
        bar_notes = [ni for b in ob.bars for ni in score.bars[b].notes]
        if all(score.notes[ni].is_rest for ni in bar_notes) and not ob.partial:
            music.append(f"R1*{ob.length(score) / 4}")
            current = None
        else:
            for ni in bar_notes:
                n = score.notes[ni]
                pieces = ly_pieces(n.dur)
                if n.is_rest:
                    music.append(" ".join("r" + p for p in pieces))
                    current = None
                    continue
                pitch = ly_pitch(n)
                music.append(" ~ ".join(pitch + p for p in pieces) + (" ~" if n.tie_next else ""))
                if n.tie_prev:
                    continue
                if ni in note_syllable:
                    si, s = note_syllable[ni]
                    current = si
                    text = f'"{ly_text(s.text)}"' + ("" if s.last else " --")
                    if sung_line.get(si) in uncertain_lines:
                        text = "\\once \\override LyricText.color = #(rgb-color 0.5 0.5 0.5) " \
                               "\\once \\override LyricText.font-shape = #'italic " + text
                    words.append(text)
                elif current is not None:
                    words.append("_")
                else:
                    words.append("\\skip 1")
        # chords for this printed bar
        for b in ob.bars:
            for off, sym in score.bars[b].chords:
                at = score.bars[b].start - score.bars[ob.bars[0]].start + off + bar_start
                is_section = k in labels and at == bar_start
                if sym == last_chord and not is_section:
                    continue
                if chords and at > chord_pos:
                    chords[-1] = (chords[-1][0], at - chord_pos)
                elif not chords and at > 0:
                    chords.append((None, at))
                elif chords and at == chord_pos:
                    chords.pop()
                chords.append((sym, Fraction(0)))
                chord_pos, last_chord = at, sym
        pos += ob.length(score)
        music.append("|")
    if chords:
        chords[-1] = (chords[-1][0], pos - chord_pos)
    chord_ly = " ".join(f"s1*{d / 4}" if sym is None else ly_chord(sym, d) for sym, d in chords if d > 0)

    key = f"\\key {ly_root(score.key_tonic[0], score.key_tonic[1:])} " \
          f"{'\\minor' if score.key_mode in ('m', 'min', 'aeo') else '\\major'}"
    header = "\n".join(f'  {k} = "{ly_text(v)}"' for k, v in meta.items() if v)
    return f"""\\version "2.24.0"
\\header {{
{header}
  tagline = ##f
  copyright = \\markup \\small \\wordwrap {{ {ly_markup_words(note_text)} }}
}}
\\paper {{
  #(set-paper-size "a4")
  top-margin = 12\\mm
  bottom-margin = 12\\mm
  left-margin = 14\\mm
  right-margin = 14\\mm
  system-system-spacing.basic-distance = #14
  markup-system-spacing.basic-distance = #8
}}
melody = {{
  \\clef treble {key} \\tempo 4 = {round(score.bpm)}
  {" ".join(music)}
  \\bar "|."
}}
harmony = \\chordmode {{ {chord_ly} }}
words = \\lyricmode {{ {" ".join(words)} }}
\\score {{
  <<
    \\new ChordNames \\with {{ majorSevenSymbol = \\markup {{ "maj7" }} }} \\harmony
    \\new Staff \\new Voice = "melody" \\melody
    \\new Lyrics \\lyricsto "melody" \\words
  >>
  \\layout {{
    indent = 0
    \\context {{ \\Lyrics
      \\override LyricSpace.minimum-distance = #1.6
      \\override LyricHyphen.minimum-distance = #1.4
    }}
  }}
}}
"""


def ly_markup_words(text: str) -> str:
    return " ".join(f'"{ly_text(w)}"' for w in text.split())


# ---------------------------------------------------------------- chord sheet

@dataclass
class Block:
    kind: str                  # "lyrics" or "bars"
    label: str
    section: int | None = None
    lines: list[list[tuple[str, list[str]]]] = field(default_factory=list)  # [(text, chords before it)]
    bar_chords: list[list[str]] = field(default_factory=list)


def chord_changes(score: Score) -> list[tuple[Fraction, str]]:
    """(position in quarter notes, symbol) wherever the chord changes."""
    out, last = [], None
    for b in score.bars:
        for off, sym in b.chords:
            if sym != last:
                out.append((b.start + off, sym))
                last = sym
    return out


def chord_blocks(score: Score, lyrics: Lyrics, out_bars: list[OutBar]) -> list[Block]:
    # all positions in quarter notes (exact fractions), so repeated passages place chords the same way
    beat = Fraction(1)
    syl = lyrics.syllables
    placed = [i for i, s in enumerate(syl) if s.note is not None]
    onset = {i: score.notes[syl[i].note].start for i in placed}

    def sounding_until(i: int) -> Fraction:
        """End of the syllable's note, including ties and melisma, i.e. up to the next onset or rest."""
        ni = syl[i].note
        nxt = next((k for k in placed if k > i), None)
        stop = syl[nxt].note if nxt is not None else len(score.notes)
        end = score.notes[ni].start + score.notes[ni].dur
        for k in range(ni + 1, stop):
            if score.notes[k].is_rest:
                break
            end = score.notes[k].start + score.notes[k].dur
        return end

    attached: dict[int, list[str]] = {}       # syllable -> chords placed over it
    trailing: dict[int, list[str]] = {}       # line -> chords after its last word
    gap_chords: list[tuple[Fraction, str]] = []
    changes = chord_changes(score)
    for ci, (t, sym) in enumerate(changes):
        next_change = changes[ci + 1][0] if ci + 1 < len(changes) else float("inf")
        prev = max((i for i in placed if onset[i] <= t), default=None)
        nxt = min((i for i in placed if onset[i] > t), default=None)
        if prev is not None and onset[prev] == t:
            attached.setdefault(prev, []).append(sym)
        elif prev is not None and sounding_until(prev) > t and (nxt is None or onset[nxt] - t > beat / 2):
            attached.setdefault(prev, []).append(sym)
        elif nxt is not None and onset[nxt] - t <= 2 * beat and onset[nxt] < next_change:
            attached.setdefault(nxt, []).append(sym)
        else:
            gap_chords.append((t, sym))

    # Gap chords: inside a section they trail the previous line; long gaps between sections
    # become instrumental blocks with one cell per printed bar.
    bar_times = []
    for ob in out_bars:
        start = score.bars[ob.bars[0]].start
        bar_times.append((start, start + ob.length(score)))
    blocks: list[Block] = []
    gaps: list[tuple[Fraction, Fraction | float, int | None]] = []  # (from, to, line before)
    order = sorted(placed)
    first_t = onset[order[0]] if order else float("inf")
    gaps.append((Fraction(0), first_t, None))
    for li in range(len(lyrics.lines)):
        sylls = [s for w in lyrics.lines[li].words for s in lyrics.words[w].syllables if s in onset]
        nxt_line = next((l2 for l2 in range(li + 1, len(lyrics.lines))
                         if any(s in onset for w in lyrics.lines[l2].words for s in lyrics.words[w].syllables)), None)
        if not sylls:
            continue
        end = sounding_until(sylls[-1])
        if nxt_line is None:
            gaps.append((end, float("inf"), li))
        else:
            n0 = min(s for w in lyrics.lines[nxt_line].words for s in lyrics.words[w].syllables if s in onset)
            gaps.append((end, onset[n0], li))

    instrumental: dict[int | None, Block] = {}
    for g0, g1, li in gaps:
        inside = [(t, s) for t, s in gap_chords if g0 <= t < g1]
        if not inside:
            continue
        same_section = (li is not None and li + 1 < len(lyrics.lines)
                        and lyrics.lines[li].section == lyrics.lines[li + 1].section)
        # a pickup is not a bar of its own on the chord sheet; its chord carries into the first full bar
        bars_in_gap = [k for k, (b0, b1) in enumerate(bar_times)
                       if b0 >= g0 - beat and b1 <= g1 + beat and not out_bars[k].partial]
        if li is not None and (same_section or len(bars_in_gap) < 4):
            trailing.setdefault(li, []).extend(s for _, s in inside)
            continue
        label = None
        for k in bars_in_gap:
            label = label or next((score.bars[b].label for b in out_bars[k].bars if score.bars[b].label), None)
        name = (label or "Instrumental").capitalize()
        if li is None:
            name = "Intro" if not label or "intro" in label.lower() else name
        elif g1 == float("inf"):
            name = "Outro" if not label or label.lower() in ("verse", "chorus", "bridge") else name
        cells = []
        for k in bars_in_gap:
            b0, b1 = bar_times[k]
            in_bar = [s for t, s in changes if b0 <= t < b1]
            held = [s for t, s in changes if t < b0][-1:]
            cells.append(in_bar if in_bar else held or ["–"])
        if any(base_name(sec.name) == base_name(name) for sec in lyrics.sections):
            name += " (instrumental)"  # e.g. a sung outro followed by a played one
        instrumental[li] = Block("bars", name, bar_chords=cells)

    if None in instrumental:
        blocks.append(instrumental[None])
    for si, sec in enumerate(lyrics.sections):
        block = Block("lyrics", sec.label, section=si)
        for li in sec.lines:
            parts = []
            for w in lyrics.lines[li].words:
                word = lyrics.words[w]
                for k, s in enumerate(word.syllables):
                    text = syl[s].text if len(word.syllables) > 1 else word.text
                    parts.append((text + (" " if k == len(word.syllables) - 1 else ""), attached.get(s, [])))
            if li in trailing:
                parts.append(("", trailing[li]))
            block.lines.append(_merge_parts(parts))
        blocks.append(block)
        if sec.lines and sec.lines[-1] in instrumental:
            blocks.append(instrumental[sec.lines[-1]])
    return blocks


def _merge_parts(parts: list[tuple[str, list[str]]]) -> list[tuple[str, list[str]]]:
    """Join syllables into chunks that start where a chord is placed."""
    out: list[tuple[str, list[str]]] = []
    for text, chords in parts:
        if chords or not out:
            out.append((text, list(chords)))
        else:
            out[-1] = (out[-1][0] + text, out[-1][1])
    return out


def same_block(a: Block, b: Block) -> bool:
    return a.kind == b.kind == "lyrics" and a.lines == b.lines


def bar_rows(cells: list[list[str]]) -> list[tuple[list[list[str]], int]]:
    """Group bars into rows of up to four; a pattern of up to eight bars repeated over eight bars or more
    becomes one row × n."""
    rows, i, plain = [], 0, []
    while i < len(cells):
        best = None
        for period in range(1, 9):
            pattern = cells[i:i + period]
            times = 1
            while cells[i + times * period: i + (times + 1) * period] == pattern:
                times += 1
            if len(pattern) == period and times >= 2 and period * times >= 8 \
                    and (best is None or period * times > best[0] * best[1]):
                best = (period, times)
        if best:
            rows += [(plain[k:k + 4], 1) for k in range(0, len(plain), 4)]
            plain = []
            period, times = best
            rows.append((cells[i:i + period], times))
            i += period * times
        else:
            plain.append(cells[i])
            i += 1
    rows += [(plain[k:k + 4], 1) for k in range(0, len(plain), 4)]
    return rows


def chordpro(blocks: list[Block], lyrics: Lyrics, meta: dict, key: str, bpm: float, meter: str) -> str:
    out = [f"{{title: {meta['title']}}}"]
    if meta.get("subtitle"):
        out.append(f"{{subtitle: {meta['subtitle']}}}")
    out += [f"{{key: {key}}}", f"{{tempo: {round(bpm)}}}", f"{{time: {meter}}}", ""]
    printed: list[Block] = []
    for b in blocks:
        if b.kind == "bars":
            out.append(f"{{comment: {b.label}}}")
            for row, times in bar_rows(b.bar_chords):
                out.append("| " + " | ".join(" ".join(f"[{c}]" for c in cell) for cell in row) + " |"
                           + (f" ×{times}" if times > 1 else ""))
            out.append("")
            continue
        kind = base_name(lyrics.sections[b.section].name)
        env = {"chorus": "chorus", "bridge": "bridge"}.get(kind, "verse")
        if any(same_block(b, p) and p.label == b.label for p in printed):
            out += ["{chorus}" if env == "chorus" else f"{{comment: {b.label} (repeat)}}", ""]
            continue
        out.append(f"{{start_of_{env}: {b.label}}}")
        for line in b.lines:
            out.append("".join("".join(f"[{c}]" for c in chords) + text for text, chords in line).rstrip())
        out += [f"{{end_of_{env}}}", ""]
        printed.append(b)
    return "\n".join(out)


def pretty_chord(sym: str) -> str:
    return re.sub(r"(?<=[A-G])b", "♭", sym).replace("#", "♯")


def chord_sheet_html(blocks: list[Block], meta: dict, info: str, footer: str, columns: int, size: float) -> str:
    parts = []
    printed: list[Block] = []
    for b in blocks:
        if b.kind == "bars":
            rows = "".join(
                "<div class=row>" + "".join(f"<span class=cell>{'&nbsp;'.join(pretty_chord(c) for c in cell)}</span>"
                                            for cell in row)
                + (f"<span class=times>×{times}</span>" if times > 1 else "") + "</div>"
                for row, times in bar_rows(b.bar_chords))
            parts.append(f"<section class=bars><h2>{html.escape(b.label)}</h2><div class=grid>{rows}</div></section>")
            continue
        if any(same_block(b, p) and p.label == b.label for p in printed):
            parts.append(f"<section class=repeat><h2>{html.escape(b.label)}</h2><p class=again>(repeat)</p></section>")
            continue
        printed.append(b)
        rows = []
        for line in b.lines:
            has = any(ch for _, ch in line)
            chunks = "".join(
                f"<span class=chunk>{'<b>' + '&nbsp;'.join(pretty_chord(c) for c in ch) + '</b>' if has else ''}"
                f"{lyric_html(text, ch, nxt)}</span>" for (text, ch), nxt in zip(line, line[1:] + [("", [])]))
            rows.append(f"<div class='line{' plain' if not has else ''}'>{chunks}</div>")
        parts.append(f"<section><h2>{html.escape(b.label)}</h2>{''.join(rows)}</section>")
    subtitle = f"<p class=sub>{html.escape(meta['subtitle'])}</p>" if meta.get("subtitle") else ""
    return f"""<!doctype html><html><head><meta charset=utf-8><style>
@page {{ size: A4; margin: 14mm 15mm 14mm 15mm;
  @bottom-left {{ content: "{css_text(footer)}"; font: 7.5pt "Helvetica Neue", Helvetica, sans-serif; color: #777; }} }}
body {{ font: {size}pt Georgia, "Times New Roman", serif; color: #1b1b1b; margin: 0; }}
h1 {{ font: 600 {size * 1.9:.1f}pt "Helvetica Neue", Helvetica, sans-serif; margin: 0; }}
.sub {{ font: {size * 1.05:.1f}pt Georgia, serif; font-style: italic; margin: 1mm 0 0; color: #444; }}
.info {{ font: {size * 0.85:.1f}pt "Helvetica Neue", Helvetica, sans-serif; color: #555; margin: 1.5mm 0 4mm; }}
main {{ columns: {columns}; column-gap: 9mm; }}
section {{ break-inside: avoid; margin: 0 0 {size * 0.9:.1f}pt; }}
h2 {{ font: 600 {size * 0.8:.1f}pt "Helvetica Neue", Helvetica, sans-serif; text-transform: uppercase;
     letter-spacing: .08em; color: #8a5a00; margin: 0 0 1pt; }}
.line {{ white-space: nowrap; line-height: 1.15; margin-bottom: 2pt; }}
.chunk {{ display: inline-block; vertical-align: bottom; }}
.chunk b {{ display: block; font: 700 {size * 0.92:.1f}pt "Helvetica Neue", Helvetica, sans-serif; color: #8a5a00;
           padding-right: .45em; min-height: 1.15em; }}
.chunk i {{ display: block; font-style: normal; white-space: pre; }}
.chunk i.mid {{ display: flex; }}
.chunk i.mid .hy {{ flex: 1; text-align: center; }}
.grid {{ font: 700 {size * 0.92:.1f}pt "Helvetica Neue", Helvetica, sans-serif; color: #8a5a00; }}
.cell {{ display: inline-block; min-width: 3.2em; border-left: 1px solid #bbb; padding: 0 .5em; }}
.row {{ white-space: nowrap; margin-bottom: 2pt; }}
.cell:last-of-type {{ border-right: 1px solid #bbb; }}
.times {{ font-weight: 400; color: #555; padding-left: .5em; }}
.again {{ margin: 0; font-style: italic; color: #555; }}
</style></head><body>
<h1>{html.escape(meta['title'])}</h1>{subtitle}<p class=info>{html.escape(info)}</p>
<main>{''.join(parts)}</main></body></html>"""


def lyric_html(text: str, chords: list[str], following: tuple[str, list[str]]) -> str:
    """Lyric part of a chunk. A chord wider than the start of a word it splits leaves a gap,
    which gets a hyphen (bur - dened) as in printed chord sheets."""
    mid_word = text and not text.endswith(" ") and following[0]
    # rough widths in em: bold sans chord plus its padding, against serif text
    if mid_word and chords and len(" ".join(chords)) * 0.62 + 0.45 > len(text) * 0.5:
        return f"<i class=mid><span>{html.escape(text)}</span><span class=hy>-</span></i>"
    return f"<i>{html.escape(text) or '&nbsp;'}</i>"


def css_text(s: str) -> str:
    return s.replace("\\", "\\\\").replace('"', '\\"')


def write_pdf(html_for, path: Path) -> int:
    from weasyprint import HTML
    for columns, size in ((1, 11.5), (1, 10.5), (2, 10.5), (2, 9.5), (2, 8.5), (2, 7.5)):
        doc = HTML(string=html_for(columns, size)).render()
        if len(doc.pages) == 1:
            break
    doc.write_pdf(path)
    return len(doc.pages)


# ---------------------------------------------------------------- song

def song_meta(song_dir: Path, request: dict) -> dict:
    song_id = request.get("id") or song_dir.name
    catalog = REPO / "catalog" / f"{song_id}.json"
    entry = json.loads(catalog.read_text()) if catalog.exists() else {}
    title = entry.get("title") or song_id
    # A verse or chapter song is named by its anchor; story, theme and person songs by their passages.
    anchor = entry.get("anchor") or {}
    refs = [anchor] if "bookId" in anchor else entry.get("references") or []
    subtitle, book = [], None
    for ref in refs:
        name = BOOKS[ref["bookId"] - 1]
        if name == "Psalms" and not ref.get("verseStart"):
            name = "Psalm"
        place = str(ref["chapter"])
        if ref.get("verseStart"):
            place += f":{ref['verseStart']}"
            if ref.get("verseEnd", ref["verseStart"]) != ref["verseStart"]:
                place += f"–{ref['verseEnd']}"
        subtitle.append(place if name == book else f"{name} {place}")
        book = name
    subtitle = "; ".join(subtitle)
    credit = ""
    if entry.get("textSource") == "osen" and entry.get("lyricsMode") in ("verbatim", "mixed"):
        credit = "Bible text: Open Source English (OSEN), CC BY 4.0, from SBLGNT and tanach.us."
    return {"id": song_id, "title": title, "subtitle": subtitle, "credit": credit}


def key_name(score: Score) -> str:
    return score.key_tonic + ("m" if score.key_mode in ("m", "min", "aeo") else "")


def run(song_dir: Path, out_root: Path) -> dict:
    request = json.loads((song_dir / "request.json").read_text())
    meta = song_meta(song_dir, request)
    out = out_root / meta["id"]
    out.mkdir(parents=True, exist_ok=True)
    print(f"{meta['id']}: {song_dir}", flush=True)

    score = parse_abc((song_dir / "score.abc").read_text())
    lyrics = parse_lyrics(request["lyrics"])
    listen(lyrics, Listener(song_dir / "audio.flac", out / "whisper.json"))
    ons = onsets(score)
    offset = estimate_offset(lyrics, ons)
    place_times(lyrics, offset)
    beat = 60.0 / score.bpm
    align(lyrics, ons, beat)
    lines = report(lyrics, score, beat)

    heard = sum(1 for w in lyrics.words if w.heard)
    uncertain = [r for r in lines if r.uncertain]
    total_lines = len(lines)
    if uncertain:
        quality = (f"{total_lines - len(uncertain)} of {total_lines} lyric lines sit clearly on their notes; "
                   f"{len(uncertain)} are uncertain and printed in grey italics.")
    else:
        quality = f"All {total_lines} lyric lines sit on their notes."
    note_text = (f"Melody and chords from the score YuE2 generated the song from (score.abc). Lyrics placed "
                 f"syllable by syllable against the recording with Whisper, which heard {heard} of "
                 f"{len(lyrics.words)} words. {quality} {meta['credit']}").strip()

    out_bars = layout_bars(score)
    meter = "4/4" if any(ob.meter == (4, 4) for ob in out_bars) else "{}/{}".format(*out_bars[-1].meter)
    ly = lead_sheet(score, lyrics, out_bars, lines,
                    {"title": meta["title"], "subtitle": meta["subtitle"]}, note_text)
    ly_path = out / f"{meta['id']}-lead-sheet.ly"
    ly_path.write_text(ly)
    lily = subprocess.run(["lilypond", "-dno-point-and-click", "-o", str(ly_path.with_suffix("")), str(ly_path)],
                          capture_output=True, text=True)
    lily_warnings = [l for l in lily.stderr.splitlines() if "warning" in l or "error" in l]
    if lily.returncode:
        raise RuntimeError(f"LilyPond failed for {meta['id']}:\n{lily.stderr[-3000:]}")

    # the chord sheet is built after the lead sheet has re-articulated tied notes, so placement matches
    blocks = chord_blocks(score, lyrics, out_bars)
    (out / f"{meta['id']}-chords.cho").write_text(chordpro(blocks, lyrics, meta, key_name(score), score.bpm, meter))
    info = f"Key {pretty_chord(key_name(score))} · {round(score.bpm)} BPM · {meter}"
    footer = " ".join(x for x in (meta["credit"], "Chords from the YuE2 score.") if x)
    pages = write_pdf(lambda c, s: chord_sheet_html(blocks, meta, info, footer, c, s),
                      out / f"{meta['id']}-chords.pdf")

    result = {
        "id": meta["id"], "song": str(song_dir), "offset_seconds": offset,
        "words_heard": heard, "words": len(lyrics.words),
        "lines": [{"text": " ".join(lyrics.words[w].text for w in lyrics.lines[r.line].words),
                   "heard": r.heard, "words": r.words,
                   "error_s": None if r.error is None else round(r.error, 2),
                   "tie_split": r.tie_split, "uncertain": r.uncertain} for r in lines],
        "syllables": [{"text": s.text, "time": round(s.time, 2), "weight": round(s.weight, 2),
                       "note_time": None if s.note is None else round(score.seconds(score.notes[s.note].start), 2)}
                      for s in lyrics.syllables],
        "chord_sheet_pages": pages, "lilypond_warnings": lily_warnings, "quality": quality,
    }
    (out / "alignment.json").write_text(json.dumps(result, indent=1))
    print(f"  {quality} Whisper heard {heard}/{len(lyrics.words)} words; audio is {offset:+.2f} s from the score.")
    for w in lily_warnings:
        print(f"  lilypond: {w}")
    print(f"  {out / (meta['id'] + '-chords.pdf')}\n  {out / (meta['id'] + '-lead-sheet.pdf')}")
    return result


def main():
    # WeasyPrint dlopens Pango from Homebrew, which macOS only searches when told to at process start.
    brew_lib = "/opt/homebrew/lib"
    if sys.platform == "darwin" and brew_lib not in os.environ.get("DYLD_FALLBACK_LIBRARY_PATH", ""):
        env = dict(os.environ, DYLD_FALLBACK_LIBRARY_PATH=f"{brew_lib}:/usr/local/lib:/usr/lib")
        os.execve(sys.executable, [sys.executable, *sys.argv], env)
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("songs", nargs="+", type=Path, help="song folders with audio.flac, score.abc, request.json")
    parser.add_argument("--out", type=Path, default=REPO / "sheets", help="output root (default: sheets/)")
    args = parser.parse_args()
    failed = []
    for song in args.songs:
        if not all((song / f).exists() for f in ("audio.flac", "score.abc", "request.json")):
            print(f"{song}: skipped, needs audio.flac, score.abc and request.json")
            continue
        try:
            run(song.resolve(), args.out.resolve())
        except Exception as exc:  # keep going through a batch; report at the end
            print(f"{song}: FAILED: {exc}", file=sys.stderr)
            failed.append(song)
    sys.exit(1 if failed else 0)


if __name__ == "__main__":
    main()
