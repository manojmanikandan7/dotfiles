#!/bin/bash
# ── brightness-toggle.sh ─────────────────────────────
# Description: Cycle screen brightness between 30%, 60%, and 100%
# Usage: Waybar `custom/brightness` on-click
# Dependencies: brightnessctl
# ─────────────────────────────────────────────────────

current=$(brightnessctl get)
max=$(brightnessctl max)
percent=$((current * 100 / max))

if [ "$percent" -lt 20 ]; then
  brightnessctl set 40%
elif [ "$percent" -lt 40 ]; then
  brightnessctl set 60%
elif [ "$percent" -lt 60 ]; then
  brightnessctl set 80%
elif [ "$percent" -lt 80 ]; then
  brightnessctl set 100%
else
  brightnessctl set 10%
fi

