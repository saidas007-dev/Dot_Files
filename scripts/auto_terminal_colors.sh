#!/bin/bash

# Auto-background
[[ "$1" != "--bg" ]] && {
    nohup bash "$0" --bg >/dev/null 2>&1 &
    exit 0
}

schemes=(
    "#00ff00:#001a00"
    "#00ffff:#001a1a"
    "#ffcc00:#1a1a00"
    "#ff66b2:#330019"
    "#89b4fa:#1e1e2e"
    "#ff4d4d:#330000"
    "#a6e3a1:#002b00"
    "#f9e2af:#332200"
    "#94e2d5:#002b2b"
    "#f5c2e7:#2b002b"
)

export DISPLAY=:0
export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$(id -u)/bus"

profile_id=$(gsettings get org.gnome.Terminal.ProfilesList default | tr -d "'")
profile_path="org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:${profile_id}/"

log_file="$HOME/.color_cycle.log"
trap "echo 'Stopping color cycle.' >> $log_file; exit 0" SIGINT SIGTERM

while true; do
    choice=${schemes[$RANDOM % ${#schemes[@]}]}
    IFS=':' read -r fg bg <<< "$choice"

    gsettings set "$profile_path" use-theme-colors false
    gsettings set "$profile_path" foreground-color "$fg"
    gsettings set "$profile_path" background-color "$bg"

    echo "$(date): Changed to FG: $fg, BG: $bg" >> "$log_file"
    sleep 15
done

