{
  description = "Dor's NixOS Flake";

  nixConfig = {
    experimental-features = [ "nix-command" "flakes" ];
    warn-dirty = false;
    extra-substituters = [
      # Nix community's cache server
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    master.url = "github:NixOS/nixpkgs/master";
    stable.url = "github:NixOS/nixpkgs/nixos-23.05";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:pjones/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, plasma-manager, nix-index-database, ... }@inputs: {
    nixosConfigurations = {
      "dor-workstation" = nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";
        specialArgs = {
          pkgs-master = import inputs.master {
            system = system;
            config.allowUnfree = true;
          };
        };
        modules = [
          (args: { nixpkgs.overlays = import ./overlays args; })
          nix-index-database.nixosModules.nix-index

          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.dor = import ./home;
            home-manager.extraSpecialArgs = specialArgs;
            home-manager.sharedModules = [
              plasma-manager.homeManagerModules.plasma-manager
            ];
          } 
        ];
      };
    };
  };
}
