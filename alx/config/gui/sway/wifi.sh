CONNECTIONS="$(nmcli --get-values NAME,UUID,ACTIVE connection show)"
NAMES="$(printf "%s\n" "$CONNECTIONS" | cut -d: -f1)"
CHOICE="$(bemenu.sh -p network\><<< "$NAMES")"
CHOSEN="$(printf "%s\n" "$CONNECTIONS" | grep -E "^$CHOICE:")"
UUID="$(printf "%s\n" "$CHOSEN" | cut -d: -f2)"
if [ "$(printf "%s\n" "$CHOSEN" | cut -d: -f3)" = "yes" ]; then
   nmcli connection down "$UUID"
else
   nmcli connection up "$UUID"
fi
