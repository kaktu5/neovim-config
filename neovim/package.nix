{
  flake,
  pkgs,
  ...
}: let
  inherit (pkgs.stdenv.hostPlatform) system;
in {
  vim.package = flake.inputs.neovim-nightly.packages.${system}.neovim;
}
