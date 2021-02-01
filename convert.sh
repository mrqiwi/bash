#!/bin/bash

function notify() {
MSG=$1
echo "$(($MSG / 60)) minutes and $(($MSG % 60)) seconds elapsed."
export DISPLAY=:0
notify-send "Files are converted" "$(($MSG / 60)) minutes and $(($MSG % 60)) seconds elapsed."
}

function convert() {
for FNAME in *
do
    if [[ -x "$FNAME" ]]; then
        continue
    fi

    if [ ! file "$FNAME" | grep video ]; then
        continue
    fi

    NEWFNAME="${FNAME::-3}mp4"
    ffmpeg -i "$FNAME" -c:v h264_nvenc "$NEWFNAME"

done
}

START=$(date +%s)

convert
mkdir mp4 && mv *.mp4 ./mp4

END=$(date +%s)

notify $(( $END - $START ))
