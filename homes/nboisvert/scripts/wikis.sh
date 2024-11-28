#!/usr/bin/env bash

op=$( echo -e "Nixpkgs\nHome-Manager\nHyprland\nWaybar\n" | wofi -i --dmenu | awk '{print tolower($1)}' )

echo $op
case $op in 
        nixpkgs)
          xdg-open "https://search.nixos.org/packages"
          ;;
        home-manager)
          xdg-open "https://nix-community.github.io/home-manager/"
          ;;
        hyprland)
          xdg-open "https://wiki.hyprland.org/"
          ;;
        waybar)
          xdg-open "https://github.com/Alexays/Waybar/wiki"
          ;;
esac
