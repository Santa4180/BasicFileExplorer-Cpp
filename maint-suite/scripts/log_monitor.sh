#!/usr/bin/env bash
set -euo pipefail
LOG_SRC=""
if [ -f /var/log/syslog ]; then LOG_SRC="/var/log/syslog";
elif [ -f /var/log/messages ]; then LOG_SRC="/var/log/messages";
else echo "No system log found"; exit 1; fi
OUT_DIR="$(pwd)/logs"
mkdir -p "$OUT_DIR"
OUT_FILE="$OUT_DIR/alerts_$(date +'%Y-%m-%d').log"
PATTERN="${1:-'(error|failed|critical|panic)'}"
TAIL_LINES="${2:-500}"
echo "Scanning $LOG_SRC (last $TAIL_LINES lines) for: $PATTERN"
grep -Ei "$PATTERN" <(tail -n "$TAIL_LINES" "$LOG_SRC") | tee -a "$OUT_FILE" || true
echo "Results saved to: $OUT_FILE"
