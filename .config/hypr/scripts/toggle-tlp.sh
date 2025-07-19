#!/bin/bash

# toggle-tlp.sh - Toggle TLP service in Void Linux
# Usage: ./toggle-tlp.sh [start|stop|status]

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to display notifications (requires libnotify)
notify() {
    local message="$1"
    local urgency="$2"
    if command -v notify-send &> /dev/null; then
        notify-send -u "$urgency" "TLP Toggle" "$message"
    fi
    echo -e "${BLUE}[TLP]${NC} $message"
}

# Function to check TLP status
check_tlp_status() {
    # Check if TLP service exists
    if [ ! -d "/etc/sv/tlp" ]; then
        return 2  # TLP service not found
    fi
    
    # Check if TLP is running
    if sv status tlp 2>/dev/null | grep -q "run"; then
        return 0  # TLP is running
    else
        return 1  # TLP is not running
    fi
}

# Function to start TLP
start_tlp() {
    echo -e "${YELLOW}Starting TLP service...${NC}"
    
    # Enable and start TLP service
    if doas sv up tlp; then
        # Apply TLP settings
        doas tlp start
        notify "TLP started successfully" "normal"
        echo -e "${GREEN}✓ TLP service started and configured${NC}"
        echo -e "${BLUE}Power mode: BATTERY SAVING${NC}"
        
        # Show current power profile
        echo -e "${BLUE}Current TLP status:${NC}"
        tlp-stat -s 2>/dev/null | head -10 || echo "TLP statistics not available"
        
        return 0
    else
        notify "Failed to start TLP" "critical"
        echo -e "${RED}✗ Failed to start TLP service${NC}"
        return 1
    fi
}

# Function to stop TLP
stop_tlp() {
    echo -e "${YELLOW}Stopping TLP service...${NC}"
    
    # Stop TLP service
    if doas sv down tlp; then
        # Ensure TLP is completely stopped
        doas pkill -f tlp 2>/dev/null || true
        notify "TLP stopped successfully" "normal"
        echo -e "${GREEN}✓ TLP service stopped${NC}"
        echo -e "${BLUE}Power mode: PERFORMANCE${NC}"
        
        # Optionally set performance governor when TLP is disabled
        echo -e "${BLUE}Setting performance governor...${NC}"
        for cpu in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor; do
            if [ -w "$cpu" ]; then
                echo "performance" | doas tee "$cpu" > /dev/null 2>&1
            fi
        done
        
        echo -e "${BLUE}Current CPU governor:${NC}"
        cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor 2>/dev/null || echo "Governor info not available"
        
        return 0
    else
        notify "Failed to stop TLP" "critical"
        echo -e "${RED}✗ Failed to stop TLP service${NC}"
        return 1
    fi
}

# Function to show current status
show_status() {
    echo -e "${BLUE}=== TLP Status ===${NC}"
    
    check_tlp_status
    local status=$?
    
    case $status in
        0)
            echo -e "${GREEN}✓ TLP is running${NC}"
            echo -e "${BLUE}Current configuration:${NC}"
            tlp-stat -s 2>/dev/null || echo "TLP statistics not available"
            ;;
        1)
            echo -e "${RED}✗ TLP is stopped${NC}"
            echo -e "${BLUE}Current CPU governor:${NC}"
            cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor 2>/dev/null || echo "Governor info not available"
            ;;
        2)
            echo -e "${RED}✗ TLP service not found${NC}"
            echo "Please install TLP: sudo xbps-install -S tlp"
            ;;
    esac
}

# Function to toggle TLP
toggle_tlp() {
    check_tlp_status
    local status=$?
    
    case $status in
        0)
            echo -e "${YELLOW}TLP is currently running. Stopping...${NC}"
            stop_tlp
            ;;
        1)
            echo -e "${YELLOW}TLP is currently stopped. Starting...${NC}"
            start_tlp
            ;;
        2)
            echo -e "${RED}TLP service not found. Please install TLP first.${NC}"
            notify "TLP not installed" "critical"
            return 1
            ;;
    esac
}

# Main script logic
main() {
    # Check if running as root
    if [[ $EUID -eq 0 ]]; then
        echo -e "${RED}Don't run this script as root. It will use doas when needed.${NC}"
        exit 1
    fi
    
    # Check if TLP is installed
    if ! command -v tlp &> /dev/null; then
        echo -e "${RED}TLP binary not found. Install it with: doas xbps-install -S tlp${NC}"
        exit 1
    fi
    
    # Check if TLP service directory exists
    if [ ! -d "/etc/sv/tlp" ]; then
        echo -e "${RED}TLP service not found. Install TLP package: doas xbps-install -S tlp${NC}"
        echo -e "${YELLOW}Or enable the service: doas ln -s /etc/sv/tlp /var/service/${NC}"
        exit 1
    fi
    
    case "${1:-toggle}" in
        start)
            start_tlp
            ;;
        stop)
            stop_tlp
            ;;
        status)
            show_status
            ;;
        toggle)
            toggle_tlp
            ;;
        *)
            echo "Usage: $0 [start|stop|status|toggle]"
            echo "  start  - Start TLP service"
            echo "  stop   - Stop TLP service"
            echo "  status - Show current TLP status"
            echo "  toggle - Toggle TLP on/off (default)"
            exit 1
            ;;
    esac
}

# Run main function
main "$@"
