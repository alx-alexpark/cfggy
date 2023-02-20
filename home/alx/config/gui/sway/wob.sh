set -eu
FIFO="/run/user/$(id -u)/wob"

if [ "$#" -gt 0 -a "$1" = "print" ] ; then
	VAL="$2"
	BG="000000"
	BORDER="FFFFFF88"
	FG="6C71C488"
	printf "%s %s %s %s\n" $VAL $BG $BORDER $FG > $FIFO
	exit 0
fi
 if ! [ -p "$FIFO" ]
  then
    mkfifo "$FIFO"
  fi
bash -c "tail -f $FIFO | wob" & disown 

