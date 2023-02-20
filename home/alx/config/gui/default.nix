{ pkgs, lib, config, ... }:
{
    options.alx.gui = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
      };
    };
    config = {};
    imports = [
      ./sway
      ./waybar.nix
      ./wob.nix
    ];
}

