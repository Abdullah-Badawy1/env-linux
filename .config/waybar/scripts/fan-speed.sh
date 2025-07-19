#!/bin/bash

# Fan Speed Detection Script for Waybar
# This script tries multiple methods to detect fan speed

get_fan_speed() {
    # Method 1: Check /sys/class/hwmon for fan inputs
    for hwmon in /sys/class/hwmon/hwmon*/; do
        if [[ -d "$hwmon" ]]; then
            # Look for fan1_input, fan2_input, etc.
            for fan_file in "$hwmon"fan*_input; do
                if [[ -r "$fan_file" ]]; then
                    fan_speed=$(cat "$fan_file" 2>/dev/null)
                    if [[ "$fan_speed" -gt 0 ]]; then
                        echo "$fan_speed"
                        return 0
                    fi
                fi
            done
        fi
    done
    
    # Method 2: Try sensors command if available
    if command -v sensors &> /dev/null; then
        fan_speed=$(sensors 2>/dev/null | grep -i "fan" | head -1 | grep -o '[0-9]\+' | head -1)
        if [[ -n "$fan_speed" && "$fan_speed" -gt 0 ]]; then
            echo "$fan_speed"
            return 0
        fi
    fi
    
    # Method 3: Check specific ASUS laptop paths
    if [[ -r "/sys/devices/platform/asus-nb-wmi/hwmon/hwmon*/fan1_input" ]]; then
        fan_speed=$(cat /sys/devices/platform/asus-nb-wmi/hwmon/hwmon*/fan1_input 2>/dev/null)
        if [[ "$fan_speed" -gt 0 ]]; then
            echo "$fan_speed"
            return 0
        fi
    fi
    
    # Method 4: Check Dell laptop paths
    if [[ -r "/sys/devices/platform/dell-laptop/hwmon/hwmon*/fan1_input" ]]; then
        fan_speed=$(cat /sys/devices/platform/dell-laptop/hwmon/hwmon*/fan1_input 2>/dev/null)
        if [[ "$fan_speed" -gt 0 ]]; then
            echo "$fan_speed"
            return 0
        fi
    fi
    
    # Method 5: Check thermal zone cooling devices
    for cooling in /sys/class/thermal/cooling_device*/; do
        if [[ -r "$cooling/cur_state" ]]; then
            cur_state=$(cat "$cooling/cur_state" 2>/dev/null)
            if [[ "$cur_state" -gt 0 ]]; then
                # Convert cooling state to approximate RPM (this is rough estimation)
                fan_speed=$((cur_state * 500))
                if [[ "$fan_speed" -gt 0 ]]; then
                    echo "$fan_speed"
                    return 0
                fi
            fi
        fi
    done
    
    # Method 6: Try lm-sensors specific commands
    if command -v sensors &> /dev/null; then
        # Try to get fan speed from different sensor chips
        fan_speed=$(sensors 2>/dev/null | grep -i "cpu fan\|system fan\|chassis fan" | grep -o '[0-9]\+' | head -1)
        if [[ -n "$fan_speed" && "$fan_speed" -gt 0 ]]; then
            echo "$fan_speed"
            return 0
        fi
    fi
    
    # If no fan speed detected, return 0
    echo "0"
}

# Get fan speed
fan_speed=$(get_fan_speed)

# Format output
if [[ "$fan_speed" -eq 0 ]]; then
    echo "N/A"
else
    echo "${fan_speed}"
fi
