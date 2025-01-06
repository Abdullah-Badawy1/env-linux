#!/bin/sh
#
# ~/.xinitrc - minimal example for dwm with keyboard settings, D-Bus, and optional PipeWire

###############################################################################
# 1. Keyboard Layout
###############################################################################
# Combine US and Arabic (digits variant), toggle layout with Alt keys.
setxkbmap -layout us,ara -variant ,digits -option grp:alts_toggle

# Swap Caps Lock and Escape.
setxkbmap -option caps:swapescape

# Remap keycode 135 (Menu key) to Super_L if desired.
xmodmap -e "keycode 135 = Super_L"

###############################################################################
# 2. Java-Fix Environment Variables
###############################################################################
# Improve Java behavior on non-reparenting WMs like dwm.
#export AWT_TOOLKIT=MToolKit
#export _JAVA_AWT_WM_NONREPARENTING=1

# Some Java apps look for 'LG3D' to avoid rendering issues.
#wmname LG3D

###############################################################################
# 3. D-Bus Session
###############################################################################
# If your login/session manager doesn't automatically spawn a user session bus,
# you can launch one here. This ensures D-Bus is running for various services.
#if [ -z "$DBUS_SESSION_BUS_ADDRESS" ]; then
#    eval "$(dbus-launch --sh-syntax --exit-with-session)"
#fi
# Source system-level init scripts
#if [ -d /etc/X11/xinit/xinitrc.d ] ; then
#for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
#[ -x "$f" ] && . "$f"
#done
#unset f
#fi
###############################################################################
# 4. Hotkeys Daemon
###############################################################################
# Launch sxhkd for custom hotkeys (if desired).
sxhkd &

###############################################################################
# 5. (Optional) PipeWire + WirePlumber
###############################################################################
# If you want to run PipeWire for audio (and possibly video) on a minimal setup:
pipewire &
pipewire-pulse &
/usr/bin/pipewire &
/usr/bin/wireplumber &
wireplumber &

# Alternatively, if you do NOT use PipeWire, remove or comment out these lines.
# If you're using PulseAudio instead, just ensure your pulseaudio daemon is running.

###############################################################################
# 6. Finally, Start dwm
###############################################################################
exec dwm

