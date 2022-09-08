# use nix build .#homemanagerConfig.thor.activationPackage
{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };
#    stylix.url = "github:danth/stylix";
  };

  outputs = { self, nixpkgs, home-manager, }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      lib = nixpkgs.lib;
    in {
      nixosConfigurations = {
        thor = lib.nixosSystem {
          inherit system;
          modules = [ ./configuration.nix
 #                     home-manager.nixosModules.home-manager
 #                    stylix.nixosModules.stylix
                    ];
        };
      };
      homemanagerConfig = {
        thor = home-manager.lib.homeManagerConfiguration {
          inherit system pkgs;
          username = "thor";
          homeDirectory = "/home/thor";
          stateVersion = "22.05";
          configuration = {
            import = [
              ./home.nix
            ];
          };
        };
      };
  };
}
