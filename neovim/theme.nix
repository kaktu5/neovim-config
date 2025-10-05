{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (config.vim) highlight;
  inherit (lib.attrsets) mapAttrsToList;
  inherit (lib.kkts) setup;
  inherit (lib.modules) mkForce;
  inherit (lib.nvim.dag) entryAfter;
  inherit (lib.nvim.lua) toLuaObject;
  inherit (lib.strings) concatLines;
in {
  vim = {
    extraPlugins.vague-nvim = {
      package = pkgs.vimPlugins.vague-nvim;
      setup = concatLines [
        (setup "vague" {
          transparent = true;
          bold = false;
          style = {
            boolean = "italic";
            keywords = "italic";
          };
        })
        "vim.cmd.colorscheme \"vague\""
      ];
    };

    luaConfigRC.highlight = mkForce (
      highlight
      |> mapAttrsToList (
        name: value: ''vim.api.nvim_set_hl(0, ${toLuaObject name}, ${toLuaObject value})''
      )
      |> concatLines
      |> entryAfter ["vague-nvim"]
    );
  };
}
