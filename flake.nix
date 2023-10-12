{
  description = "My linux laptop";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    impermanence.url = "github:nix-community/impermanence/master";
    impermanence.flake = false;
    lanzaboote = {
      url = "github:nix-community/lanzaboote";

      # Optional but recommended to limit the size of your system closure.
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... } @ inputs: 
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config = { allowUnfree = true; };
    };

    lib = nixpkgs.lib;

  in {
    homeManagerConfigurations = {
      alx = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        modules = [
          ./alx/home.nix
          #{
          #  home = {
          #    username = "alx";
          #    homeDirectory = "/home/alex";
          #  };
          #}
        ];
      };
    };

    nixosConfigurations = {
      sussybaka-computer = lib.nixosSystem {
        inherit system;
        modules = [
          (import "${inputs.impermanence}/nixos.nix")
          inputs.lanzaboote.nixosModules.lanzaboote
          ./nixos/configuration.nix
	  {
            system.autoUpgrade = {
  enable = true;
  flake = inputs.self.outPath;
  flags = [
    "--update-input"
    "nixpkgs"
    "-L" # print build logs
  ];
  dates = "hourly";
};
	  }
        ];
      };
    };
  };
}
