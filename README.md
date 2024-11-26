# nix-fonts
```nix
{pkgs, ...}: let
  InterFont = pkgs.callPackage (pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/abhi-xyz/nix-fonts/refs/heads/master/fonts/inter/default.nix";
    sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
  }) {stdenvnocc = pkgs.stdenv;};
in {
  fonts.packages = with pkgs; [
    maple-mono
    InterFont
    (nerdfonts.override {
      fonts = [
        "FiraCode"
        "FiraMono"
        "Iosevka"
        "JetBrainsMono"
        "NerdFontsSymbolsOnly"
      ];
    })
  ];
}
```
