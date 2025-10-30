#!/usr/bin/env bash
# Simple bottom status bar for Kitty (refreshes every 2 s)

INTERVAL=2

while true; do
    # Gather stats
    dir=$(basename "$PWD")
    cpu=$(grep 'cpu ' /proc/stat | awk '{u=($2+$4)*100/($2+$4+$5)} END{printf "%.1f%%",u}')
    ram=$(free -m | awk '/Mem:/ {printf "%.1f%%", $3/$2*100}')
    gpu=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits 2>/dev/null | head -n1)
    [[ -z "$gpu" ]] && gpu="N/A"
    size=$(du -sh . 2>/dev/null | awk '{print $1}')
    date=$(date '+%Y-%m-%d %H:%M:%S')

    # Assemble colored line (Catppuccin-like)
    line="\033[38;2;205;214;244m $dir | 💻 CPU $cpu | 🧠 RAM $ram | 🎮 GPU $gpu | 📁 $size | 🕒 $date\033[0m"

    # Move cursor to bottom line, clear it, print line, then return
    printf "\0337\033[999;1H\033[2K%s\0338" "$line"

    sleep "$INTERVAL"
done
