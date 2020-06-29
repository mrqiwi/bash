#!/bin/bash

NOW="$(date +"%T")"

for FNAME in $(ls)
do
    if [[ -x "$FNAME" ]]; then
        continue
    fi

    NEWFNAME="${FNAME::-3}mp4"

    ffmpeg -i "$FNAME" "$NEWFNAME"
    echo "$NEWFNAME"

done

echo "start: $NOW"
echo "end: $(date +"%T")"
