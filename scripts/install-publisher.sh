#!/bin/zsh
# Install (or with --uninstall remove) the launchd agent that runs scripts/publish-auto.sh every 10 minutes.
#
#   MUSIC_MACHINE="Home Mac (M1 Max, 64 GB)" MUSIC_LIBRARY=~/WebstormProjects/flogvit/music/library \
#     scripts/install-publisher.sh
#
# Run it from a checkout that nothing else uses, for example a worktree of its own: the agent moves that
# checkout to the newest origin/main before each run. Logs go to ~/Library/Logs/music-publish.log.
set -eu
label=com.flogvit.music-publish
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
: ${MUSIC_LIBRARY:?set MUSIC_LIBRARY to the library folder to publish}
bun=$(command -v bun) || { echo "bun not found" >&2; exit 1; }

mkdir -p ${plist:h}
cat > $plist <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>Label</key><string>$label</string>
  <key>ProgramArguments</key>
  <array><string>/bin/zsh</string><string>$repo/scripts/publish-auto.sh</string><string>--update</string></array>
  <key>EnvironmentVariables</key>
  <dict>
    <key>MUSIC_MACHINE</key><string>$MUSIC_MACHINE</string>
    <key>MUSIC_LIBRARY</key><string>$MUSIC_LIBRARY</string>
    <key>PATH</key><string>${bun:h}:/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin</string>
  </dict>
  <key>StartInterval</key><integer>600</integer>
  <key>RunAtLoad</key><true/>
  <key>LowPriorityIO</key><true/>
  <key>Nice</key><integer>10</integer>
  <key>StandardOutPath</key><string>$HOME/Library/Logs/music-publish.log</string>
  <key>StandardErrorPath</key><string>$HOME/Library/Logs/music-publish.log</string>
</dict>
</plist>
EOF
launchctl bootout $domain/$label 2>/dev/null || true
launchctl bootstrap $domain $plist
echo "installed $label: publishes $MUSIC_LIBRARY as $MUSIC_MACHINE every 10 minutes from $repo"
