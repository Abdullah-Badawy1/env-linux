#!/bin/bash
# ~/.config/hypr/scripts/power.sh
# Handle power key actions: single press for suspend, long press for poweroff

# Check if the script is called with a long-press argument
if [ "$1" == "long" ]; then
    doas poweroff
else
    # Single press: lock and suspend
    pidof swaylock || swaylock -f -c 000000 &
    sleep 1
    loginctl suspend
fi
