#!/usr/bin/env bash

op=$( echo -e "Nixpkgs\nHome-Manager\nHyprland\nWaybar\n" | wofi -i --dmenu | awk '{print tolower($1)}' )

echo $op
case $op in 
        nixpkgs)
          firefox -url "https://search.nixos.org/packages"
          ;;
        home-manager)
          firefox -url "https://nix-community.github.io/home-manager/"
          ;;
        hyprland)
          firefox -url "https://wiki.hyprland.org/"
          ;;
        waybar)
          firefox -url "https://github.com/Alexays/Waybar/wiki"
          ;;
esac
