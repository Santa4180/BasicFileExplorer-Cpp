#!/usr/bin/env bash
set -Eeuo pipefail
banner() { echo -e "\n========== $* ==========\n"; }
while true; do
  clear
  echo "System Maintenance Suite"
  echo "1) Run Backup"
  echo "2) Update & Cleanup"
  echo "3) Scan Logs for Issues"
  echo "4) Configure Cron Schedules"
  echo "5) View Logs Directory"
  echo "6) Exit"
  read -rp "Choose an option: " opt
  case "$opt" in
    1) banner "Backup"; ./scripts/backup.sh; read -rp "Press Enter...";;
    2) banner "Update & Cleanup"; ./scripts/update_cleanup.sh; read -rp "Press Enter...";;
    3) banner "Log Monitor"; ./scripts/log_monitor.sh; read -rp "Press Enter...";;
    4) banner "Cron Setup";
       echo "Example: 0 2 * * * $(pwd)/scripts/backup.sh";
       echo "Open crontab editor now? (y/n)"; read yn; [ "$yn" = "y" ] && crontab -e;;
    5) banner "Logs"; ls -lah logs; read -rp "Press Enter...";;
    6) exit 0;;
    *) echo "Invalid"; sleep 1;;
  esac
done
