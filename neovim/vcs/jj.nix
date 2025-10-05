{
  flake,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.kkts) setup;
  inherit (pkgs.stdenv.hostPlatform) system;
in {
  vim = {
    extraPlugins.jj-nvim = {
      package = flake.packages.${system}.jj-nvim;
      setup = setup "jj" {};
    };

    maps.normal = {
      "<leader>jd".action = ":J describe<CR>";
      "<leader>jl".action = ":J log<CR>";
      "<leader>jn".action = ":J new<CR>";
      "<leader>js".action = ":J status<CR>";
    };
  };
}
