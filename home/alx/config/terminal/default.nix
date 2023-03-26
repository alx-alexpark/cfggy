{ lib, ... }:
{
  imports = [
    ./fish.nix
    ./git.nix
    ./email.nix
    ./newsboat.nix
  ];
}
