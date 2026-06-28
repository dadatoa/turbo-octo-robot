{
  description = "A simple NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    preservation.url = "github:nix-community/preservation";
    disko.url = "github:nix-community/disko";
  };

  outputs =
    inputs@{ nixpkgs, preservation, ... }:
    {
      nixosConfigurations.nixdomu = inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          inputs.preservation.nixosModules.default
          inputs.disko.nixosModules.default
          ./vm-config/configuration.nix
          ./vm-config/filesystems.nix
          ./vm-config/preservation.nix
          ./vm-config/networking.nix
        ];
      };
      nixosConfigurations.xen = inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          inputs.preservation.nixosModules.default
          inputs.disko.nixosModules.default
          ./xen-config/configuration.nix
          ./xen-config/disko.nix
          ./xen-config/preservation.nix
        ];
      };
    };
}
