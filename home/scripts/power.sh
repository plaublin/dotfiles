#!/bin/bash

# choices will be displayed in dmenu
choices="lock\nsuspend\nlogout\nreboot\nshutdown"

# Your choice in dmenu will determine what xrandr command to run
#chosen=$(echo -e $choices | dmenu -i)
chosen=$(echo -e $choices | rofi -dmenu)

lock_screen() {
	#light-locker-command -l
	i3lock -c 000000
}

case "$chosen" in
	lock) lock_screen;;
	logout) i3-msg exit;;
	suspend) lock_screen && systemctl suspend;;
	reboot) systemctl reboot;;
	shutdown) systemctl poweroff;;
esac

