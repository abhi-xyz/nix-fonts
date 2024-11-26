# nix-fonts

This repository provides a Nix flake for easily installing a collection of fonts on your system. You can include this flake in your configuration to quickly set up your preferred fonts or fork the repo to customize it by adding your favorite fonts. This repository is personal, and I won't accept PRs for adding more fonts. Fork this and use that in your configuration.

## Getting Started

To use the fonts from this repository, include it as an input in your flake.nix:


```nix
{
  description = "NixOS Configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.05";

    nix-fonts = {    # -> 01
      url = "github:abhi-xyz/nix-fonts";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nix-fonts, # -> 02
    nixpkgs,
    ...
  }: let
  in {
    nixosConfigurations."nixos" = nixpkgs.lib.nixosSystem {
      inherit system;
      };
      modules = [
        ./hosts/configuration.nix
        nix-fonts.nixosModules.nix-fonts # -> 03
      ];
    };
  };
}```

```nix
# configuration.nix
  
fonts.nix-fonts = {
    enable = true;
    fonts = [
      "lora"
      "inter"
      "eb-garamond"
    ];
  };

```

## More Fonts

Feel free to fork this repository and add your favorite fonts to the font package. I have written the font package in a modular way to make it easy to add new fonts. Here's how you can do it:

- Add a New Font: Copy the folder for an existing font (e.g., fonts/lora) to fonts/some_font.
- Update default.nix: Add your new font package to default.nix.
- Update module.nix: Add your font to the availableFonts list.

If you're not sure how to add fonts, just take a look at the existing configuration for guidance.
