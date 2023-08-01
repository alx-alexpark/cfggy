swayidle -w \
   timeout 300 'swaylock --effect-pixelate 20 --grace 10 --screenshots' \
   timeout 600 'swaymsg "output * dpms off" && systemctl suspend' \
   resume 'swaymsg "output * dpms on"' \
