#!/bin/bash
# Save as ~/.config/hypr/scripts/toggle_copyq.sh

# Check if CopyQ is running
if pgrep -x "copyq" > /dev/null; then
    # Check if CopyQ window is visible
    if hyprctl clients | grep -q "CopyQ"; then
        copyq hide
    else
        copyq show
    fi
else
    # Start CopyQ and show it
    copyq &
    sleep 0.5  # Give it time to start
    copyq show
fi
