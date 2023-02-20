#!/bin/sh
set -eu
PIPE="/run/user/$(id -u)/wob"

if ! [ -p "$PIPE" ]
then
	notify-send "Cannot open $PIPE"
fi

if [ "$1" = "up" ]
then
	brightnessctl set "+${2}%"
elif [ "$1" = "down" ]
then
	brightnessctl set "${2}%-"
else
	notify-send "Invalid command"
fi
AVG=$(brightnessctl info --machine-readable | cut -d, -f4 |tr -d %)
wob.sh print "$AVG"

