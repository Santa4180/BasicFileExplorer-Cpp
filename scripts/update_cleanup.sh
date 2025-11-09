#!/usr/bin/env bash
set -euo pipefail
LOG_DIR="$(pwd)/logs"
mkdir -p "$LOG_DIR"
LOG_FILE="$LOG_DIR/update_$(date +'%Y-%m-%d_%H-%M-%S').log"
run() { echo "+ $*" | tee -a "$LOG_FILE"; "$@" |& tee -a "$LOG_FILE"; }
if command -v apt >/dev/null 2>&1; then
  PKG="apt"
  run sudo apt update
  run sudo apt -y upgrade
  run sudo apt -y autoremove
  run sudo apt -y autoclean
elif command -v dnf >/dev/null 2>&1; then
  PKG="dnf"
  run sudo dnf -y upgrade --refresh
  run sudo dnf -y autoremove
else
  echo "Unsupported package manager" | tee -a "$LOG_FILE"
  exit 1
fi
echo "Updates complete via $PKG. Log: $LOG_FILE"
