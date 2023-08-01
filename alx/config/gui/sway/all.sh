OPTIONS="w
b"
CHOICE="$(bemenu.sh <<< "$OPTIONS")"
case "$CHOICE" in
   "w")
      bash wifi.sh
      ;;
   "b")
      bash bluetooth.sh
      ;;
esac
