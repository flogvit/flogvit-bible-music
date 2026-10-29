#!/usr/bin/env python3
"""
Gather everything about a finished song into one folder: library/<id>/ with audio.flac, audio.mp3,
chords.pdf, chords.cho, leadsheet.pdf and info.json (title, lyrics, tags, links, how and where it was made).

Usage: python3 scripts/build-library.py [--machine NAME] [--library DIR] YuE/outputs/<batch>/<id> [...]

The song needs its sheets first (scripts/song-sheets.py). The library goes next to YuE/ (music/library/) unless
--library says otherwise; it is not in git. Needs ffmpeg. Standard library only, so plain python3 runs it.
"""
from __future__ import annotations

import argparse
import json
import os
import re
import shutil
import socket
import subprocess
import sys
from datetime import datetime, timezone
from pathlib import Path

REPO = Path(__file__).resolve().parent.parent
SITE = "https://bible.flogvit.com/en"

# bookId: (short name in bible.flogvit.com URLs, English name)
BOOKS = {
    1: ("1Mos", "Genesis"), 2: ("2Mos", "Exodus"), 3: ("3Mos", "Leviticus"), 4: ("4Mos", "Numbers"),
    5: ("5Mos", "Deuteronomy"), 6: ("Jos", "Joshua"), 7: ("Dom", "Judges"), 8: ("Rut", "Ruth"),
    9: ("1Sam", "1 Samuel"), 10: ("2Sam", "2 Samuel"), 11: ("1Kong", "1 Kings"), 12: ("2Kong", "2 Kings"),
    13: ("1Krøn", "1 Chronicles"), 14: ("2Krøn", "2 Chronicles"), 15: ("Esr", "Ezra"), 16: ("Neh", "Nehemiah"),
    17: ("Est", "Esther"), 18: ("Job", "Job"), 19: ("Sal", "Psalms"), 20: ("Ord", "Proverbs"),
    21: ("Fork", "Ecclesiastes"), 22: ("Høy", "Song of Solomon"), 23: ("Jes", "Isaiah"), 24: ("Jer", "Jeremiah"),
    25: ("Klag", "Lamentations"), 26: ("Esek", "Ezekiel"), 27: ("Dan", "Daniel"), 28: ("Hos", "Hosea"),
    29: ("Joel", "Joel"), 30: ("Amos", "Amos"), 31: ("Ob", "Obadiah"), 32: ("Jona", "Jonah"), 33: ("Mika", "Micah"),
    34: ("Nah", "Nahum"), 35: ("Hab", "Habakkuk"), 36: ("Sef", "Zephaniah"), 37: ("Hag", "Haggai"),
    38: ("Sak", "Zechariah"), 39: ("Mal", "Malachi"), 40: ("Matt", "Matthew"), 41: ("Mark", "Mark"),
    42: ("Luk", "Luke"), 43: ("Joh", "John"), 44: ("Apg", "Acts"), 45: ("Rom", "Romans"),
    46: ("1Kor", "1 Corinthians"), 47: ("2Kor", "2 Corinthians"), 48: ("Gal", "Galatians"), 49: ("Ef", "Ephesians"),
    50: ("Fil", "Philippians"), 51: ("Kol", "Colossians"), 52: ("1Tess", "1 Thessalonians"),
    53: ("2Tess", "2 Thessalonians"), 54: ("1Tim", "1 Timothy"), 55: ("2Tim", "2 Timothy"), 56: ("Tit", "Titus"),
    57: ("Filem", "Philemon"), 58: ("Hebr", "Hebrews"), 59: ("Jak", "James"), 60: ("1Pet", "1 Peter"),
    61: ("2Pet", "2 Peter"), 62: ("1Joh", "1 John"), 63: ("2Joh", "2 John"), 64: ("3Joh", "3 John"),
    65: ("Jud", "Jude"), 66: ("Åp", "Revelation"),
}

TEXT_CREDITS = {
    "osen": "Bible quotations from the osen English translation in free-bible (CC BY 4.0), translated from "
            "the SBL Greek New Testament (SBLGNT) and the Hebrew text from tanach.us.",
    "kjv": "Bible quotations from the King James Version (public domain).",
}


def url_slug(text: str) -> str:
    # Same as toUrlSlug in bible.flogvit.com: lower case, å→a, ø→o, æ→ae.
    return text.lower().replace("å", "a").replace("ø", "o").replace("æ", "ae")


def passage(p: dict) -> dict:
    short, name = BOOKS[p["bookId"]]
    out = dict(p)
    url = f"{SITE}/{url_slug(short)}/{p['chapter']}"
    if "verseStart" in p:
        verses = str(p["verseStart"]) if p["verseStart"] == p["verseEnd"] else f"{p['verseStart']}-{p['verseEnd']}"
        out["label"] = f"{name} {p['chapter']}:{verses}"
        url += f"#v{p['verseStart']}"
    else:
        out["label"] = f"{name} {p['chapter']}"
    out["url"] = url
    return out


def free_bible() -> Path:
    return Path(os.environ.get("FREE_BIBLE", REPO.parent / "free-bible")) / "generate"


def named(kind: str, slug: str) -> dict:
    """A story, person or theme slug with its English title from free-bible and its page on the site."""
    folder, path = {"stories": ("stories", "historier"), "persons": ("persons", "personer"),
                    "themes": ("themes", "temaer")}[kind]
    entry = {"slug": slug, "url": f"{SITE}/{path}/{slug}"}
    file = free_bible() / folder / "en" / f"{slug}.json"
    if file.exists():
        data = json.loads(file.read_text())
        # Persons have a name and an epithet ("title"); stories and themes only a title.
        entry["title"] = (data.get("name") if kind == "persons" else None) or data.get("title") or slug
        if kind == "persons" and data.get("title"):
            entry["epithet"] = data["title"]
    return entry


def anchor_info(song: dict) -> dict:
    a = song["anchor"]
    if song["kind"] in ("verse", "chapter"):
        return passage(a)
    kind, key = {"story": ("stories", "story"), "person": ("persons", "person"), "theme": ("themes", "theme")}[song["kind"]]
    info = named(kind, a[key])
    return {key: a[key], "label": info.get("title", a[key]), "url": info["url"]}


def parse_lyrics(text: str) -> list[dict]:
    sections, current = [], None
    for line in text.splitlines():
        m = re.fullmatch(r"\[(.+)\]", line.strip())
        if m:
            current = {"section": m.group(1), "lines": []}
            sections.append(current)
        elif line.strip() and current is not None:
            current["lines"].append(line.strip())
    return sections


def score_header(abc: str) -> dict:
    head = {}
    for line in abc.splitlines():
        m = re.match(r"([KMQ]):(.*)", line)
        if m and m.group(1) not in head:
            head[m.group(1)] = m.group(2).strip()
    out = {}
    if "K" in head:
        out["key"] = head["K"]
    if "M" in head:
        out["meter"] = head["M"]
    if "Q" in head:
        q = re.search(r"(\d+)\s*$", head["Q"])
        if q:
            out["bpm"] = int(q.group(1))
    return out


def yue_info(song_dir: Path, result: dict, config: dict) -> dict:
    yue = song_dir.parents[2]  # YuE/outputs/<batch>/<id> -> YuE
    info: dict = {}
    for pattern, key in (("yue2_infer-*.dist-info", "package"), ("torch-*.dist-info", "torch")):
        found = sorted((yue / ".venv").glob(f"lib/python*/site-packages/{pattern}"))
        if found:
            name, version = found[-1].name.removesuffix(".dist-info").split("-", 1)
            info[key] = f"{name.replace('_', '-')} {version}"
    try:
        info["commit"] = subprocess.run(["git", "-C", str(yue), "rev-parse", "--short", "HEAD"],
                                        capture_output=True, text=True, check=True).stdout.strip()
        info["patched"] = bool(subprocess.run(["git", "-C", str(yue), "diff", "--quiet"]).returncode)
    except (OSError, subprocess.CalledProcessError):
        pass
    models = {}
    hub = Path.home() / ".cache" / "huggingface" / "hub"
    for key, repo in (("mot", "m-a-p/YuE2-3B"), ("vae", "m-a-p/YuE2-Vae")):
        entry = {"repo": repo}
        ref = hub / f"models--{repo.replace('/', '--')}" / "refs" / "main"
        if ref.exists():
            entry["revision"] = ref.read_text().strip()
        files = result.get("weights", {}).get(key, {}).get("files", {})
        if files:
            entry["sha256"] = {name: f["sha256"] for name, f in files.items()}
        models[key] = entry
    info["models"] = models
    gen = config.get("generation", {})
    info["config"] = {"version": gen.get("version"), "maxAudioTokens": gen.get("semantic", {}).get("max_tokens"),
                      "cot": config.get("cot"), "cfgScale": config.get("cfg_scale")}
    info["truncated"] = result.get("truncated")
    return info


def lyrics_on_notes(alignment: dict) -> dict:
    lines = alignment.get("lines", [])
    uncertain = [l["text"] for l in lines if l.get("uncertain")]
    return {
        "summary": alignment.get("quality"),
        "lines": len(lines),
        "linesOnTheirNotes": len(lines) - len(uncertain),
        "uncertainLines": uncertain,
        "wordsHeard": alignment.get("words_heard"),
        "words": alignment.get("words"),
        "audioOffsetSeconds": round(alignment.get("offset_seconds", 0.0), 2),
        "checkedWith": "Whisper large-v3 (scripts/song-sheets.py)",
    }


def place(src: Path, dst: Path) -> None:
    """Hard-link when possible (same disk, no extra space), copy otherwise; replaces an older file."""
    if dst.exists() or dst.is_symlink():
        if dst.stat().st_ino == src.stat().st_ino:
            return
        dst.unlink()
    try:
        os.link(src, dst)
    except OSError:
        shutil.copy2(src, dst)


def mp3(flac: Path, dst: Path, song: dict) -> None:
    if dst.exists() and dst.stat().st_mtime >= flac.stat().st_mtime:
        return
    tmp = dst.with_suffix(".tmp.mp3")
    anchor = anchor_info(song)
    subprocess.run(["ffmpeg", "-nostdin", "-loglevel", "error", "-y", "-i", str(flac), "-map_metadata", "-1",
                    "-codec:a", "libmp3lame", "-q:a", "0",
                    "-metadata", f"title={song['title']}", "-metadata", "album=Bible songs (bible.flogvit.com)",
                    "-metadata", f"genre={', '.join(song['tags']['style'])}",
                    "-metadata", f"comment={anchor['label']} - {anchor['url']}", str(tmp)], check=True)
    tmp.replace(dst)


def build(song_dir: Path, library: Path, machine: str) -> Path:
    song_dir = song_dir.resolve()
    sid = song_dir.name
    catalog = REPO / "catalog" / f"{sid}.json"
    sheets = REPO / "sheets" / sid
    result_file = song_dir / "result.json"
    needed = [catalog, result_file, song_dir / "audio.flac", sheets / f"{sid}-chords.pdf",
              sheets / f"{sid}-chords.cho", sheets / f"{sid}-lead-sheet.pdf", sheets / "alignment.json"]
    missing = [str(p) for p in needed if not p.exists()]
    if missing:
        raise FileNotFoundError("missing " + ", ".join(missing))

    song = json.loads(catalog.read_text())
    result = json.loads(result_file.read_text())
    config = json.loads((song_dir / "config.json").read_text()) if (song_dir / "config.json").exists() else {}
    request = json.loads((song_dir / "request.json").read_text())
    alignment = json.loads((sheets / "alignment.json").read_text())

    out = library / sid
    out.mkdir(parents=True, exist_ok=True)
    place(song_dir / "audio.flac", out / "audio.flac")
    mp3(song_dir / "audio.flac", out / "audio.mp3", song)
    place(sheets / f"{sid}-chords.pdf", out / "chords.pdf")
    place(sheets / f"{sid}-chords.cho", out / "chords.cho")
    place(sheets / f"{sid}-lead-sheet.pdf", out / "leadsheet.pdf")

    seconds = result["audio_seconds"]
    made = datetime.fromtimestamp(result_file.stat().st_mtime, timezone.utc).astimezone()
    tags = song["tags"]
    info = {
        "id": sid,
        "title": song["title"],
        "kind": song["kind"],
        "anchor": anchor_info(song),
        "url": anchor_info(song)["url"],
        "references": [passage(r) for r in song["references"]],
        "style": tags["style"],
        "styleDescription": request["style"],
        "tags": {
            "sentiment": tags["sentiment"], "liturgy": tags["liturgy"], "theme": tags["theme"],
            "themes": [named("themes", s) for s in tags["themes"]],
            "stories": [named("stories", s) for s in tags["stories"]],
            "persons": [named("persons", s) for s in tags["persons"]],
        },
        "lyrics": {"sections": parse_lyrics(request["lyrics"]), "text": request["lyrics"]},
        "lyricsMode": song["lyricsMode"],
        "textSource": song["textSource"],
        "textCredit": TEXT_CREDITS.get(song["textSource"], song["textSource"]),
        "music": {"durationSeconds": round(seconds, 1), "duration": f"{int(seconds) // 60}:{int(seconds) % 60:02d}",
                  **(score_header((song_dir / "score.abc").read_text()) if (song_dir / "score.abc").exists() else {})},
        "seed": request["seed"],
        "lyricsOnNotes": lyrics_on_notes(alignment),
        "generated": {"machine": machine, "date": made.isoformat(timespec="seconds"),
                      "yue": yue_info(song_dir, result, config), "identity": result.get("identity"),
                      "source": str(song_dir)},
        "files": {"flac": "audio.flac", "mp3": "audio.mp3", "chordSheet": "chords.pdf", "chordPro": "chords.cho",
                  "leadSheet": "leadsheet.pdf"},
    }
    (out / "info.json").write_text(json.dumps(info, indent=2, ensure_ascii=False) + "\n")
    return out


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("songs", nargs="+", type=Path, help="finished song folders, YuE/outputs/<batch>/<id>")
    parser.add_argument("--library", type=Path, help="library root (default: library/ next to YuE/)")
    parser.add_argument("--machine", default=os.environ.get("MUSIC_MACHINE", socket.gethostname()),
                        help="which machine made the songs (default: $MUSIC_MACHINE or the host name)")
    args = parser.parse_args()
    failed = 0
    for song_dir in args.songs:
        library = args.library or song_dir.resolve().parents[3] / "library"
        try:
            print(build(song_dir, library, args.machine))
        except Exception as exc:  # one broken song should not stop the rest
            failed += 1
            print(f"{song_dir}: FAILED: {exc}", file=sys.stderr)
    return 1 if failed else 0


if __name__ == "__main__":
    sys.exit(main())
