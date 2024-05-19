#!/usr/bin/env zsh


STATE="$(echo "$INFO" | jq -r '.state')"
if [ "$STATE" = "playing" ]; then
  TRACK="$(echo "$INFO" | jq -r .title)"
  ARTIST="$(echo "$INFO" | jq -r .artist)"

        # Calculations so it fits nicely
        TRACK_LENGTH=${#TRACK}
        ARTIST_LENGTH=${#ARTIST}
	MAX_LENGTH=40
	HALF_LENGTH=$(((MAX_LENGTH) / 2))

        if [ $((TRACK_LENGTH + ARTIST_LENGTH)) -gt $MAX_LENGTH ]; then
            # If the total length exceeds the max
            if [ $TRACK_LENGTH -gt $HALF_LENGTH ] && [ $ARTIST_LENGTH -gt $HALF_LENGTH ]; then
                # If both the track and artist are too long, cut both at half length - 1

                # If MAX_LENGTH is odd, HALF_LENGTH is calculated with an extra space, so give it an extra char
                TRACK="${TRACK:0:$((MAX_LENGTH % 2 == 0 ? HALF_LENGTH - 2 : HALF_LENGTH - 1))}…"
                ARTIST="${ARTIST:0:$((HALF_LENGTH - 2))}…"

            elif [ $TRACK_LENGTH -gt $HALF_LENGTH ]; then
                # Else if only the track is too long, cut it by the difference of the max length and artist length
                TRACK="${TRACK:0:$((MAX_LENGTH - ARTIST_LENGTH - 1))}..."
            elif [ $ARTIST_LENGTH -gt $HALF_LENGTH ]; then
                ARTIST="${ARTIST:0:$((MAX_LENGTH - TRACK_LENGTH - 1))}..."
            fi
        fi

	if [ "$ARTIST" = "" ]; then SEP="" else SEP="" fi
        sketchybar --set $NAME label="${TRACK} ${SEP} ${ARTIST}" drawing=on

else
  sketchybar --set $NAME drawing=off
fi
