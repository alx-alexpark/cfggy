{pkgs, ... }:
{
  # This file is for software that I just want installed, without any home-manager generated configuration.
  home.packages = with pkgs; [
    alacritty
    openjdk17-bootstrap
    firefox
    fish
    pass
    xdotool
    schildichat-desktop
    joplin-desktop
    unzip
    gnupg
    tmux
    vlc
    pciutils
    obs-studio
    fd
    fzf
    nheko
    ungoogled-chromium
    librewolf
    slack
    foot
    thunderbird
    neovim
    veracrypt
    opensc
    prismlauncher
    # development
    python39Full
    nodejs
    python39Packages.pip
    packwiz
    vscode
    rust-analyzer
    cargo
    rustc
    gcc
    openssl
    # better unix cmds
    lsd 
    tldr
    ripgrep
    duf
    bat 
  ];
}
