{pkgs, ... }:
{
  home.packages = with pkgs; [
    openjdk17-bootstrap
    firefox
    fish
    pass
    xdotool
    unzip
    gnupg
    tmux
    pciutils
    obs-studio
    fd
    discord
    librewolf
    slack
    python39Full
    python39Packages.pip
  ];
}
