{
  description = "very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      username = "limjihoon";
    in {
      nixosConfigurations = {
        ${username} = nixpkgs.lib.nixosSystem {        
          inherit system;
          modules = [
            ./modules/configs/docker-config.nix
          ];
        };
      };

      homeConfigurations = {
        ${username} = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./home.nix ];
        };
      };
    };

}
