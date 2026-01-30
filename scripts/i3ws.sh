#!/bin/bash

operation=$1
workspace=$2
output=$(i3-msg -t get_workspaces | jq -r ".[] | select(.focused == true).output")

if [[ $output == "DP-3" ]]; then
  n=1
fi
if [[ $output == "HDMI-1" ]]; then
  n=2
fi

if [[ $operation == "switch" ]]; then
  i3-msg workspace "$n:$workspace"
fi
if [[ $operation == "move" ]]; then
  i3-msg move container to workspace "$n:$workspace"
fi
