#!/bin/sh

if [ "$(acpi -a)" == "Adapter 0: on-line" ]
then
hyprctl keyword monitor "eDP-1, disable"
fi
