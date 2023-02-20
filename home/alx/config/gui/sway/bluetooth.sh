DEVICES="$(bluetoothctl --timeout 0.5 devices)"
NAMES="$(cut -d " " -f 3- <<< "$DEVICES")"
DEV="$(bemenu.sh -p device\> <<< "$NAMES")"
DEV_MAC="$(grep "$DEV" <<< "$DEVICES" | cut -d " " -f 2)"
DEV_PAIRED="$(bluetoothctl --timeout 0.5 info "$DEV_MAC" | grep Connected | awk '{ print $2 }')"
if [ "$DEV_PAIRED" = "yes" ]; then
   OUTPUT="$(bluetoothctl disconnect "$DEV_MAC")"
   if grep "Successful disconnected" <<< "$OUTPUT"; then
      notify-send "Disconnected from $DEV"
   else
      notify-send "Could not disconnect from $DEV"
   fi
else
   OUTPUT="$(bluetoothctl connect "$DEV_MAC")"
   if grep "Connection successful" <<< "$OUTPUT"; then
      notify-send "Connected to $DEV"
   else
      notify-send "Could not connect to $DEV"
   fi
fi
