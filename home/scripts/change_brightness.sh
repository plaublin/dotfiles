#!/bin/bash
# inspired from https://bbs.archlinux.org/viewtopic.php?id=258735

cmd=${1:-0}

if [ $cmd -eq 1 ]; then
	xbacklight -inc 5
elif [ $cmd -eq -1 ]; then
	xbacklight -dec 5
fi

bright=$(xbacklight)
bright=${bright%.*} # convert float to int

bar="🌕  "

if [ ${bright} = 0 ]; then
   bar="🌑  "
else
   ((chunks=${bright}/10))
   for ((i=0;i<chunks;++i)); do
       bar="${bar} ●"
   done
   if ((${bright}-10*chunks > 4)); then
       bar="${bar} ◉"
       ((++chunks))
   fi
   for ((i=chunks;i<10;++i)); do
       bar="${bar} ○"
   done
fi

dunstify "$bar" -u low -t 1000 -h int:value:"$bright" -h string:synchronous:"$bar" --replace=556
