"""Turn down the noise-like part of a YuE2 song's treble, keeping its tones and its attacks.

YuE2 renders much of the band above ~6 kHz as shaped noise that follows the music, so a denoiser with a
noise profile has nothing fixed to subtract. Instead the treble is split into tonal, percussive and
residual (noise) parts with harmonic-percussive separation, and only the residual is turned down.

Usage: dehiss.py <in.flac> <out.flac> [residual gain in dB, default -8]
"""
import sys
import numpy as np
import librosa
import soundfile as sf

LOW, HIGH = 4500, 7000   # the residual gain fades in from LOW to HIGH Hz


def main():
    audio, sr = sf.read(sys.argv[1], dtype='float32', always_2d=True)
    gain = 10 ** (float(sys.argv[3] if len(sys.argv) > 3 else -8) / 20)
    n_fft, hop = 2048, 512
    freqs = librosa.fft_frequencies(sr=sr, n_fft=n_fft)
    fade = np.clip((freqs - LOW) / (HIGH - LOW), 0, 1)[:, None]
    out = np.zeros_like(audio)
    for c in range(audio.shape[1]):
        S = librosa.stft(audio[:, c], n_fft=n_fft, hop_length=hop)
        mag = np.abs(S)
        harmonic, percussive = librosa.decompose.hpss(mag, margin=2.0, mask=True)
        residual = np.clip(1 - harmonic - percussive, 0, 1)
        mask = 1 - fade * residual * (1 - gain)
        out[:, c] = librosa.istft(S * mask, hop_length=hop, length=len(audio))
    sf.write(sys.argv[2], out, sr, subtype='PCM_24')


if __name__ == '__main__':
    main()
