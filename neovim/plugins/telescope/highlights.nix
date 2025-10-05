{config, ...}: let
  inherit (config.kkts) colors;
in {
  vim.highlight = {
    TelescopeBorder = {
      fg = colors.bg1;
      bg = colors.bg1;
    };
    TelescopeMatching = {
      fg = colors.cyan;
      bold = true;
      italic = true;
    };
    TelescopeNormal = {
      fg = colors.fg0;
      bg = colors.bg1;
    };
    TelescopePreviewBorder = {
      fg = colors.bg1;
      bg = colors.bg1;
    };
    TelescopePreviewLine = {
      bg = colors.bg2;
      bold = true;
      italic = true;
    };
    TelescopePreviewTitle = {
      fg = colors.bg2;
      bg = colors.orange;
      bold = true;
    };
    TelescopePromptBorder = {
      fg = colors.bg2;
      bg = colors.bg2;
    };
    TelescopePromptCounter = {
      fg = colors.cyan;
      bg = colors.bg2;
      bold = true;
    };
    TelescopePromptNormal = {
      fg = colors.fg0;
      bg = colors.bg2;
    };
    TelescopePromptPrefix = {
      fg = colors.cyan;
      bg = colors.bg2;
      bold = true;
    };
    TelescopePromptTitle = {
      fg = colors.bg2;
      bg = colors.cyan;
      bold = true;
    };
    TelescopeResultsNormal = {
      fg = colors.fg1;
      bg = colors.bg1;
    };
    TelescopeResultsTitle = {
      fg = colors.bg1;
      bg = colors.bg1;
    };
    TelescopeSelection = {
      fg = colors.fg0;
      bg = colors.bg2;
    };
    TelescopeSelectionCaret = {
      fg = colors.cyan;
      bg = colors.bg2;
      bold = true;
    };
  };
}
