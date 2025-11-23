#!/bin/bash
set +e 

swww-daemon &

mako &

waybar -c ~/.config/mango/waybar/config.jsonc -s ~/.config/mango/waybar/style.css >/dev/null &

