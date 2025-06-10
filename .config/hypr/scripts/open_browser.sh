#!/bin/bash

LINK_FILE="$HOME/.config/hypr/scripts/my_links.csv"

current_ws=$(hyprctl activeworkspace -j | jq -r '.id')

if [ "$current_ws" -eq 2 ] && ! pgrep -f "vivaldi" > /dev/null; then
    url="about:home"
else
    website=$(cut -d, -f1 "$LINK_FILE" | fzf --layout reverse --border)
    url=$(rg "^$website," "$LINK_FILE" | cut -d, -f2-)
    [ -z "$url" ] && url="about:home"
fi

nohup vivaldi --new-tab "$url" >/dev/null 2>&1 &
hyprctl dispatch workspace 2
