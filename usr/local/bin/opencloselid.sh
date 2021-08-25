#!/bin/bash

USER="$(who | grep :0\) | cut -f 1 -d ' ')"
export XAUTHORITY=/home/$USER/.Xauthority
export DISPLAY=:0
export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$(id -u $USER)/bus

INTERNAL_DISPLAY="eDP1"

case "$1" in
   close)
      xrandr --output $INTERNAL_DISPLAY --off ;;
   open)
      xrandr --output $INTERNAL_DISPLAY --auto --primary ;;
esac



