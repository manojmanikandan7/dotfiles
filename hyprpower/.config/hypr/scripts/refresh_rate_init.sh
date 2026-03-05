#!/usr/bin/env sh

MON="eDP-1"
RES="2560x1600"

if [ "$(cat /sys/class/power_supply/ADP0/online)" = "1" ]; then
  hyprctl monitor $MON,$RES@165,auto,1.25
else
  hyprctl monitor $MON,$RES@60,auto,1.25
fi
