{ pkgs, ... }:
{
  programs.fish = {
      enable = true;
      shellAliases = {
        ls = "lsd";
        df = "duf";
        cat = "bat";
      };
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    # Configuration written to ~/.config/starship.toml
  };
}

