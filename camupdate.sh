#!/bin/bash
set -e

SRC="$HOME/storage/shared/Jonnelcamera/"
PUBLISH="$HOME/Camera-Ai-Filter/Jonnelcamera/"

mkdir -p "$PUBLISH"

# sync ACODE → repo
rsync -av --update "$SRC" "$PUBLISH"

cd "$HOME/Camera-Ai-Filter"

# stage files
git add Jonnelcamera/*

# commit only if there are changes
if git diff --staged --quiet; then
  echo "✅ No changes to commit."
  exit 0
fi

git commit -m "Auto update from ACODE: $(date '+%Y-%m-%d %H:%M:%S')"
git push origin main
echo "✅ Camupdate finished and pushed!"
