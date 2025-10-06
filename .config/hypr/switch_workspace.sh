#!/bin/bash

#Stolen with much love from https://cascade.moe/en/posts/hyprland-with-multi-monitors/

operation=$1
workspace=$2

monitor_id=$(hyprctl activeworkspace -j | jq -r ".monitorID")
workspace_id=$(($monitor_id * 5 + $workspace))
echo "Final Operation: $operation to $workspace_id"

if [[ $operation == "switch" ]]; then
	hyprctl dispatch moveworkspacetomonitor $workspace_id $monitor_id;
	hyprctl dispatch workspace $workspace_id;
fi
if [[ $operation == "move" ]]; then
	hyprctl dispatch moveworkspacetomonitor $workspace_id $monitor_id;
	hyprctl dispatch movetoworkspace $workspace_id;
fi
