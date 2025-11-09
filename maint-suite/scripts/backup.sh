#!/usr/bin/env bash
set -euo pipefail
SRC="${1:-$HOME}"
DEST_DIR="${2:-$(pwd)/backups}"
mkdir -p "$DEST_DIR"
STAMP="$(date +'%Y-%m-%d_%H-%M-%S')"
ARCHIVE="$DEST_DIR/backup_$STAMP.tar.gz"
tar --exclude="$HOME/.cache" --exclude="*/node_modules" -czf "$ARCHIVE" "$SRC"
echo "Backup created: $ARCHIVE"
