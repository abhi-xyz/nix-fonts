# nix-fonts

## Getting Started

```nix
{
pkgs,
...
}:
let

  LoraFont = pkgs.callPackage (pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/abhi-xyz/nix-fonts/refs/heads/master/fonts/lora/default.nix";
    sha256 = "sha256-f2mulc5ym/VAcp/mMUQ/W8C2qbs1HWHuAxPgOrG1lIU=";
  }) {stdenvnocc = pkgs.stdenv;};

  InterFont = pkgs.callPackage (pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/abhi-xyz/nix-fonts/refs/heads/master/fonts/inter/default.nix";
    sha256 = "sha256-c/d3n+YNhFrozWDdQZYGOgu/qkpVsSOZCSn7AjFLw9A=";
  }) {stdenvnocc = pkgs.stdenv;};

in
{
  fonts.packages = with pkgs; [
    LoraFont
    InterFont
  ];
}
```
