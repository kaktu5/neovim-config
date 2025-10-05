_: {
  vim.autocomplete.blink-cmp = {
    enable = true;
    setupOpts.completion.menu.auto_show = false;
    mappings = {
      complete = null;
      close = "<C-e>";
      confirm = "<C-y>";
      next = "<C-n>";
      previous = "<C-p>";
      scrollDocsDown = "<C-f>";
      scrollDocsUp = "<C-d>";
    };
  };
}
