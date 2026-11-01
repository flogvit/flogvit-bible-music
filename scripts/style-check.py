#!/usr/bin/env python3
"""
Does a song sound like the style it was asked for, and does it sound different from the songs we already have?

CLAP (laion/larger_clap_music, a model that puts music and text descriptions in one space) listens to the song in
10-second windows. Two numbers come out per song:

- style rank: the song's own style (its catalog tags.style[0]) among the descriptions of every style in STYLES,
  by how close the audio is to each description. 1 is best; the top three are printed too.
- nearest song: the most similar song already in library/ (cosine of the audio embeddings), so a new style that
  only sounds like more of the same shows up as a high similarity to an old song.

Usage:
  .venv-style/bin/python scripts/style-check.py <song folder> [...]      # YuE/outputs/catalog/<id> or library/<id>
  .venv-style/bin/python scripts/style-check.py --json out.json <song folder> [...]
Setup: uv venv --python 3.12 .venv-style && uv pip install --python .venv-style/bin/python torch transformers librosa
The library embeddings are cached in YuE/outputs/style-embeddings.json in the main checkout.
"""
import argparse
import json
import subprocess
import sys
from pathlib import Path

import numpy as np

REPO = Path(__file__).resolve().parent.parent
MAIN = Path(subprocess.run(["git", "rev-parse", "--path-format=absolute", "--git-common-dir"], cwd=REPO,
                           capture_output=True, text=True, check=True).stdout.strip()).parent
CACHE = MAIN / "YuE" / "outputs" / "style-embeddings.json"
MODEL = "laion/larger_clap_music"
SR = 48000
WINDOW = 10

# One plain description per style, in the words a listener would use. The first 16 are the catalog's styles before
# docs/research/style-breadth.md; the rest came with it.
STYLES = {
    "folk": "acoustic folk song with guitar and a warm voice",
    "gospel": "gospel song with organ, piano and a choir",
    "soul": "soul music with a smooth singer, bass and electric piano",
    "rock": "rock song with electric guitars and drums",
    "worship": "modern worship song with piano, pads and a building band",
    "pop": "pop song with a catchy melody and polished production",
    "orchestral": "orchestral song with strings and a full orchestra",
    "jazz": "jazz with piano trio, swing and a jazzy singer",
    "hymn": "traditional church hymn with organ",
    "country": "country song with steel guitar and fiddle",
    "choral": "choir singing a classical sacred piece",
    "children": "cheerful children's song",
    "celtic": "celtic folk with tin whistle, fiddle and harp",
    "blues": "blues with slide guitar and a gritty voice",
    "ballad": "slow emotional piano ballad",
    "acoustic": "soft acoustic singer-songwriter song",
    "gregorian": "Gregorian chant, monks singing in unison without instruments",
    "taize": "meditative repetitive chant sung by a choir with soft guitar",
    "byzantine": "Byzantine Orthodox chant with a deep drone and male choir",
    "polyphony": "Renaissance a cappella choir polyphony",
    "baroque": "Baroque oratorio with harpsichord, strings, trumpets and choir",
    "sacred-harp": "Sacred Harp shape-note singing, a loud raw congregation without instruments",
    "spiritual": "African-American spiritual with call and response, claps and stomps",
    "southern-gospel": "Southern gospel male quartet with piano",
    "bluegrass": "bluegrass with banjo, mandolin and fiddle",
    "mass-choir": "big black gospel mass choir with Hammond organ and band",
    "bedehus": "Norwegian revival song with accordion and guitar in waltz time",
    "brass-band": "brass band march",
    "kveding": "Nordic folk singing with Hardanger fiddle",
    "isicathamiya": "South African a cappella male choir",
    "highlife": "West African highlife with bright guitars and horns",
    "salsa": "salsa with piano montuno, congas and trumpets",
    "reggae": "reggae with one drop drums and offbeat guitar",
    "hiphop": "hip hop with a rapper over boom bap drums",
    "spoken-word": "spoken word poetry over ambient piano",
    "metal": "heavy metal with distorted guitars and double kick drums",
    "punk": "fast punk rock with shouted vocals",
    "edm": "EDM dance music with synths, a build and a drop",
    "ambient": "ambient music with slow synth pads and no drums",
    "lofi": "lo-fi hip hop beat with dusty drums and Rhodes",
    "musical": "musical theatre duet with orchestra",
    "lullaby": "soft lullaby with music box",
    "shanty": "sea shanty sung by a crew with stomps and accordion",
    "lament": "slow mournful lament with cello and an old weary voice",
    "middle-eastern": "Middle Eastern music with oud, darbuka and frame drums",
    "klezmer": "klezmer with clarinet, violin and accordion",
    "coptic": "Coptic church chant with cymbals and triangle",
    "armenian": "Armenian sacred chant with duduk",
    "anthem": "triumphant cinematic anthem with choir, brass and timpani",
    "childrens-choir": "children's choir singing",
    "chorale": "congregation singing a chorale with pipe organ",
    "bhajan": "Indian devotional bhajan with harmonium and tabla",
    "instrumental": "instrumental music without singing",
}

_model = _processor = None


def model():
    global _model, _processor
    if _model is None:
        import torch
        from transformers import ClapModel, ClapProcessor
        # Two threads, so a YuE generation on the same Mac keeps its CPU (its compiled decode recompiles on the CPU).
        torch.set_num_threads(2)
        _model = ClapModel.from_pretrained(MODEL).eval()
        _processor = ClapProcessor.from_pretrained(MODEL)
    return _model, _processor


def audio_file(folder: Path) -> Path:
    for name in ("audio.flac", "audio.mp3"):
        if (folder / name).exists():
            return folder / name
    raise FileNotFoundError(f"no audio in {folder}")


def embed_audio(path: Path) -> np.ndarray:
    import librosa
    import torch
    y, _ = librosa.load(path, sr=SR, mono=True)
    n = SR * WINDOW
    # Six windows spread over the song, past the intro and before the fade.
    starts = np.linspace(len(y) * 0.08, max(len(y) * 0.92 - n, len(y) * 0.08), num=6).astype(int)
    clips = [y[s:s + n] for s in starts if len(y[s:s + n]) == n] or [y[:n]]
    m, p = model()
    with torch.no_grad():
        inputs = p(audio=clips, sampling_rate=SR, return_tensors="pt")
        e = m.get_audio_features(**inputs)
        e = getattr(e, "pooler_output", e)
    e = torch.nn.functional.normalize(e, dim=-1).mean(0)
    return torch.nn.functional.normalize(e, dim=0).numpy()


def embed_texts(texts: list[str]) -> np.ndarray:
    import torch
    m, p = model()
    with torch.no_grad():
        e = m.get_text_features(**p(text=texts, return_tensors="pt", padding=True))
        e = getattr(e, "pooler_output", e)
    return torch.nn.functional.normalize(e, dim=-1).numpy()


def song_style(folder: Path) -> str:
    sid = folder.name
    entry = REPO / "catalog" / f"{sid}.json"
    if entry.exists():
        return json.loads(entry.read_text())["tags"]["style"][0]
    info = folder / "info.json"
    return json.loads(info.read_text())["style"][0] if info.exists() else "?"


def library_embeddings(skip: set[str]) -> dict[str, np.ndarray]:
    cache = json.loads(CACHE.read_text()) if CACHE.exists() else {}
    changed = False
    for d in sorted((MAIN / "library").iterdir()):
        if not d.is_dir() or d.name in cache:
            continue
        try:
            cache[d.name] = embed_audio(audio_file(d)).round(5).tolist()
            changed = True
            print(f"  embedded library/{d.name}", file=sys.stderr, flush=True)
        except FileNotFoundError:
            continue
        if len(cache) % 10 == 0:
            CACHE.write_text(json.dumps(cache))
    if changed:
        CACHE.write_text(json.dumps(cache))
    return {k: np.array(v) for k, v in cache.items() if k not in skip}


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("songs", nargs="+", type=Path)
    ap.add_argument("--json", type=Path, help="also write the results here")
    args = ap.parse_args()
    names = list(STYLES)
    texts = embed_texts([STYLES[n] for n in names])
    ids = {s.name for s in args.songs}
    library = library_embeddings(skip=ids)
    # Songs of the new styles are compared only with the songs of the 16 styles we had.
    old = set(names[:16])
    old_library = {k: v for k, v in library.items() if song_style(MAIN / "library" / k) in old}
    results = []
    for folder in args.songs:
        e = embed_audio(audio_file(folder))
        sims = texts @ e
        order = [names[i] for i in np.argsort(-sims)]
        style = song_style(folder)
        nearest = max(old_library.items(), key=lambda kv: float(kv[1] @ e)) if old_library else (None, None)
        r = {"id": folder.name, "style": style, "rank": order.index(style) + 1 if style in order else None,
             "top3": order[:3], "nearest": nearest[0],
             "nearestSimilarity": round(float(nearest[1] @ e), 3) if nearest[0] else None}
        results.append(r)
        print(f"{r['id']}: {style} rank {r['rank']} of {len(names)}; top {', '.join(r['top3'])}; "
              f"nearest old song {r['nearest']} ({r['nearestSimilarity']})", flush=True)
    if args.json:
        args.json.write_text(json.dumps(results, indent=1) + "\n")


if __name__ == "__main__":
    main()
