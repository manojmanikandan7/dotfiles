# !/usr/bin/env sh

sketchybar --add item front_app left \
	   --set front_app icon.drawing=off label.color=0xffffffff background.color=0x00000000 script="$PLUGIN_DIR/front_app.sh" \
	   --subscribe front_app front_app_switched
