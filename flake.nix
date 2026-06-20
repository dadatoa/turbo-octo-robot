{
  description = "A simple NixOS flake";
  
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    preservation.url = "github:nix-community/preservation";
  };

  outputs = inputs@{ nixpkgs, preservation, ... }: {
    nixosConfigurations.nixos = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        inputs.preservation.nixosModules.default
        ./vm-conf.nix
        ./filesystems.nix
        ./preservation.nix
      ];
    };
  };
}
