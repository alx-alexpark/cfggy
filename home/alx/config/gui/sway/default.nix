{ pkgs, config, lib, ... }:
let
  cfg = config.alx.gui;
  all-sh = pkgs.writeShellScriptBin "all.sh" (builtins.readFile ./all.sh);
  audio-sh = pkgs.writeShellScriptBin "audio.sh" (builtins.readFile ./audio.sh);
  bemenu-sh = pkgs.writeShellScriptBin "bemenu.sh" "bemenu -b -l 30 --fn 'Iosevka 10' --nb '#3D3488DD' --tb '#3D3488DD' --hb '#3D3488DD' --fb '#3D3488DD' --hf '#706E9ADD' --ab '#3D3488DD' --tf '#FFFFFF' $@";
  bluetooth-sh = pkgs.writeShellScriptBin "bluetooth.sh" (builtins.readFile ./bluetooth.sh);
  brightness-sh = pkgs.writeShellScriptBin "brightness.sh" (builtins.readFile ./brightness.sh);
  #games-sh = import ./games.nix { inherit pkgs; };
  music-sh = pkgs.writeShellScriptBin "music.sh" (builtins.readFile ./music.sh);
  #shorten-sh = pkgs.writeShellScriptBin "shorten.sh" (builtins.readFile ./shorten.sh);
  wifi-sh = pkgs.writeShellScriptBin "wifi.sh" (builtins.readFile ./wifi.sh);
  wob-sh = pkgs.writeShellScriptBin "wob.sh" (builtins.readFile ./wob.sh);
in lib.mkIf cfg.enable
{
  home.packages = with pkgs; [
    all-sh
    audio-sh
    bemenu
    bemenu-sh
    bluetooth-sh
    #games-sh
    grim
    imv
    mako
    music-sh
    pamixer
    slurp
    swaylock-effects
    wifi-sh
    wl-clipboard
    wob-sh
  ];
  wayland.windowManager.sway = lib.mkIf config.alx.gui.enable {
    enable = true;
    wrapperFeatures.gtk = true;
    xwayland = true;
    config = {
      bars = [];
      floating = {
        border = 0;
      };
      input = {
        "*" = {
          xkb_layout = "us";
          xkb_variant = "colemak";
          xkb_numlock = "enable";
          xkb_options = "compose:caps";
        };
      };
      output = {
        eDP-1 = {
          #bg = "${pkgs.wallpapers}/share/wallpapers/pxl_earth.png fill";
        };
      };
      input = {
        touchpad = {
          natural_scroll = "enabled";
        }; 
        mouse = {
          accel_profile = "flat";
          pointer_accel = "-0.2";
        };
      };
      terminal = "foot";
      modifier = "Mod4";
      gaps = {
        bottom = 10;
        top = 10;
        inner = 10;
        outer = 20;
      };
      keybindings = lib.mkOptionDefault {
        "Mod4+space" = "exec bemenu-run -b -l 30 --fn 'Iosevka 10' --nb '#3D3488DD' --tb '#3D3488DD' --hb '#3D3488DD' --fb '#3D3488DD' --hf '#706E9ADD' --ab '#3D3488DD' -p ''";
        "Mod4+p" = "exec bash -c 'grim -g \"$(slurp)\" - | wl-copy -t image/png'";
        #"Mod4+d" = "exec ${games-sh}/bin/games.sh";
        "Mod4+y" = "exec swaylock --screenshots --effect-pixelate 20";
        "Mod4+shift+y" = "exec systemctl suspend";
        "Mod4+KP_Subtract" = "exec pactl set-sink-volume @DEFAULT_SINK -10%";
        "Mod4+Mod1+Left" = "move workspace to output left";
        "Mod4+Mod1+Right" = "move workspace to output right";
        "Mod4+b" = "exec ${bluetooth-sh}/bin/bluetooth.sh";
        "XF86AudioPlay" = "exec ${music-sh}/bin/music.sh play";
        "XF86AudioPause" = "exec ${music-sh}/bin/music.sh pause";
        "XF86AudioNext" = "exec ${music-sh}/bin/music.sh next";
        "XF86MonBrightnessUp" = "exec ${brightness-sh}/bin/brightness.sh up 5";
        "XF86MonBrightnessDown" = "exec ${brightness-sh}/bin/brightness.sh down 5";
        "Mod4+w" = "exec ${wifi-sh}/bin/wifi.sh";
        #"Mod4+shift+s" = "exec ${shorten-sh}/bin/shorten.sh";
      };
      keycodebindings = {
        "122" = "exec ${audio-sh}/bin/audio.sh down 10"; # XF86LowerVolume
        "123" = "exec ${audio-sh}/bin/audio.sh up 10"; # XF86RaiseVolume
        "121" = "exec pactl set-sink-mute @DEFAULT_SINK@ toggle"; # XF86AudioMute
        "Mod4+86" = "exec ${audio-sh}/bin/audio.sh up 10";
        "Mod4+82" = "exec ${audio-sh}/bin/audio.sh down 10";
        "Mod4+63" = "exec mpc toggle";
      };
      window = {
        border = 0;
      };
      startup = [
        {
          command = "waybar";
        }
        {
          command = "${wob-sh}/bin/wob.sh start";
        }
        {
          command = "mako";
        }
        {
          command = builtins.readFile ./idle.sh;
        }
      ];
    };
    extraConfig = ''
    bindswitch --reload --locked lid:on output eDP-1 disable
    bindswitch --reload --locked lid:off output eDP-1 enable
    '';
};
}
