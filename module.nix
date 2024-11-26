{ config, pkgs, lib, ... }: 
let
  availablefonts = {
    lora = pkgs.callPackage ./fonts/lora/default.nix { stdenvnocc = pkgs.stdenv; };
    inter = pkgs.callPackage ./fonts/inter/default.nix { stdenvnocc = pkgs.stdenv; };
    eb-garamond = pkgs.callPackage ./fonts/eb-garamond/default.nix { stdenvnocc = pkgs.stdenv; };
    playfair = pkgs.callPackage ./fonts/playfair/default.nix { stdenvnocc = pkgs.stdenv; };
  };

  fonts = lib.mkOption {
    type = lib.types.listOf lib.types.str;
    default = ["lora"];
    description = "List of fonts to enable. Available options: lora, inter.";
  };

  selectedfontPackages = lib.listToAttrs (map (fontName: {
    name = fontName;
    value = availablefonts.${fontName}; 
  }) config.fonts.nix-fonts.fonts);

in {
  options.fonts.nix-fonts = {
    enable = lib.mkEnableOption "Enable the nix-fonts.";
    fonts = fonts;  
  };

  config = lib.mkIf config.fonts.nix-fonts.enable {
    fonts.packages = lib.attrValues selectedfontPackages;
  };
}
