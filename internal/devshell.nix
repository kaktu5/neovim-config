{
  lib,
  pkgs,
  ...
}: let
  inherit (lib.attrsets) attrValues;
  inherit (pkgs) mkShellNoCC;
in
  mkShellNoCC {
    name = "nvyx-devshell";
    packages = attrValues {
      inherit
        (pkgs)
        # markdown tooling
        markdownlint-cli2
        marksman
        mdformat
        # nix tooling
        deadnix
        nixd
        npins
        statix
        ;
    };
  }
