{ config, pkgs, lib, ... }: 
let
  # Define available font packages
  availablefonts = {
    lora = pkgs.callPackage ./fonts/lora/default.nix { stdenvnocc = pkgs.stdenv; };
    inter = pkgs.callPackage ./fonts/inter/default.nix { stdenvnocc = pkgs.stdenv; };
    eb-garamond = pkgs.callPackage ./fonts/eb-garamond/default.nix { stdenvnocc = pkgs.stdenv; };
  };

  # Define the fonts option for selecting a list of font names
  fonts = lib.mkOption {
    type = lib.types.listOf lib.types.str;
    default = ["lora"];  # Default to "lora"
    description = "List of fonts to enable. Available options: lora, inter.";
  };

  # Map selected font names to font packages directly
  selectedfontPackages = lib.listToAttrs (map (fontName: {
    name = fontName;
    value = availablefonts.${fontName};  # Directly use the font package
  }) config.fonts.nix-fonts.fonts);

in {
  options.fonts.nix-fonts = {
    enable = lib.mkEnableOption "Enable the nix-fonts.";
    fonts = fonts;  # Include the fonts option in the module
  };

  config = lib.mkIf config.fonts.nix-fonts.enable {
    # Add selected font packages to the fonts list
    fonts.packages = lib.attrValues selectedfontPackages;
  };
}
