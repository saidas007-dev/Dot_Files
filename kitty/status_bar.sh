#!/usr/bin/env bash

#===========================#
# Kitty Dynamic Status Bar  #
#===========================#

update_interval=2  # seconds

get_git_branch() {
    branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
    if [ -n "$branch" ]; then
        echo " $branch"
    else
        echo ""
    fi
}

get_cpu() {
    usage=$(grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {print int(usage) "%"}')
    echo "CPU:$usage"
}

get_ram() {
    read -r total used free <<<$(free -m | awk 'NR==2{printf "%d %d %d\n",$2,$3,$4}')
    echo "RAM:$used/$total MB"
}

get_battery() {
    if [ -f /sys/class/power_supply/BAT0/capacity ]; then
        cap=$(cat /sys/class/power_supply/BAT0/capacity)
        status=$(cat /sys/class/power_supply/BAT0/status)
        echo "⚡$cap% $status"
    else
        echo ""
    fi
}

get_time() {
    date "+%H:%M:%S"
}

while true; do
    STATUS="  $(get_git_branch)  |  $(get_cpu)  |  $(get_ram)  |  $(get_battery)  |  $(get_time)  "
    
    # Use correct socket
    kitty @ --to unix:/tmp/kitty.sock set-tab-title "$STATUS"

    sleep $update_interval
done

