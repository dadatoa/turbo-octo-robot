{
  description = "A simple NixOS flake";

  inputs = {
    # NixOS official package source, here using the nixos-26.05 branch
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    # The host with the hostname `my-nixos` will use this configuration
    nixosConfigurations.my-nixos = nixpkgs.lib.nixosSystem {
      modules = [
        ./vm-conf.nix
      ];
    };
  };
}
