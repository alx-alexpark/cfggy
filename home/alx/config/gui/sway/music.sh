set -ex
function playerctldata {
  if [ "$(playerctl status 2> /dev/null || echo paused)" = "Playing" ]; then
     PLAY=true
   else
      PLAY=false
   fi
  printf '{%s,"playing":%s}\n' \
  "$(playerctl metadata --format '"artist":"{{artist}}","title":"{{title}}","album":"{{album}}"' 2>/dev/null || echo "")"\
  "$PLAY"
}

function mpddata {
   if [ "$(mpc status %state% || echo paused)" = "playing" ]; then
      PLAY=true
   else
      PLAY=false
   fi
   printf '{%s,"playing":%s}\n'\
      "$((mpc status -f '"title":"%title%","artist":"%artist%","album":"%album%"' || echo "") | head -n1)" \
   "$PLAY"
}

function ag {
   printf '[%s,%s]\n' "$(playerctldata)" "$(mpddata)"
}

function pctl {
   C="$(printf "mpd\nplayerctl\n" | bemenu.sh)"
   case "$C" in
      "mpd")
         mpc $1
         ;;
      "playerctl")
         playerctl $1
         ;;
   esac
}

MPC_STAT="$(mpc status '%state%')"
MPC_COUNT="$(mpc queued)"
PC_STAT="$(playerctl status 2>/dev/null || echo Paused)"
PC_COUNT="$(playerctl -l 2>/dev/null || printf "" | wc -l)"
case "$1" in
   "play")
      if [ "$MPC_STAT" = "paused" -a "$PC_COUNT" -eq 0 ]; then
         # MPC is paused and no playerctl players
         mpc play
      elif [ "$MPC_COUNT" = "" -a "$PC_STAT" = "Paused" ]; then
         playerctl play
      else 
         pctl play
      fi
      ;;
   "pause")
      if [ "$MPC_STAT" = "playing" -a "$PC_COUNT" -eq 0 ]; then
         mpc pause
      elif [ "$MPC_STAT" = "playing" -a "$PC_STAT" = "Paused" ]; then
         mpc pause
      elif [ "$MPC_COUNT" = "" -a "$PC_STAT" = "Playing" ]; then
         playerctl pause
      else
         pctl pause
      fi
      ;;
   "next")
      if [ "$MPC_STAT" = "playing" -a "$PC_COUNT" -eq 0 ]; then
         mpc next
         mpc toggle; mpc toggle
      elif [ "$MPC_STAT" = "playing" -a "$PC_STAT" = "Paused" ]; then
         mpc next
         mpc toggle; mpc toggle
      elif [ "$MPC_COUNT" = "" -a "$PC_STAT" = "Playing" ]; then
         playerctl next
      else
         pctl next
      fi
      ;;
   "metadata")
      echo "$(ag)"
   ;;

esac
