"""Tame the s-sounds in a YuE2 song.

YuE2 often sings an s far too long, or twice in a row ("s-s-sea", about half a second where a sung s
takes about 150 ms). The s lives in the vocal, so the vocal stem (Demucs) is used to find and treat it,
and only the change is applied to the song: everything else in the mix stays bit for bit as it was.

Usage: sibilance.py <song.flac> <vocals.wav> <out.flac> soften|shorten
  soften   every s 8 dB down
  shorten  each s cut to its last 140 ms before the vowel and 4 dB down; whatever comes earlier,
           including a doubled s, 18 dB down
"""
import sys
from math import gcd
import numpy as np
import soundfile as sf
import scipy.signal as ss
import scipy.ndimage as nd

N_FFT, HOP = 1024, 256
SPLIT = 3500        # only the band above this is turned down
GAP = 0.15          # s-bursts closer than this are one s
KEEP = 0.14         # "shorten" keeps this much of each s, the part right before the vowel


def db(x):
    return 10 ** (x / 20)


def main():
    song_path, vocal_path, out_path, mode = sys.argv[1:5]
    song, sr = sf.read(song_path, dtype='float64', always_2d=True)
    vocal, vsr = sf.read(vocal_path, dtype='float64', always_2d=True)
    if vsr != sr:  # Demucs writes 44.1 kHz
        g = gcd(sr, vsr)
        vocal = ss.resample_poly(vocal, sr // g, vsr // g, axis=0)
    vocal = np.pad(vocal, ((0, max(0, len(song) - len(vocal))), (0, 0)))[:len(song)]
    f, t, Z = ss.stft(vocal.mean(1), sr, nperseg=N_FFT, noverlap=N_FFT - HOP)
    power = np.abs(Z) ** 2
    hi = 10 * np.log10(power[(f > 4000) & (f < 14000)].sum(0) + 1e-12)
    lo = 10 * np.log10(power[(f > 150) & (f < 2500)].sum(0) + 1e-12)
    sib = nd.binary_opening((hi - lo > 0) & (hi > -48), np.ones(3))
    sib = nd.binary_closing(sib, np.ones(int(GAP * sr / HOP)))
    frame = HOP / sr
    cut = np.zeros(len(t))
    labels, count = nd.label(sib)
    for k in range(1, count + 1):
        idx = np.flatnonzero(labels == k)
        if mode == 'soften':
            cut[idx] = -8
        else:
            keep = int(KEEP / frame)
            cut[idx[-keep:]] = -4
            cut[idx[:-keep]] = -18
    # 10 ms ramps so the gain changes do not click.
    gain = db(nd.uniform_filter1d(cut, max(1, int(0.01 / frame))))
    band = (f > SPLIT)[:, None]
    out = song.copy()
    for c in range(vocal.shape[1]):
        _, _, V = ss.stft(vocal[:, c], sr, nperseg=N_FFT, noverlap=N_FFT - HOP)
        _, change = ss.istft(V * band * (gain[None, :] - 1), sr, nperseg=N_FFT, noverlap=N_FFT - HOP)
        out[:, c] += change[:len(song)]
    sf.write(out_path, np.clip(out, -1, 1), sr, subtype='PCM_24')
    print(f'{count} s-sounds, {mode}')


if __name__ == '__main__':
    main()
