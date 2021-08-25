#!/bin/bash

USER="$(who | grep :0\) | cut -f 1 -d ' ')"
export XAUTHORITY=/home/$USER/.Xauthority
export DISPLAY=:0
export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$(id -u $USER)/bus

########### Settings ###########

# Use 'xrandr' to find these
INTERNAL_DISPLAY="eDP1"

xrandr --current > /tmp/log.txt

# if there is an external screen connected then set it to its max resolution
CURRENT_DISPLAY=$(xrandr --listactivemonitors  | grep -v eDP1 | sed -n '2p' | awk '{print $NF}')
RES=$(xrandr --current | grep -A1 DP3-1 | tail -n 1 | awk '{print $1}')
xrandr --output $CURRENT_DISPLAY --mode $RES >> /tmp/log.txt

# it works but the problem is that lightdm reverts the display to the laptop so it's kind of ugly and we need to set it back to the external screen only manually. It's better to use i3-lock
