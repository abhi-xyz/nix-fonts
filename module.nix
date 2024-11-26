
{ config, pkgs, lib, ... }: 
let
  # Available font packages
  availableFonts = {
    lora = pkgs.callPackage ./fonts/lora/default.nix { stdenvnocc = pkgs.stdenv; };
    inter = pkgs.callPackage ./fonts/inter/default.nix { stdenvnocc = pkgs.stdenv; };
  };

  # Define the Fonts option where users can select a list of font names
  Fonts = lib.mkOption {
    type = lib.types.listOf lib.types.str;
    default = ["lora"];  # Default to using "lora" font
    description = "List of fonts to enable. Available options: lora, inter.";
  };

  # Map the selected font names (from the Fonts option) to actual font packages
  selectedFontPackages = lib.mapAttrs (fontName: availableFonts.${fontName} or null) config.fonts.nix-fonts.Fonts;

in {
  options.fonts.nix-fonts = {
    enable = lib.mkEnableOption "Enable the nix-fonts.";
    Fonts = Fonts;  # Include the Fonts option in the module
  };

  config = lib.mkIf config.fonts.nix-fonts.enable {
    # Filter out any null values from the selectedFontPackages (in case of non-existing fonts)
    fonts.packages = lib.filterAttrs (name: value: value != null) selectedFontPackages;
  };
}

