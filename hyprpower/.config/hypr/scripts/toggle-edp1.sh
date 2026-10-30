#!/bin/sh
# Toggle the internal panel (eDP-1) on/off.
# When enabling, use 165 Hz by default.
#
# The Lua monitor object does not expose a "disabled" flag, so ask
# hyprctl for the real state (it includes disabled outputs with `all`).

MON="eDP-1"
RES="2560x1600"
RATE="165"
SCALE="1.25"

if hyprctl monitors all -j 2>/dev/null |
  jq -e --arg m "$MON" '.[] | select(.name == $m and .disabled == false)' >/dev/null; then
  # Currently enabled -> disable it.
  hyprctl eval "hl.monitor({ output = \"$MON\", disabled = true })" >/dev/null
else
  # Currently disabled (or missing) -> enable it.
  hyprctl eval "hl.monitor({ output = \"$MON\", mode = \"${RES}@${RATE}\", position = \"auto\", scale = ${SCALE}, disabled = false })" >/dev/null
fi
