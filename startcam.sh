#!/bin/bash

port=8099
host=$(/bin/hostname)

# change this value to adapt to your webcam device number
deviceNb=0

# force video format
v4l2-ctl -d${deviceNb} --set-fmt-video=width=1920,height=1080,pixelformat=1

echo "Try opening one of these network streams in VLC"
for H in ${host} ${host}.local; do
    echo "http://${H}:$port"
done

AUDIO=$1
if [ -n "$AUDIO" ]; then
    echo "Starting stream with audio"
    cvlc v4l2:///dev/video${deviceNb}:chroma=h264 :input-slave=alsa://hw:1,0 --sout '#transcode{acodec=mpga,ab=128,channels=2,samplerate=44100,threads=4,audio-sync=1}:standard{access=http,mux=ts,mime=video/ts,dst=:'${port}'}' --quiet </dev/null >/dev/null
else
    echo "Starting silent stream"
    cvlc v4l2:///dev/video${deviceNb}:chroma=h264 --sout '#:standard{access=http,mux=ts,mime=video/ts,dst=:'${port}'}' --quiet </dev/null >/dev/null
fi
