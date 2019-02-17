#!/bin/bash

deviceNb=0

v4l2-ctl -d ${deviceNb} -c focus_auto=0

FOCUS=${1:-10}
while true; do
    v4l2-ctl -d ${deviceNb} -c focus_absolute=$FOCUS
    echo "Focus level is $FOCUS; ctrl-c if you're happy"
    echo "Press enter to adjust focus"
    read
    FOCUS=$[$FOCUS+5]
done
