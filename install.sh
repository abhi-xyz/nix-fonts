#!/usr/bin/env bash

# Ensure the first argument is passed to the script
args=$1

# Validate that the argument is provided
if [ -z "$args" ]; then
  echo "Error: No font package specified."
  exit 1
fi

# Run the nix-build with the specified font package
nix-build -E "with import <nixpkgs> {}; callPackage ./fonts/$args/default.nix { stdenvnocc = stdenv; }"

