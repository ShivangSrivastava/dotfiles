#!/bin/bash

# Directory containing wallpapers
WALL_DIR="$HOME/walls"
STATE_FILE="$HOME/.cache/current_wall_index"
WALL_LIST_FILE="$HOME/.cache/wall_list"

# Generate wallpaper list if not cached
if [ ! -f "$WALL_LIST_FILE" ]; then
    find "$WALL_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" \) | sort > "$WALL_LIST_FILE"
fi

# Read all wallpapers into an array
mapfile -t WALLS < "$WALL_LIST_FILE"
TOTAL=${#WALLS[@]}

# Exit if no wallpapers found
if [ "$TOTAL" -eq 0 ]; then
    notify-send "❌ No wallpapers found in $WALL_DIR"
    exit 1
fi

# Read current index (default to 0)
if [ -f "$STATE_FILE" ]; then
    INDEX=$(<"$STATE_FILE")
else
    INDEX=0
fi

# Ensure index is within range
if [ "$INDEX" -ge "$TOTAL" ]; then
    INDEX=0
fi

# Pick wallpaper and increment index
WALL="${WALLS[$INDEX]}"
echo $(( (INDEX + 1) % TOTAL )) > "$STATE_FILE"

# Notify
notify-send "🎨 Using wallpaper: $WALL"

# Set wallpaper via hyprpaper
cat > ~/.config/hypr/hyprpaper.conf <<EOF
preload = $WALL
wallpaper = ,$WALL
EOF

# Restart hyprpaper
pkill hyprpaper
nohup hyprpaper >/dev/null 2>&1 &

# # Generate theme with pywal
# wal -i "$WALL"
# pywalfox update

notify-send "✅ Theme applied successfully."
