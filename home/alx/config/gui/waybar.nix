{ pkgs, lib, config, ... }:
let
in 
{
  home.activation = {
    reloadWaybar = lib.hm.dag.entryAfter ["writeBoundary"] ''
      pkill -SIGUSR2 waybar || true
    '';
  };
  programs.waybar = {
    enable = true;
    style = builtins.readFile ./waybar.css;
    settings = [
      {
        layer = "top";
        position = "top";
        height = 21;

        modules-left = [
          "cpu"
          "memory"
          "network"
        ];
        modules-center = [
          "sway/workspaces"
        ];

        modules-right = [
          "battery"
          "clock#time"
          "clock#date"
        ];
        #modules = {
          "battery" = {
            interval = 1;
            states = {
              warning = 30;
              critical = 15;
            };
            format = " {capacity}%";
            format-discharging = "{icon} {capacity}%";
            format-icons = [
              ""
              ""
              ""
              ""
              ""
            ];
            tooltip = false;
          };

          "clock#time" = {
            interval = 10;
            format = "{:%T}";
            tooltip = false;
          };

          "clock#date" = {
            interval = 20;
            format = "{:%F}";
            tooltip = false;
          };

          "cpu" = {
            interval = 5;
            tooltip = false;
            format = "節 {usage}%";
            states = {
              warning = 70;
              critical = 90;
            };
          };

          "memory" = {
            interval = 5;
            format = " {}%";
            states = {
              warning = 70;
              critial = 90;
            };
          };

          "network" = {
            interval = 5;
            format-wifi = " {essid}";
            tooltip = true;
            tooltip-format="{ipaddr}";
            format-ethernet = " {ifname}";
            format-disconnected = "Disconnected";
          };

          "sway/mode" = {
            format = "<span style=\"italic\"> {}</span>";
            tooltip = false;
          };

          "sway/window" = {
            format = "{}";
            max-length = 30;
            tooltip = false;
          };

          "sway/workspaces" = {
            all-outputs = false;
            format = "{name}:{icon}";
            disable-scroll = false;
  	    format-icons = {
	      "1" = "";
	      "2" = "󰙯";
	      "3" = "󰭹";
	      "4" = "";
	      "5" = "";
	      "6" = "";
	      "7" = "";
	      "8" = "";
	      "9" = "";
	      "10" = "";
	    };
          };

          "temperature" = {
            critical-threshold = 90;
            interval = 5;
            format = "{icon} {temperature}";
            format-icons = [
              ""
              ""
              ""
              ""
              ""
            ];
            tooltip = false;
          };
          "mpd" = {
            interval = 2;
            tooltip = false;
            format = "{stateIcon} ({randomIcon}{repeatIcon}{singleIcon}) {artist}: {title} [{elapsedTime:%M:%S}/{totalTime:%M:%S}]";
            format-stopped = "";
            format-disconnected = "No MPD for you!";
            state-icons = {
              playing = "P";
              paused  = "p";
            };
            random-icons = {
              on  = "Z";
              off = "z";
            };
            repeat-icons = {
              on  = "R";
              off = "r";
            };
            single-icons = {
              on  = "S";
              off = "s";
            };
          };
          "tray" = {
            icon-size = 21;
          };

        #};
      }
    ];
  };
}
