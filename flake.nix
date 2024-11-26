{
  description = "A flake that provides fonts";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";  # Pinning to the stable version of nixpkgs
    flake-utils.url = "github:numtide/flake-utils";  # To simplify cross-system support
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachSystem [ "x86_64-linux" ] (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
      in {
        # Provide the font packages
        packages = {
          inter = pkgs.callPackage ./fonts/inter/default.nix { stdenvnocc = pkgs.stdenv; };
          lora = pkgs.callPackage ./fonts/lora/default.nix { stdenvnocc = pkgs.stdenv; };
        };

        # Optionally, provide a default package (here it defaults to inter)
        defaultPackage = self.packages.${system}.inter;

        # Expose systemPackages for convenience
        systemPackages = with pkgs; [
          self.packages.${system}.inter
          self.packages.${system}.lora
        ];
      }
    );
}

