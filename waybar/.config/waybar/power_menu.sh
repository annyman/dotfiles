#!/usr/bin/env bash

# standard options mapped with icons
entries="󰌾 Lock\n󰒲 Suspend\n󰍃 Logout\n󰑓 Restart\n󰐥 Shutdown"

# -d enables dmenu mode
# -a top-right anchors it
# -x 10 -y 40 offsets it from the edges and below the bar (adjust y if your bar is thicker)
# -l 5 limits the height exactly to the 5 options
# -w 15 makes it a compact width
selected=$(echo -e "$entries" | fuzzel -d -a top-right -y 40 -x 10 -l 5 -w 15 -p "")

case $selected in
    *Lock)
        swaylock
        ;;
    *Suspend)
        systemctl suspend
        ;;
    *Logout)
        niri msg action quit --skip-confirmation && systemctl restart display-manager
        ;;
    *Restart)
        systemctl reboot
        ;;
    *Shutdown)
        systemctl poweroff
        ;;
esac
