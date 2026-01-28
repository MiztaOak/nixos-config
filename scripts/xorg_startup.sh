#!/bin/sh
 
xrandr --output DP-3 --primary --mode 1920x1080 --rate 144 --right-of HDMI-1 --output HDMI-1 --mode 1920x1080 --rate 75 &
xset s off -dpms
