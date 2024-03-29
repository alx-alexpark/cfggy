#!/bin/bash
set -eu
PIPE="/run/user/$(id -u)/wob"

if ! [ -p "$PIPE" ] ; then
	notify-send "Cannot open wob pipe"
fi

if [ "$1" = "up" ] ; then
	pamixer -i "${2}"
elif [ "$1" = "down" ] ; then
	pamixer -d "${2}"
else
	notify-send "Invaild command"
fi
VAL=$(echo $(pamixer --get-volume) / 1.5 | bc)
wob.sh print "$VAL"
