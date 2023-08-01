{ pkgs, lib, config, ... }:
{
    imports = [
      ./sway
      ./waybar-2.nix
      ./wob.nix
      ./mako.nix
    ];
}

