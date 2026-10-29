#!/bin/bash
# Build Bibelsanger.app into player/build/ (and install it in ~/Applications with --install).
set -euo pipefail
cd "$(dirname "$0")"
swift build -c release
app=build/Bibelsanger.app
rm -rf "$app"
mkdir -p "$app/Contents/MacOS" "$app/Contents/Resources" build/icon.iconset
cp .build/release/BibleSongs "$app/Contents/MacOS/Bibelsanger"

swift icon.swift build/icon-1024.png
for s in 16 32 128 256 512; do
  sips -z $s $s build/icon-1024.png --out build/icon.iconset/icon_${s}x${s}.png >/dev/null
  sips -z $((s * 2)) $((s * 2)) build/icon-1024.png --out build/icon.iconset/icon_${s}x${s}@2x.png >/dev/null
done
iconutil -c icns build/icon.iconset -o "$app/Contents/Resources/AppIcon.icns"

cat > "$app/Contents/Info.plist" <<PLIST
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0"><dict>
  <key>CFBundleName</key><string>Bibelsanger</string>
  <key>CFBundleDisplayName</key><string>Bibelsanger</string>
  <key>CFBundleIdentifier</key><string>com.flogvit.bibelsanger</string>
  <key>CFBundleExecutable</key><string>Bibelsanger</string>
  <key>CFBundleIconFile</key><string>AppIcon</string>
  <key>CFBundlePackageType</key><string>APPL</string>
  <key>CFBundleShortVersionString</key><string>1.0</string>
  <key>LSMinimumSystemVersion</key><string>14.0</string>
  <key>NSHighResolutionCapable</key><true/>
</dict></plist>
PLIST
codesign --force --sign - "$app"
if [ "${1:-}" = "--install" ]; then
  mkdir -p ~/Applications
  rm -rf ~/Applications/Bibelsanger.app
  cp -R "$app" ~/Applications/
  echo "installed ~/Applications/Bibelsanger.app"
else
  echo "built $app"
fi
