{pkgs, ...}: let
  inherit (pkgs.vimPlugins.nvim-treesitter) builtGrammars;
in {
  vim.treesitter.grammars = with builtGrammars; [
    asm
    bash
    linkerscript
    ron
    toml
    vim
    wgsl-bevy
    xml
    yaml
  ];
}
