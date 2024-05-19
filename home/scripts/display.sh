#!/bin/bash
# This script is intended to make switching between laptop and external displays
# easier when using i3+dmenu
# source: https://gist.github.com/amanusk/6b79d407945ca79caa945ce2658fd987

# To run this script, map it to some shortcut in your i3 config, e.g:
# bindsym $mod+p exec --no-startup-id $config/display.sh
# IMPORTANT: run chmod +x on the script to make it executable
# The result is 4 options appearing in dmenu, from which you can choose

# This is your default laptop screen, detect by running `xrandr`
INTERNAL_DISPLAY="eDP1"

EXTERNAL_DISPLAY=""

# choices will be displayed in dmenu
choices="laptop\ndual\nexternal\nclone\nauto"

# Your choice in dmenu will determine what xrandr command to run
#chosen=$(echo -e $choices | dmenu -i)
chosen=$(echo -e $choices | rofi -dmenu)

# This is used to determine which external display you have connected
if [ `xrandr | grep '^DP3-1' | grep -c ' connected '` -eq 1 ]; then
        EXTERNAL_DISPLAY="DP3-1"
fi

if [ `xrandr | grep '^DP3' | grep -c ' connected '` -eq 1 ]; then
        EXTERNAL_DISPLAY="DP3"
fi

if [ "$EXTERNAL_DISPLAY" == "" ] && [ `xrandr | grep '^HDMI1' | grep -c ' connected '` -eq 1 ]; then
        EXTERNAL_DISPLAY="HDMI1"
fi

if [ "$EXTERNAL_DISPLAY" == "" ]; then
	# no second screen found
	exit 0
fi


# xrander will run and turn on the display you want,
#if you have an option for 3 displays, this will need some modifications
case "$chosen" in
    external) xrandr --output $INTERNAL_DISPLAY --off --output $EXTERNAL_DISPLAY --auto --primary ;;

    laptop) xrandr --output $INTERNAL_DISPLAY --auto --primary --output $EXTERNAL_DISPLAY --off ;;

    clone) xrandr --output $INTERNAL_DISPLAY --auto --output $EXTERNAL_DISPLAY --auto --same-as $INTERNAL_DISPLAY ;;

    dual) xrandr --output $INTERNAL_DISPLAY --auto --primary --output $EXTERNAL_DISPLAY --auto --right-of $INTERNAL_DISPLAY ;;

    auto) xrandr --auto ;;

esac

