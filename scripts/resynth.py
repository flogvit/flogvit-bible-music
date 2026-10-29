"""Re-synthesize a finished YuE2 song from its saved audio tokens with another number of ODE steps.

The score and the audio tokens (the performance) stay the same; only the audio rendering changes.

Usage (from YuE/): .venv/bin/python ../scripts/resynth.py <song dir> <out dir> <steps> [<steps> ...]
Writes <out dir>/steps-<n>.flac for each step count.
"""
import dataclasses, sys, time
from pathlib import Path
import numpy as np
import soundfile as sf
from yue2.pipeline import SemanticResult, SymbolicPlan, YuE2Pipeline


def main():
    song, out = Path(sys.argv[1]), Path(sys.argv[2])
    out.mkdir(parents=True, exist_ok=True)
    plan = SymbolicPlan.load(song)
    tokens = np.load(song / "semantic.npy").tolist()
    pipe = YuE2Pipeline.from_pretrained(local_files_only=True)
    for steps in map(int, sys.argv[3:]):
        pipe.generation_config = dataclasses.replace(pipe.generation_config, ode_steps=steps)
        start = time.perf_counter()
        latents = pipe.synthesize(SemanticResult(plan, tokens, {}, False))
        audio = pipe.decode(latents)
        sf.write(out / f"steps-{steps}.flac", audio, 48000, subtype="PCM_24")
        print(f"steps {steps}: {time.perf_counter() - start:.0f} s", flush=True)


if __name__ == "__main__":
    main()
