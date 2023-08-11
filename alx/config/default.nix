{ lib, ... }:
{
  imports = [
    ./gui
    ./terminal
    ./programs.nix
    ./syncthing.nix
  ];
}
