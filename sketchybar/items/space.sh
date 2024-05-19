# !/usr/bin/env sh

SPACE_ICONS=("1" "2" "3" "4" "5" "6" "7" "8" "9" "10")
for i in "${!SPACE_ICONS[@]}"
do
  sid="$(($i+1))"
  space=(
    space="$sid"
    icon="${SPACE_ICONS[i]}"
    icon.padding_left=8
    icon.padding_right=8
    label.drawing=off
    script="$PLUGIN_DIR/space.sh"
  )
  sketchybar --add space space."$sid" left --set space."$sid" "${space[@]}"
done

sketchybar --add item  chevron left \
           --set chevron background.color=0x00000000 icon= label.drawing=off \
