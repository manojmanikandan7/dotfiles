#!/bin/bash
# ── bluetooth-toggle.sh ──────────────────────────────────────────────────────
# Toggle Bluetooth on/off using rfkill.
# Usage: Waybar `bluetooth` module :on-click
# Output: (changes state only)
# ───────────────────────────────────────────────────────────────────────────── 

if rfkill list wlan | grep -q "Soft blocked: yes"; then
    rfkill unblock wlan
else
    rfkill block wlan
fi

