#!/usr/bin/env bash
# Toggles a systemd sleep inhibitor and reports its state as Waybar JSON.
#
# Usage:
#   sleep-inhibitor.sh status  Print Waybar JSON describing the inhibitor state
#   sleep-inhibitor.sh toggle  Start or stop the inhibitor, then refresh Waybar

set -euo pipefail

readonly unit_name="sleep-inhibitor"
readonly waybar_signal=8
readonly inhibit_reason="Prevent sleep temporarily (Waybar)"

is_active() {
  systemctl --user --quiet is-active "$unit_name"
}

print_status() {
  if is_active; then
    printf '{"alt":"active","class":"active","tooltip":"Sleep is inhibited"}\n'
  else
    printf '{"alt":"inactive","class":"inactive","tooltip":"Sleep is allowed"}\n'
  fi
}

toggle() {
  if is_active; then
    systemctl --user stop "$unit_name"
  else
    systemd-run --user --quiet --unit="$unit_name" \
      systemd-inhibit --what=sleep --who=waybar --why="$inhibit_reason" \
      sleep infinity
  fi
  pkill -RTMIN+"$waybar_signal" waybar || true
}

case "${1:-status}" in
  status) print_status ;;
  toggle) toggle ;;
  *)
    echo "Usage: $0 {status|toggle}" >&2
    exit 1
    ;;
esac
