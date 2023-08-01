{ pkgs, ... }: {
  home.packages = [ pkgs.wob ];
  xdg.configFile."wob/wob.ini" = {
    enable = true;
    executable = false;
    text = ''
      anchor = top right
      max = 100
      timeout = 500
    '';
  };
}

