#!/bin/bash
# Power menu script for Void Linux with elogind
# ~/.config/waybar/scripts/power-menu.sh

# Make script executable
# chmod +x ~/.config/waybar/scripts/power-menu.sh

# Define options
shutdown="󰐥 Shutdown"
reboot="󰜉 Restart"
suspend="󰤄 Suspend"
hibernate="󰤄 Hibernate"
lock="󰌾 Lock"
logout="󰍃 Logout"

# Create rofi/wofi menu
selected_option=$(echo -e "$shutdown\n$reboot\n$suspend\n$hibernate\n$lock\n$logout" | wofi --dmenu \
    --prompt "Power Menu" \
    --width 250 \
    --height 300 \
    --cache-file /dev/null \
    --hide-scroll \
    --no-actions \
    --matching=fuzzy \
    --insensitive \
    --style ~/.config/waybar/scripts/power-menu.css)

# Execute selected option
case $selected_option in
    "$shutdown")
        # For Void Linux with elogind
        if command -v loginctl &> /dev/null; then
            loginctl poweroff
        else
            # Fallback to sudo/doas
            if command -v doas &> /dev/null; then
                doas poweroff
            else
                sudo poweroff
            fi
        fi
        ;;
    "$reboot")
        # For Void Linux with elogind
        if command -v loginctl &> /dev/null; then
            loginctl reboot
        else
            # Fallback to sudo/doas
            if command -v doas &> /dev/null; then
                doas reboot
            else
                sudo reboot
            fi
        fi
        ;;
    "$suspend")
        # For Void Linux with elogind
        if command -v loginctl &> /dev/null; then
            loginctl suspend
        else
            # Fallback to systemctl
            systemctl suspend
        fi
        ;;
    "$hibernate")
        # For Void Linux with elogind
        if command -v loginctl &> /dev/null; then
            loginctl hibernate
        else
            # Fallback to systemctl
            systemctl hibernate
        fi
        ;;
    "$lock")
        # Lock screen with hyprlock or swaylock
        if command -v hyprlock &> /dev/null; then
            hyprlock
        elif command -v swaylock &> /dev/null; then
            swaylock -f
        else
            # Fallback to xscreensaver or i3lock
            if command -v i3lock &> /dev/null; then
                i3lock -c 000000
            fi
        fi
        ;;
    "$logout")
        # Logout from Hyprland
        hyprctl dispatch exit
        ;;
esac
