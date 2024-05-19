# !/usr/bin/env sh


sketchybar --add item media center \
           --set media label.color=0xffffffff \
                       icon.padding_left=0 \
                       icon=󰎈            \
                       icon.color=0xffffffff   \
                       background.drawing=off \
                       script="$PLUGIN_DIR/media.sh" \
           --subscribe media media_change
