#!/bin/zsh
# Install (or with --uninstall remove) the launchd agent that keeps scripts/generate.ts run going on this Mac.
#
#   MUSIC_MACHINE="M5 (MacBook Pro, M5 Max, 128 GB)" scripts/install-generator.sh --from-end
#
# launchd starts it at login and starts it again 10 minutes after it stops: after a crash, after a lost network
# at start, and when no song was free (another machine may have given one back). Run it from a worktree of its
# own: it generates with the scripts in that checkout and pushes the sheets to its branch. Logs go to
# ~/Library/Logs/music-generate.log. --uninstall stops it, and the song it was making is given back at once.
set -eu
label=com.flogvit.music-generate
plist=$HOME/Library/LaunchAgents/$label.plist
domain=gui/$(id -u)

if [[ ${1:-} == --uninstall ]]; then
  launchctl bootout $domain/$label 2>/dev/null || true
  rm -f $plist
  echo "removed $label"
  exit 0
fi

repo=${0:A:h:h}
: ${MUSIC_MACHINE:?set MUSIC_MACHINE to the name of this machine}
bun=$(command -v bun) || { echo "bun not found" >&2; exit 1; }
python=$(command -v python3) || { echo "python3 not found" >&2; exit 1; }
args=${1:+<string>$1</string>}
# The lyrics check's settings (README, Lyrics check), passed on when set here.
extra=
for key in MUSIC_MAX_ATTEMPTS MUSIC_JUDGE_MODEL; do
  [[ -n ${(P)key:-} ]] && extra+="
    <key>$key</key><string>${(P)key}</string>"
done

mkdir -p ${plist:h}
cat > $plist <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>Label</key><string>$label</string>
  <key>ProgramArguments</key>
  <array><string>$bun</string><string>scripts/generate.ts</string><string>run</string>$args</array>
  <key>WorkingDirectory</key><string>$repo</string>
  <key>EnvironmentVariables</key>
  <dict>
    <key>MUSIC_MACHINE</key><string>$MUSIC_MACHINE</string>$extra
    <key>PATH</key><string>${bun:h}:${python:h}:/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin</string>
  </dict>
  <key>RunAtLoad</key><true/>
  <key>KeepAlive</key><true/>
  <key>ThrottleInterval</key><integer>600</integer>
  <key>StandardOutPath</key><string>$HOME/Library/Logs/music-generate.log</string>
  <key>StandardErrorPath</key><string>$HOME/Library/Logs/music-generate.log</string>
</dict>
</plist>
EOF
launchctl bootout $domain/$label 2>/dev/null || true
launchctl bootstrap $domain $plist
echo "installed $label: generates as $MUSIC_MACHINE${1:+ ($1)} from $repo"
