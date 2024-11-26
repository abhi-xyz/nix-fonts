{ config, pkgs, lib, ... }: 
let
  # Available font packages as a set of named attributes
  availableFonts = {
    lora = pkgs.callPackage ./fonts/lora/default.nix { stdenvnocc = pkgs.stdenv; };
    inter = pkgs.callPackage ./fonts/inter/default.nix { stdenvnocc = pkgs.stdenv; };
  };

  # Define the Fonts option to allow users to select a list of font names
  Fonts = lib.mkOption {
    type = lib.types.listOf lib.types.str;
    default = ["lora"];  # Default to using "lora" font
    description = "List of fonts to enable. Available options: lora, inter.";
  };

  # Map the selected font names (from the Fonts option) to actual font packages
  selectedFontPackages = lib.filterAttrs
    (fontName: availableFonts.${fontName} != null)
    (lib.listToAttrs (map (fontName: { name = fontName; value = availableFonts.${fontName}; }) config.fonts.nix-fonts.Fonts));
    
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

