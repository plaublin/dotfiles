#!/bin/bash

USER="$(who | grep :0\) | cut -f 1 -d ' ')"
export XAUTHORITY=/home/$USER/.Xauthority
export DISPLAY=:0
export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$(id -u $USER)/bus

########### Settings ###########

# Use 'xrandr' to find these
DP="DP"
HDMI="HDMI1"
INTERNAL_DISPLAY="eDP1"

# Do no change!
EXTERNAL_DISPLAY=""

get_dpid() {
   dpid="${DP}$1"
   if [ $i -gt 4 ]; then
      dpid="${DP}3-$(($i-4))"
   fi
   echo $dpid
}

# Check to see if the external display is connected
for i in {1..7}; do
   if [ -e "/sys/class/drm/card0-DP-${i}" ] && [ "$(cat /sys/class/drm/card0-DP-${i}/status)" == "connected" ]; then
      EXTERNAL_DISPLAY=$(get_dpid $i)
      break
   fi
done

if [ "$EXTERNAL_DISPLAY" == "" ] && [ "$(cat /sys/class/drm/card0-HDMI-A-1/status)" == "connected" ]; then
      EXTERNAL_DISPLAY=$HDMI
fi

if [ "$EXTERNAL_DISPLAY" != "" ]; then

   # Set the display settings
   xrandr -d $DISPLAY --output ${INTERNAL_DISPLAY} --auto --primary --output ${EXTERNAL_DISPLAY} --auto --right-of ${INTERNAL_DISPLAY}
   
else

   # Restore to single display
   xrandr --output $INTERNAL_DISPLAY --auto --primary --output $HDMI --off
   for i in {1..7}; do
      xrandr --output $(get_dpid $i) --off
   done
   
fi

exit 0
