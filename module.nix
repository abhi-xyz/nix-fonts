
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
  selectedFontPackages = lib.filterAttrs
    (fontName: availableFonts.${fontName} != null)  # Filter out fonts that don't exist
    (lib.listToAttrs (map (fontName: { name = fontName; value = lib.getAttr fontName availableFonts null; }) config.fonts.nix-fonts.Fonts));
    
in {
  options.fonts.nix-fonts = {
    enable = lib.mkEnableOption "Enable the nix-fonts.";
    Fonts = Fonts;  # Include the Fonts option in the module
  };

  config = lib.mkIf config.fonts.nix-fonts.enable {
    # Only add valid (non-null) font packages to the `fonts.packages`
    fonts.packages = lib.attrValues selectedFontPackages;
  };
}

