#!/bin/zsh
# Publish this machine's finished songs to media.flogvit.com when any are new. Run by a timer on each machine
# (scripts/install-publisher.sh sets up launchd); does nothing when no song in the library changed since the
# last publish.
#
# Environment:
#   MUSIC_LIBRARY   the library to publish (default: library/ in this repo)
#   MUSIC_MACHINE   this machine's name; it names its song list in the bucket, so keep it the same over time
#   S3_*, MEDIA_PREFIX  as in .env.example; default to flogvit-media on Scaleway, system/music/
# The S3 key is read from the scw CLI setup (~/.config/scw/config.yaml) on every run and never stored,
# unless S3_ACCESS_KEY and S3_SECRET_KEY are already set.
# With --update, the repo first moves to the newest origin/main, so the timer always runs the current scripts.
set -u
repo=${0:A:h:h}
cd $repo || exit 1
log() { echo "$(date '+%Y-%m-%d %H:%M:%S') $*"; }

if [[ ${1:-} == --update ]]; then
  if git fetch -q origin main 2>/dev/null && git cat-file -e origin/main:scripts/publish-auto.sh 2>/dev/null; then
    [[ $(git rev-parse HEAD) == $(git rev-parse origin/main) ]] || git checkout -q --detach origin/main
  else
    log "could not update from origin/main; publishing with $(git rev-parse --short HEAD)"
  fi
fi

library=${MUSIC_LIBRARY:-$repo/library}
stamp=$library/.published
[[ -d $library ]] || { log "FAILED: no library at $library"; exit 1; }
if [[ -e $stamp ]] && [[ -z $(find $library -mindepth 2 -maxdepth 2 -newer $stamp -print -quit) ]]; then
  exit 0  # nothing new
fi

export S3_ENDPOINT=${S3_ENDPOINT:-https://s3.fr-par.scw.cloud} S3_REGION=${S3_REGION:-fr-par}
export S3_BUCKET=${S3_BUCKET:-flogvit-media} MEDIA_PREFIX=${MEDIA_PREFIX:-system/music/}
if [[ -z ${S3_ACCESS_KEY:-} || -z ${S3_SECRET_KEY:-} ]]; then
  cfg=$HOME/.config/scw/config.yaml
  export S3_ACCESS_KEY=$(awk '/^access_key:/ {print $2; exit}' $cfg 2>/dev/null)
  export S3_SECRET_KEY=$(awk '/^secret_key:/ {print $2; exit}' $cfg 2>/dev/null)
  [[ -n $S3_ACCESS_KEY && -n $S3_SECRET_KEY ]] || { log "FAILED: no S3 key in the environment or in $cfg"; exit 1; }
fi

touch $stamp.next
if out=$(bun scripts/publish.ts --library $library 2>&1); then
  mv $stamp.next $stamp
  log "${out##*$'\n'}"
else
  rm -f $stamp.next
  log "FAILED: ${out##*$'\n'}"
  exit 1
fi
