
{ config, pkgs, lib, ... }: 
let
  # Define available font packages
  availableFonts = {
    lora = pkgs.callPackage ./fonts/lora/default.nix { stdenvnocc = pkgs.stdenv; };
    inter = pkgs.callPackage ./fonts/inter/default.nix { stdenvnocc = pkgs.stdenv; };
  };

  # Define the Fonts option for selecting a list of font names
  Fonts = lib.mkOption {
    type = lib.types.listOf lib.types.str;
    default = ["lora"];  # Default to "lora"
    description = "List of fonts to enable. Available options: lora, inter.";
  };

  # Safely retrieve font packages based on the user's selection
  selectedFontPackages = lib.attrValues (lib.filterAttrs
    (fontName: availableFonts.${fontName} != null)  # Filter out invalid fonts
    (lib.listToAttrs (map (fontName: {
      name = fontName;
      value = availableFonts.${fontName} or null;
    }) config.fonts.nix-fonts.Fonts)));

in {
  options.fonts.nix-fonts = {
    enable = lib.mkEnableOption "Enable the nix-fonts.";
    Fonts = Fonts;  # Include the Fonts option in the module
  };

  config = lib.mkIf config.fonts.nix-fonts.enable {
    # Add selected font packages to the fonts list, filtering out null values
    fonts.packages = selectedFontPackages;
  };
}

