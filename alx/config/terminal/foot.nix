{ pkgs, ... }:
{
  config = {
    programs.foot = {
      enable = true;
      settings = {
        main = {
          term = "xterm-256color";
          font = "Iosevka:size=13";
          dpi-aware = "no";
          pad = "4x4 center";

        };
        url = {
          launch = "librewolf \${url}";
        };
      };
    };
  };
}

