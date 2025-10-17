{pkgs, ...}: let
  inherit (pkgs) vimPlugins;
in {
  vim = {
    mini.trailspace.enable = true;

    utility.surround = {
      enable = true;
      useVendoredKeybindings = false;
    };

    visuals.nvim-web-devicons.enable = true;

    extraPlugins = {
      vim-sort-motion.package = vimPlugins.vim-sort-motion;
      vim-tmux-navigator.package = vimPlugins.vim-tmux-navigator;
    };
  };
}
