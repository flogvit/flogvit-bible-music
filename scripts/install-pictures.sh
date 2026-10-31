#!/bin/zsh
# Install (or with --uninstall remove) the launchd agent that keeps scripts/scenes.ts --watch going on this Mac:
# pictures for the big screen for every song in library/ without them, the newest first, and for each new song.
#
#   scripts/install-pictures.sh
#
# Run it from a checkout that nothing else uses, for example a worktree of its own beside the main checkout
# (git worktree add --detach ../music-pictures origin/main): the agent moves that checkout to the newest
# origin/main between songs, and starts again when the picture code changed. Not under .claude/worktrees/,
# where Dux's sweep removes idle worktrees. library/ and .venv-images are found in the main checkout.
# Logs go to ~/Library/Logs/music-pictures.log.
set -eu
label=com.flogvit.music-pictures
plist=$HOME/Library/LaunchAgents/$label.plist
domain=gui/$(id -u)

if [[ ${1:-} == --uninstall ]]; then
  launchctl bootout $domain/$label 2>/dev/null || true
  rm -f $plist
  echo "removed $label"
  exit 0
fi

repo=${0:A:h:h}
bun=$(command -v bun) || { echo "bun not found" >&2; exit 1; }
python=$(command -v python3) || { echo "python3 not found" >&2; exit 1; }
# The models' settings (README, Pictures for the big screen), passed on when set here.
extra=
for key in MUSIC_SCENES_MODEL MUSIC_LOOK_MODEL OLLAMA_HOST; do
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
  <array><string>$bun</string><string>scripts/scenes.ts</string><string>--watch</string></array>
  <key>WorkingDirectory</key><string>$repo</string>
  <key>EnvironmentVariables</key>
  <dict>
    <key>PATH</key><string>${bun:h}:${python:h}:/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin</string>$extra
  </dict>
  <key>RunAtLoad</key><true/>
  <key>KeepAlive</key><true/>
  <key>ThrottleInterval</key><integer>60</integer>
  <key>StandardOutPath</key><string>$HOME/Library/Logs/music-pictures.log</string>
  <key>StandardErrorPath</key><string>$HOME/Library/Logs/music-pictures.log</string>
</dict>
</plist>
EOF
launchctl bootout $domain/$label 2>/dev/null || true
launchctl bootstrap $domain $plist
echo "installed $label: pictures from $repo"
