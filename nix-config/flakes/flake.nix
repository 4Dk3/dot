{
  description = "A very basic flake as a test for my new config.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, ... } @ inputs:
  {

   nixosConfigurations.powr4e = nixpkgs.lib.nixosSystem {

      modules = [
        ../configuration.nix
      ];
    };
  };
}
