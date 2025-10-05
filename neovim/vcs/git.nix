_: {
  vim = {
    git = {
      gitsigns.enable = true;
      vim-fugitive.enable = true;
    };

    maps.normal = {
      "<leader>ga".action = ":G add %<CR>";
      "<leader>gc".action = ":G commit<CR>";
      "<leader>gl".action = ":G log<CR>";
      "<leader>gs".action = ":G status<CR>";
    };
  };
}
