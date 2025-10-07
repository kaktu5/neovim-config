{pkgs, ...}: {
  vim = {
    mini.trailspace.enable = true;

    utility.surround = {
      enable = true;
      useVendoredKeybindings = false;
    };

    visuals.nvim-web-devicons.enable = true;

    extraPlugins = with pkgs.vimPlugins; {
      vim-sort-motion.package = vim-sort-motion;
      vim-tmux-navigator.package = vim-tmux-navigator;
    };
  };
}
