#!/bin/bash
# Clean a YuE2 song stem by stem: split with Demucs, treat each stem, mix back at the original loudness.
# Usage: stem-clean.sh <in.flac> <out.flac> <python with demucs, librosa, soundfile>
# STEMS=<dir with vocals/other/drums/bass.wav> reuses an earlier Demucs split.
set -euo pipefail
in=$1; out=$2; py=$3
here=$(cd "$(dirname "$0")" && pwd)
work=$(mktemp -d)
trap 'rm -rf "$work"' EXIT

stems=${STEMS:-$work/htdemucs_ft/$(basename "${in%.*}")}
[ -n "${STEMS:-}" ] || "$py" -m demucs -n htdemucs_ft -d mps --float32 -o "$work" "$in" >/dev/null 2>&1

# Vocals: noise out of the treble, then tame the s-sounds.
"$py" "$here/dehiss.py" "$stems/vocals.wav" "$work/v1.flac" -12
ffmpeg -hide_banner -loglevel error -y -i "$work/v1.flac" -af "deesser=i=0.5:m=0.5:f=0.5" "$work/vocals.flac"
# Instruments: noise out of the treble.
"$py" "$here/dehiss.py" "$stems/other.wav" "$work/other.flac" -14
# Drums: keep the attacks, shorten the noisy tails between hits.
ffmpeg -hide_banner -loglevel error -y -i "$stems/drums.wav" \
  -af "agate=threshold=0.02:ratio=2.5:range=0.3:attack=1:release=90:knee=3" "$work/drums.flac"
# Bass: nothing it needs lives above 8 kHz.
ffmpeg -hide_banner -loglevel error -y -i "$stems/bass.wav" -af "lowpass=f=8000:p=2" "$work/bass.flac"

loudness() { ffmpeg -hide_banner -i "$1" -af ebur128 -f null - 2>&1 | awk '/^ +I:/{v=$2} END{print v}'; }
ffmpeg -hide_banner -loglevel error -y -i "$work/vocals.flac" -i "$work/other.flac" -i "$work/drums.flac" -i "$work/bass.flac" \
  -filter_complex "amix=inputs=4:normalize=0" -c:a pcm_f32le "$work/mix.wav"
# Same integrated loudness as the input, so a comparison is not won by being louder.
gain=$(echo "$(loudness "$in") - $(loudness "$work/mix.wav")" | bc -l)
ffmpeg -hide_banner -loglevel error -y -i "$work/mix.wav" -af "volume=${gain}dB,alimiter=limit=0.95:level=false" \
  -ar 48000 -c:a flac -sample_fmt s32 "$out"
