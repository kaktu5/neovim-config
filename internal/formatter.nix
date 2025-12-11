{
  lib,
  pkgs,
  ...
}: let
  inherit (lib.attrsets) attrValues;
  inherit (pkgs) writeShellApplication;
in
  writeShellApplication {
    name = "nvyx-nix3-fmt-wrapper";
    runtimeInputs = attrValues {
      inherit (pkgs) alejandra deadnix fd mdformat statix;
    };
    text = ''
      fd "$@" -t f -e md -X mdformat --wrap 120 '{}'
      fd "$@" -t f -e nix -E npins/ -X alejandra --quiet '{}'
      fd "$@" -t f -e nix -E npins/ -X deadnix --fail '{}'
      fd "$@" -t f -e nix -E npins/ -X statix check '{}'
    '';
  }
