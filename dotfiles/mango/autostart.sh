#!/bin/bash
set +e 

swww-daemon &

mako &

dex -a &

waybar >/dev/null &

