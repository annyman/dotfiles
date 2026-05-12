#!/usr/bin/env bash

# list the folder, strip the '.fish' extension, and pipe into fuzzel
# the -p flag adds a custom prompt to match the noisy boy vibe
selected=$(ls ~/Documents/scripts | sed 's/\.fish$//' | fuzzel -d -p "󰲋 : " -l 10 -w 30)

# if you actually selected something (didn't hit escape)
if [ -n "$selected" ]; then
    # if your scripts are background tasks (like toggling waybar, etc):
    # $selected &
    
    # OR, if your scripts need to show terminal output, comment out the line above 
    # and uncomment the line below to launch them inside ghostty:
    ghostty -e sudo "$selected" &
fi
