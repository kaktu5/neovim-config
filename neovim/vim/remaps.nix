_: {
  vim.maps = {
    normal = {
      "Q".action = "<Nop>";
      "J".action = "mzJ`z";
      "\\".action = ":noh<CR>";
    };
    visual = {
      "J".action = ":m '>+1<CR>gv=gv";
      "K".action = ":m '<-2<CR>gv=gv";
    };
    visualOnly."<leader>p".action = "\"_dP";
  };
}
