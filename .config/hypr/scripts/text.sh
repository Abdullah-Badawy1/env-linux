#!/bin/bash

# TLP Diagnostic Script for Void Linux
# This script checks TLP installation and service status

echo "=== TLP Diagnostic Report ==="
echo

# Check if TLP binary exists
echo "1. Checking TLP binary:"
if command -v tlp &> /dev/null; then
    echo "   ✓ TLP binary found at: $(which tlp)"
    tlp --version 2>/dev/null || echo "   ⚠ Could not get TLP version"
else
    echo "   ✗ TLP binary not found"
fi
echo

# Check TLP service directory
echo "2. Checking TLP service directory:"
if [ -d "/etc/sv/tlp" ]; then
    echo "   ✓ TLP service directory exists: /etc/sv/tlp"
    ls -la /etc/sv/tlp/
else
    echo "   ✗ TLP service directory not found: /etc/sv/tlp"
fi
echo

# Check if TLP service is enabled
echo "3. Checking TLP service status:"
if [ -L "/var/service/tlp" ]; then
    echo "   ✓ TLP service is enabled in /var/service/"
    ls -la /var/service/tlp
else
    echo "   ✗ TLP service is not enabled in /var/service/"
    echo "   → Run: doas ln -s /etc/sv/tlp /var/service/"
fi
echo

# Check service status
echo "4. Checking service status:"
if sv status tlp 2>/dev/null; then
    echo "   Service status above"
else
    echo "   ✗ Cannot get service status"
fi
echo

# Check TLP configuration
echo "5. Checking TLP configuration:"
if [ -f "/etc/tlp.conf" ]; then
    echo "   ✓ TLP configuration file exists"
else
    echo "   ⚠ TLP configuration file not found"
fi
echo

# Check if TLP is running
echo "6. Checking if TLP is active:"
if pgrep -f tlp > /dev/null; then
    echo "   ✓ TLP processes found:"
    pgrep -f tlp
else
    echo "   ✗ No TLP processes running"
fi
echo

# Check CPU governor
echo "7. Current CPU governor:"
if [ -r "/sys/devices/system/cpu/cpu0/cpufreq/scaling_governor" ]; then
    echo "   Current governor: $(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor)"
else
    echo "   ⚠ Cannot read CPU governor"
fi
echo

# Check doas configuration
echo "8. Checking doas configuration:"
if [ -f "/etc/doas.conf" ]; then
    echo "   ✓ doas.conf exists"
    if grep -q "tlp" /etc/doas.conf; then
        echo "   ✓ TLP-related rules found in doas.conf"
    else
        echo "   ⚠ No TLP-related rules in doas.conf"
    fi
else
    echo "   ✗ doas.conf not found"
fi
echo

# Suggested fixes
echo "=== Suggested Fixes ==="
echo

if [ ! -d "/etc/sv/tlp" ]; then
    echo "1. Install TLP package:"
    echo "   doas xbps-install -S tlp"
    echo
fi

if [ ! -L "/var/service/tlp" ]; then
    echo "2. Enable TLP service:"
    echo "   doas ln -s /etc/sv/tlp /var/service/"
    echo
fi

if [ ! -f "/etc/doas.conf" ] || ! grep -q "tlp" /etc/doas.conf 2>/dev/null; then
    echo "3. Configure doas permissions:"
    echo "   Add TLP rules to /etc/doas.conf"
    echo
fi

echo "4. Test TLP manually:"
echo "   doas sv up tlp"
echo "   doas tlp start"
echo "   sv status tlp"
echo

echo "=== End of Diagnostic ==="
