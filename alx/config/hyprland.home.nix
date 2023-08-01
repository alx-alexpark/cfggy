#
# Waybar on Hyprland config
#

{ config, ... }:

{
  programs.waybar = {
    enable = true;
    systemd = {
      enable = false;
      target = "graphical-session.target";
    };
    style = ''
* {
  font-family: "JetBrainsMono Nerd Font";
  font-size: 12pt;
  font-weight: bold;
  border-radius: 0px;
  transition-property: background-color;
  transition-duration: 0.5s;
}
@keyframes blink_red {
  to {
    background-color: rgb(242, 143, 173);
    color: rgb(26, 24, 38);
  }
}
.warning, .critical, .urgent {
  animation-name: blink_red;
  animation-duration: 1s;
  animation-timing-function: linear;
  animation-iteration-count: infinite;
  animation-direction: alternate;
}
window#waybar {
  background-color: transparent;
}
window > box {
  margin-left: 5px;
  margin-right: 5px;
  margin-top: 5px;
  background-color: rgb(30, 30, 46);
}
#workspaces {
  padding-left: 0px;
  padding-right: 4px;
}
#workspaces button {
  padding-top: 5px;
  padding-bottom: 5px;
  padding-left: 6px;
  padding-right: 6px;
}
#workspaces button.active {
  background-color: rgb(181, 232, 224);
  color: rgb(26, 24, 38);
}
#workspaces button.urgent {
  color: rgb(26, 24, 38);
}
#workspaces button:hover {
  background-color: rgb(248, 189, 150);
  color: rgb(26, 24, 38);
}
tooltip {
  background: rgb(48, 45, 65);
}
tooltip label {
  color: rgb(217, 224, 238);
}
#custom-launcher {
  font-size: 20px;
  padding-left: 8px;
  padding-right: 6px;
  color: #7ebae4;
}
#mode, #clock, #memory,
#temperature, #cpu, #mpd,
#custom-wall, #temperature,
#backlight, #pulseaudio,
#network, #battery, #custom-powermenu,
#custom-cava-internal {
  padding-left: 10px;
  padding-right: 10px;
}
/* #mode { */
/* 	margin-left: 10px; */
/* 	background-color: rgb(248, 189, 150); */
/*     color: rgb(26, 24, 38); */
/* } */
#memory {
  color: rgb(181, 232, 224);
}
#cpu {
  color: rgb(245, 194, 231);
}
#clock {
  color: rgb(217, 224, 238);
}
/* #idle_inhibitor {
  color: rgb(221, 182, 242);
}*/
#custom-wall {
  color: rgb(221, 182, 242);
}
#temperature {
  color: rgb(150, 205, 251);
}
#backlight {
  color: rgb(248, 189, 150);
}
#pulseaudio {
  color: rgb(245, 224, 220);
}
#network {
  color: #ABE9B3;
}
#network.disconnected {
  color: rgb(255, 255, 255);
}
#battery.charging, #battery.full, #battery.discharging {
  color: rgb(250, 227, 176);
}
#battery.critical:not(.charging) {
  color: rgb(242, 143, 173);
}
#custom-powermenu {
  color: rgb(242, 143, 173);
}
#tray {
  padding-right: 8px;
  padding-left: 10px;
}
#mpd.paused {
  color: #414868;
  font-style: italic;
}
#mpd.stopped {
  background: transparent;
}
#mpd {
  color: #c0caf5;
}
#custom-cava-internal{
  font-family: "Hack Nerd Font" ;
}
      '';
    settings = [{
      "layer" = "top";
      "position" = "top";
      modules-left = [
        "custom/launcher"
        "wlr/workspaces"
        "temperature"
        #"idle_inhibitor"
        "custom/wall"
        "mpd"
        "custom/cava-internal"
      ];
      modules-center = [
        "clock"
      ];
      modules-right = [
        "pulseaudio"
        "backlight"
        "memory"
        "cpu"
        "network"
        "battery"
        "custom/powermenu"
        "tray"
      ];
      "custom/launcher" = {
        "format" = " ";
        "on-click" = "pkill wofi || ~/.config/wofi/launcher.sh";
        "tooltip" = false;
      };
      "custom/wall" = {
        "on-click" = "wallpaper_random";
        "on-click-middle" = "default_wall";
        "on-click-right" = "killall dynamic_wallpaper || dynamic_wallpaper &";
        "format" = " 󰠖 ";
        "tooltip" = false;
      };
      "custom/cava-internal" = {
        "exec" = "sleep 1s && cava-internal";
        "tooltip" = false;
      };
      "wlr/workspaces" = {
        "format" = "{icon}";
        "on-click" = "activate";
        # "on-scroll-up" = "hyprctl dispatch workspace e+1";
        # "on-scroll-down" = "hyprctl dispatch workspace e-1";
      };
      "idle_inhibitor" = {
        "format" = "{icon}";
        "format-icons" = {
          "activated" = "";
          "deactivated" = "";
        };
        "tooltip" = false;
      };
      "backlight" = {
        "device" = "intel_backlight";
        "on-scroll-up" = "light -A 5";
        "on-scroll-down" = "light -U 5";
        "format" = "{icon} {percent}%";
        "format-icons" = [ "󰃝" "󰃞" "󰃟" "󰃠" ];
      };
      "pulseaudio" = {
        "scroll-step" = 1;
        "format" = "{icon} {volume}%";
        "format-muted" = "󰖁 Muted";
        "format-icons" = {
          "default" = [ "" "" "" ];
        };
        "states" = {
          "warning" = 85;
        };
        "on-click" = "pamixer -t";
        "tooltip" = false;
      };
      "battery" = {
        "interval" = 10;
        "states" = {
          "warning" = 20;
          "critical" = 10;
        };
        "format" = "{icon} {capacity}%";
        "format-icons" = [ "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
        "format-full" = "{icon} {capacity}%";
        "format-charging" = "󰂄 {capacity}%";
        "tooltip" = false;
      };
      "clock" = {
        "interval" = 1;
        "format" = "{:%H:%M  %A %b %d}";
        "tooltip" = true;
        /* "tooltip-format"= "{=%A; %d %B %Y}\n<tt>{calendar}</tt>" */
        "tooltip-format" = "上午：高数\n下午：Ps\n晚上：Golang\n<tt>{calendar}</tt>";
      };
      "memory" = {
        "interval" = 1;
        "format" = "󰍛 {percentage}%";
        "states" = {
          "warning" = 85;
        };
      };
      "cpu" = {
        "interval" = 1;
        "format" = "󰻠 {usage}%";
      };
      "mpd" = {
        "max-length" = 25;
        "format" = "<span foreground='#bb9af7'></span> {title}";
        "format-paused" = " {title}";
        "format-stopped" = "<span foreground='#bb9af7'></span>";
        "format-disconnected" = "";
        "on-click" = "mpc --quiet toggle";
        "on-click-right" = "mpc update; mpc ls | mpc add";
        "on-click-middle" = "kitty --class='ncmpcpp' ncmpcpp ";
        "on-scroll-up" = "mpc --quiet prev";
        "on-scroll-down" = "mpc --quiet next";
        "smooth-scrolling-threshold" = 5;
        "tooltip-format" = "{title} - {artist} ({elapsedTime:%M:%S}/{totalTime:%H:%M:%S})";
      };
      "network" = {
        "format-disconnected" = "󰯡 Disconnected";
        "format-ethernet" = "󰀂 {ifname} ({ipaddr})";
        "format-linked" = "󰖪 {essid} (No IP)";
        "format-wifi" = "󰖩 {essid}";
        "interval" = 1;
        "tooltip" = false;
      };
      "temperature" = {
        # "hwmon-path"= "${env:HWMON_PATH}";
        #"critical-threshold"= 80;
        "tooltip" = false;
        "format" = " {temperatureC}°C";
      };
      "custom/powermenu" = {
        "format" = "";
        "on-click" = "pkill wofi || ~/.config/wofi/powermenu.sh";
        "tooltip" = false;
      };
      "tray" = {
        "icon-size" = 15;
        "spacing" = 5;
      };
    }];
  };
  #home.file = import ./theme_nord.nix;
}
