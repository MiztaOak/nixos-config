#!/bin/bash
set +e 

awww-daemon &

mako &

dex -a &

waybar >/dev/null &

