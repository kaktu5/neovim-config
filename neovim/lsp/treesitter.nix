{
  lib,
  pkgs,
  ...
}: {
  vim.treesitter.grammars = lib.attrsets.attrValues {
    inherit
      (pkgs.vimPlugins.nvim-treesitter.builtGrammars)
      asm
      bash
      linkerscript
      ron
      toml
      vim
      xml
      yaml
      ;
  };
}
