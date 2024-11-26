{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.05";
  };

  outputs = {
    self,
    nixpkgs,
  }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    packages.${system} = {
      "lora" = pkgs.callPackage ./fonts/lora/default.nix {stdenvnocc = pkgs.stdenv;};
      default = self.packages.${system}.lora;
    };
    nixosModules = {
      "lora" = ./module.nix;
      nixosModules.default = self.nixosModules.lora;
    };
  };
}
