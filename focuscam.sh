#!/bin/bash

set -e

deviceNb=0

focus() {
    echo "Setting focus to $1"
    v4l2-ctl -d ${deviceNb} -c focus_absolute=$1
}

# turn off autofocus
v4l2-ctl -d ${deviceNb} -c focus_auto=0

if [ -n "$1" ]; then
    focus $1
    exit;
fi

FOCUS=0
while true; do
    focus $FOCUS
    echo "Focus level is $FOCUS; ctrl-c if you're happy"
    echo "Press enter to adjust focus by +5"
    read
    FOCUS=$[$FOCUS+5]
done
