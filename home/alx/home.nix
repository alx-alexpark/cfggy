{ config, pkgs, ... }:

{
  imports = 
    [
      ./config
    ];
  
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfreePredicate = (pkg: true);
  
  alx.gui.fontSize = 16;
  alx.gui.font = "Jetbrains Mono";
  alx.gui.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "alx";
  home.homeDirectory = "/home/alex";
  # my programs
  # programs.steam = {
  #  enable = true;
  # };
  
  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.11";
}
