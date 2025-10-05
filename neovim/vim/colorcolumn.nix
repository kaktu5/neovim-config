{config, ...}: let
  inherit (config.kkts) colors;
in {
  vim = {
    luaConfigRC.colorcolumn = "vim.o.colorcolumn = \"120\"";
    highlight.ColorColumn.bg = colors.bg1;
  };
}
