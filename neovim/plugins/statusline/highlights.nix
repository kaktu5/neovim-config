{config, ...}: let
  inherit (config.kkts) colors;
in {
  vim.highlight = {
    MiniStatuslineInactive = {
      fg = colors.fg0;
      bg = colors.bg0;
      bold = true;
    };
    MiniStatuslineInfoBg0 = {
      fg = colors.fg0;
      bg = colors.bg0;
    };
    MiniStatuslineInfoBg1 = {
      fg = colors.fg0;
      bg = colors.bg1;
    };
    MiniStatuslineInfoBg2 = {
      fg = colors.fg0;
      bg = colors.bg2;
    };
    MiniStatuslineModeCommand = {
      fg = colors.bg0;
      bg = colors.orange;
      bold = true;
    };
    MiniStatuslineModeInsert = {
      fg = colors.bg0;
      bg = colors.blue;
      bold = true;
    };
    MiniStatuslineModeNormal = {
      fg = colors.bg0;
      bg = colors.purple;
      bold = true;
    };
    MiniStatuslineModeOther = {
      fg = colors.bg0;
      bg = colors.orange;
      bold = true;
    };
    MiniStatuslineModeReplace = {
      fg = colors.bg0;
      bg = colors.red;
      bold = true;
    };
    MiniStatuslineModeVisual = {
      fg = colors.bg0;
      bg = colors.cyan;
      bold = true;
    };
  };
}
