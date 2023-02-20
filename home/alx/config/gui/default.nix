{ pkgs, lib, config, ... }:
{
    imports = [
      ./sway
      ./waybar.nix
      ./wob.nix
    ];
}

