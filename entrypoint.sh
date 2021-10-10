#!/bin/sh

/usr/bin/Xvfb :1 -screen 0 1280x720x24 &
export DISPLAY=:1

dosbox -conf dosbox.conf games/hugomaze/Hugo.exe &
sleep 5

# move dosbox to 0,0
WINDOW=$( xdotool search -class dosbox )
xdotool windowmove $WINDOW 160 0

ffmpeg \
  -draw_mouse 0 \
  -f x11grab \
  -framerate 60 \
  -video_size 1280x720 \
  -i :1.0 \
  -crf 0  \
  -video_size 1280x720 \
  -c:v libx264 \
  -preset veryfast \
  -b:v 5000k \
  -maxrate 5000k \
  -bufsize 512k \
  -pix_fmt yuv420p \
  -g 10 \
  -f pulse \
  -c:a aac \
  -b:a 160k \
  -ac 2 \
  -ar 44100 \
  -f flv \
  -an \
  -tune zerolatency \
  rtmp://fra02.contribute.live-video.net/app/live_$TOKEN

