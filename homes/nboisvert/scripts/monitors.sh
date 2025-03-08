#!/bin/sh

PRIMARY_MONITOR="eDP-1"
PRIMARY_WIDTH="1920"
PRIMARY_HEIGHT="1080"
SECONDARY_MONITOR="HDMI-A-2"
SECONDARY_WIDTH=$(xrandr | awk "/${SECONDARY_MONITOR}/ {print \$3}" | cut -d 'x' -f 1)
SECONDARY_HEIGHT=$(xrandr | awk "/${SECONDARY_MONITOR}/ {print \$3}" | cut -d 'x' -f 2)
SCALING_FACTOR="1.0"

if [ -n "${SECONDARY_MONITOR}" ]; then
  WOFI_OPTIONS="Reset\nMirror\nSecondary\nLeft\nRight\nTop\nBottom"
else
  echo "No option is selected!"
  exit 1
fi

ANSWER=$(echo -e "${WOFI_OPTIONS}" | wofi --dmenu -p "How do you want to project?" |
tr '[:upper:]' '[:lower:]')
[ -z "${ANSWER}" ] && {
  echo "No option is selected!"
  exit 1
}

case ${ANSWER} in
  reset)
    killall .waybar-wrapped
    hyprctl reload
    hyprctl dispatch exec waybar
    ;;
  mirror)
    killall .waybar-wrapped
    hyprctl keyword monitor ${PRIMARY_MONITOR},preferred,auto,1
    hyprctl keyword monitor ${SECONDARY_MONITOR},preferred,auto,1,mirror,${PRIMARY_MONITOR}
    hyprctl dispatch exec waybar
    ;;
  secondary)
    killall .waybar-wrapped
    hyprctl keyword monitor ${PRIMARY_MONITOR},disable
    hyprctl keyword monitor ${SECONDARY_MONITOR},preferred,auto,${SCALING_FACTOR}
    hyprctl dispatch exec waybar
    ;;
  left)
    killall .waybar-wrapped
    hyprctl keyword monitor ${SECONDARY_MONITOR},preferred,0x0,${SCALING_FACTOR}
    hyprctl keyword monitor ${PRIMARY_MONITOR},preferred,${SECONDARY_WIDTH}x0,1
    hyprctl dispatch exec waybar
    ;;
  right)
    killall .waybar-wrapped
    hyprctl keyword monitor ${PRIMARY_MONITOR},preferred,0x0,1
    hyprctl keyword monitor ${SECONDARY_MONITOR},preferred,${PRIMARY_WIDTH}x0,${SCALING_FACTOR}
    hyprctl dispatch exec waybar
    ;;
  top)
    killall .waybar-wrapped
    hyprctl keyword monitor ${PRIMARY_MONITOR},preferred,0x${SECONDARY_HEIGHT},1
    hyprctl keyword monitor ${SECONDARY_MONITOR},preferred,0x0, ${SCALING_FACTOR}
    hyprctl dispatch exec waybar
    ;;
  bottom)
    hyprctl keyword monitor ${PRIMARY_MONITOR},preferred,0x0,1
    hyprctl keyword monitor ${SECONDARY_MONITOR},preferred,0x${PRIMARY_HEIGHT},${SCALING_FACTOR}
    hyprctl dispatch exec waybar
    ;;
  *)
    echo "No option is selected!"
    exit 1
    ;;
esac
