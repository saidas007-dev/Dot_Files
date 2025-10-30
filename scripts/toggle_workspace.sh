#!/bin/bash

# -----------------------------
# Workspace Wallpaper Toggle Script for Pop!_OS
# -----------------------------

# Path to your wallpaper folder
wallpaper_dir="/home/kanashii/Pictures/Wallpapers/Workspace"

# Ensure wmctrl is installed
if ! command -v wmctrl &> /dev/null; then
    echo "wmctrl not found. Install it with: sudo apt install wmctrl"
    exit 1
fi

# Ensure gsettings is installed
if ! command -v gsettings &> /dev/null; then
    echo "gsettings not found."
    exit 1
fi

# Get current workspace index
current=$(wmctrl -d | awk '/\*/{print $1}')

# Get total number of workspaces
total=$(wmctrl -d | wc -l)

# Calculate next workspace (wrap around)
next=$(( (current + 1) % total ))

# Switch to the next workspace
wmctrl -s "$next"

# Small pause to ensure workspace switches completely
sleep 0.3

# Determine wallpaper path (expects 1.jpg, 2.jpg, ...)
wallpaper="$wallpaper_dir/$((next + 1)).jpg"

# Apply wallpaper if it exists
if [ -f "$wallpaper" ]; then
    # Ensure file URI format with triple slashes
    file_uri="file:///$wallpaper"

    # Set wallpaper for light and dark mode (GNOME / Pop!_OS)
    gsettings set org.gnome.desktop.background picture-uri "$file_uri"
    gsettings set org.gnome.desktop.background picture-uri-dark "$file_uri"
else
    echo "Wallpaper not found: $wallpaper"
fi

