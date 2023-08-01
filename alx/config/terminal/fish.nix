{ pkgs, ... }:
{
  programs.fish = {
      enable = true;
      shellAliases = {
        ls = "lsd";
        df = "duf";
        cat = "bat";
        vim = "lvim";
        nr = "nix run";
      };
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    # Configuration written to ~/.config/starship.toml
  };
}

