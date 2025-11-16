#!/bin/bash
swww-daemon > /dev/null 2>&1 &

mako > /dev/null 2>&1 &

waybar -c ~/.config/mango/waybar/config.jsonc -s ~/.config/mango/waybar/style.css >/dev/null 2>&1 &

