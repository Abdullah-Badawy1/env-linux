
#!/bin/bash
# ~/.config/hypr/scripts/sleep.sh
pidof swaylock || swaylock -f -c 000000 &
sleep 1
loginctl suspend
