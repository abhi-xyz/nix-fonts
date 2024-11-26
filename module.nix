{
  config,
  pkgs,
  lib,
  ...
}: let
  availableFonts = {
    lora = pkgs.callPackage ./fonts/lora/default.nix {stdenvnocc = pkgs.stdenv;};
    inter = pkgs.callPackage ./fonts/inter/default.nix {stdenvnocc = pkgs.stdenv;};
  };

  Fonts = lib.mkOption {
    type = lib.types.listOf lib.types.str;
    default = ["lora"];
    description = "List of fonts to enable. Available options: lora, anotherFont, yetAnotherFont.";
  };

  selectedFontPackages = lib.mapAttrs (fontName: availableFonts.${fontName} or null) Fonts;
in {
  options.fonts.nix-fonts = {
    enable = lib.mkEnableOption "Enable the nix-fonts.";
    Fonts = Fonts;
  };

  config = lib.mkIf config.fonts.nix-fonts.enable {
    fonts.packages = lib.filterAttrs (name: value: value != null) selectedFontPackages;
  };
}
