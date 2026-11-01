#!/bin/bash
# Make a list of catalog songs one after another with `generate.ts remake`, on a Mac whose generator keeps running:
# each song starts as soon as no other YuE generation runs, and the generator waits for it in turn. Used for songs
# that are on a branch and not yet in main's catalog (a test group), from a checkout of that branch.
#
#   MUSIC_MACHINE="M5 (MacBook Pro, M5 Max, 128 GB), style probes" scripts/remake-queue.sh [--reverse] <id> ...
#
# A song that is done, held by another machine, or rejected MUSIC_MAX_ATTEMPTS times (default 3) is skipped, so two
# Macs can run the same list from opposite ends (--reverse on one of them). Its log goes to the terminal.
set -u
cd "$(dirname "$0")/.."
: "${MUSIC_MACHINE:?set MUSIC_MACHINE to this Mac with a suffix of its own, as for remake}"
MAX=${MUSIC_MAX_ATTEMPTS:-3}
ids=()
reverse=0
for a in "$@"; do
  if [ "$a" = "--reverse" ]; then reverse=1; else ids+=("$a"); fi
done
if [ "$reverse" = 1 ]; then
  rev=()
  for ((i=${#ids[@]}-1; i>=0; i--)); do rev+=("${ids[$i]}"); done
  ids=("${rev[@]}")
fi

state() {  # the subject of the song's lock, and how many takes were rejected since the last remake or retry
  git fetch -q origin "+refs/claims/$1:refs/claims/$1" 2>/dev/null || { echo "free 0"; return; }
  local subjects
  subjects=$(git log --format=%s "refs/claims/$1")
  local rejected
  rejected=$(printf '%s\n' "$subjects" | grep -c '^rejected ')
  echo "$(printf '%s\n' "$subjects" | head -1 | cut -d' ' -f1) $rejected"
}

for id in "${ids[@]}"; do
  for ((try=1; try<=MAX; try++)); do
    read -r subject rejected <<<"$(state "$id")"
    if [ "$subject" = done ]; then echo "$(date +%T) SKIP $id: done"; break; fi
    if [ "$rejected" -ge "$MAX" ]; then echo "$(date +%T) SKIP $id: rejected $rejected times"; break; fi
    while pgrep -f '^[^ ]*python[^ ]* [^ ]*yue2 batch' >/dev/null; do sleep 2; done
    echo "$(date +%T) START $id (try $try)"
    bun scripts/generate.ts remake "$id"
    code=$?
    if [ "$code" = 0 ]; then break; fi
    if [ "$code" = 1 ]; then echo "$(date +%T) SKIP $id: held by another machine"; break; fi
  done
done
echo "$(date +%T) QUEUE END"
