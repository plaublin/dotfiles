#!/bin/bash
# inspired from https://bbs.archlinux.org/viewtopic.php?id=258735

cmd=${1:-0}
MAX_VOLUME=150
STEP=2

volume=$(pamixer --get-volume)

if [ $cmd -eq 1 ] && [ $volume -lt $MAX_VOLUME ]; then
	pactl set-sink-volume @DEFAULT_SINK@ +${STEP}%
elif [ $cmd -eq -1 ]; then
	pactl set-sink-volume @DEFAULT_SINK@ -${STEP}%
elif [ $cmd -eq 0 ]; then
	pactl set-sink-mute @DEFAULT_SINK@ toggle
fi

volume=$(pamixer --get-volume)
mute=$(pamixer --get-mute)

if [ ${mute} == "true" ]; then
   bar="x   Mute"
else
   bar="♫  "
   ((chunks=${volume}/10))
   for ((i=0;i<chunks;++i)); do
       bar="${bar} ●"
   done
   if ((${volume}-10*chunks > 4)); then
       bar="${bar} ◉"
       ((++chunks))
   fi
   for ((i=chunks;i<10;++i)); do
       bar="${bar} ○"
   done
   #bar="${bar} (${volume}%)"
fi

dunstify "$bar" -u low -t 1000 -h int:value:"$volume" -h string:synchronous:"$bar" --replace=555
