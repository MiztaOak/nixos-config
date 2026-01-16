#!/bin/bash
i3-msg -t subscribe -m '["workspace", "output"]' | {
  i3-msg -t get_workspaces;
  while read EVENT; do i3-msg -t get_workspaces; done;
} | jq --unbuffered -c '[ .[] | .name |= split(":")[1] ]' 
  | jq --unbuffered -c 'sort_by(.name) | reverse'
