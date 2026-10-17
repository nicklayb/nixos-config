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
# There's also aliases to speed up rebuilding; `test` and `switch`.
#

WAYBAR=./modules/desktop_environment/waybar
WOFI=./modules/desktop_environment/wofi

THEME=rose.css

case "$(uname -s)" in
  Darwin)
    OS=darwin
    REBUILD=darwin-rebuild
    ;;
  Linux)
    OS=linux
    REBUILD=nixos-rebuild
    ;;
  *)
    echo "Unsupported operating system: $(uname -s)" >&2
    exit 1
    ;;
esac

case $1 in
  repl)
    nix repl --file repl.nix
    ;;
  waybar)
    waybar --config $WAYBAR/config.json --style $WAYBAR/$THEME -l debug
    ;;
  wofi)
    wofi --show drun -s $WOFI/style.css -c $WOFI/config
    ;;
  switch)
    sudo "$REBUILD" switch --flake ./
    ;;
  test)
    sudo "$REBUILD" test --flake ./
    ;;
  install-ca)
    if [ "$OS" = "darwin" ]; then
      sudo security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain ./certs/nboisvert-local.pem
    elif [ "$OS" = "linux" ]; then
      echo "CAs are installed by default on Linux."
      exit 2
    fi
    ;;
  "")
    echo "Usage ./dev.sh [SOFTWARE]"
    ;;
  *)
    echo "Invalid debugging software"
    ;;
esac
