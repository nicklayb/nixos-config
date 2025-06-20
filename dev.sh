#!/bin/sh

#
# Debugging tool to test various application's configuration, for
# instance.
#
#   ./dev.sh waybar
#
# Will start a waybar instance with the current configuration
# state without need to rebuild the whole NixOS configuration.
#

WAYBAR=./modules/desktop_environment/waybar
THEME=rose.css

case $1 in
  waybar)
    waybar --config $WAYBAR/config.json --style $WAYBAR/$THEME
    ;;
  "")
    echo "Usage ./dev.sh [SOFTWARE]"
    ;;
  *)
    echo "Invalid debugging software"
    ;;
esac
