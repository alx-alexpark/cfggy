{ lib, ... }:
{
  imports = [
    ./gui
    ./terminal
    ./yubikey.nix
    ./programs.nix
  ];
}
