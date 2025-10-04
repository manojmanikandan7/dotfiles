#!/bin/bash
# ── battery.sh ─────────────────────────────────────────────
# Description: Shows battery % with ASCII bar + dynamic tooltip
# Usage: Waybar `custom/battery` every 10s
# Dependencies: upower, awk, seq, printf
#  ──────────────────────────────────────────────────────────

capacity=$(cat /sys/class/power_supply/BAT0/capacity)
status=$(cat /sys/class/power_supply/BAT0/status)

# Get detailed info from upower
time_to_empty=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | awk -F: '/time to empty/ {print $2}' | xargs)
time_to_full=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | awk -F: '/time to full/ {print $2}' | xargs)

# Icons
charging_icons=(󰢜 󰂆 󰂇 󰂈 󰢝 󰂉 󰢞 󰂊 󰂋 󰂅)
default_icons=(󰁺 󰁻 󰁼 󰁽 󰁾 󰁿 󰂀 󰂁 󰂂 󰁹)

index=$((capacity / 10))
[ $index -ge 10 ] && index=9

if [[ "$status" == "Charging" ]]; then
  icon=${charging_icons[$index]}
elif [[ "$status" == "Full" ]]; then
  icon="󰂅"
else
  icon=${default_icons[$index]}
fi

# ASCII bar
filled=$((capacity / 10))
empty=$((10 - filled))
bar=$([ "$filled" -gt 0 ] && printf '%.0s' $(seq 1 $filled) || echo "")
pad=$([ "$empty" -gt 0 ] && printf '%.0s' $(seq 1 $empty) || echo "")
ascii_bar="|$bar$pad|"

# Color thresholds
if [ "$capacity" -lt 20 ]; then
  fg="#bf616a" # red
elif [ "$capacity" -lt 55 ]; then
  fg="#fab387" # orange
else
  fg="#56b6c2" # cyan
fi

monitor_data=$(hyprctl -j monitors all)

refresh_rate=$(echo "$monitor_data" | jq -r '.[] | select(.name=="eDP-1") | .refreshRate')
disabled=$(echo "$monitor_data" | jq -r '.[] | select(.name=="eDP-1") | .disabled')

refresh_rate_int=$(printf '%d' "$refresh_rate")

# Set monitor refresh rate based on battery status
if [[ ("$disabled" == "true") ]]; then
  break
elif [[ ("$status" == "Charging" || ("$status" == "Not charging" && "$capacity" -ge 75)) && "$refresh_rate_int" -ne 165 ]]; then
  hyprctl keyword monitor eDP-1,2560x1600@165,auto,1.25
elif [[ "$status" == "Discharging" && "$refresh_rate_int" -ne 60 ]]; then
  hyprctl keyword monitor eDP-1,2560x1600@60,auto,1.25
fi

# Create tooltip with battery info
if [[ "$status" == "Charging" && -n "$time_to_full" ]]; then
  tooltip="Battery: $capacity% (Charging, $time_to_full until full)"
elif [[ "$status" == "Discharging" && -n "$time_to_empty" ]]; then
  tooltip="Battery: $capacity% (Discharging, $time_to_empty remaining)"
else
  tooltip="Battery: $capacity% ($status)"
fi

# JSON output
echo "{\"text\":\"<span foreground='$fg'>$icon $ascii_bar $capacity%</span>\",\"tooltip\":\"$tooltip\"}"
