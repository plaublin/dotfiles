#!/bin/bash
# inspired by https://github.com/rjekker/i3-battery-popup

SLEEP_TIME="1m"
BATTERIES=( /sys/class/power_supply/BAT*/uevent )
LOW_BATTERY=10
REALLY_LOW_BATTERY=5


# This function returns an awk script
# Which prints the battery percentage
# It's an ugly way to include a nicely indented awk script here
get_awk_source() {
    cat <<EOF
BEGIN {
    FS="=";
}
\$1 ~ /ENERGY_FULL$/ {
    f += \$2;
}
\$1 ~ /ENERGY_NOW\$/ {
    n += \$2;
}
\$1 ~ /CHARGE_FULL$/ {
    f += \$2;
}
\$1 ~ /CHARGE_NOW\$/ {
    n += \$2;
}
END {
    print int(100*n/f);
}
EOF
}

is_battery_discharging() {
    grep STATUS=Discharging "${BATTERIES[@]}" && return 0
    return 1
} >/dev/null

get_battery_perc() {
    awk -f <(get_awk_source) "${BATTERIES[@]}"
}

create_popup() {
	perc=$1
	message=$2
	bar="🔋  "
	dunstify "$bar $message" -t 10000 -h int:value:"$perc" -h string:synchronous:"$perc" 
}

while true; do
	# check battery percentage
	if is_battery_discharging; then
		PERC=$(get_battery_perc)

		if [ $PERC -le $REALLY_LOW_BATTERY ]; then
			i3-msg 'exec i3-nagbar -t error -m "Urgent: battery is really low! You should plug-in the device immediately!"' &> /dev/null
		elif [ $PERC -le $LOW_BATTERY ]; then
			create_popup $PERC "Warning: battery is becoming low"
		fi
	fi
	sleep $SLEEP_TIME
done
