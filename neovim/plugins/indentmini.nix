{
  config,
  flake,
  lib,
  pkgs,
  ...
}: let
  inherit (config.kkts) colors;
  inherit (lib.kkts) setup;
  inherit (pkgs.stdenv.hostPlatform) system;
in {
  vim = {
    extraPlugins.indentmini-nvim = {
      package = flake.packages.${system}.indentmini-nvim;
      setup = setup "indentmini" {};
    };

    highlight = {
      IndentLine.fg = colors.bg1;
      IndentLineCurrent.fg = colors.bg1;
    };
  };
}
