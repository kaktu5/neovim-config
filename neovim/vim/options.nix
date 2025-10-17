_: {
  vim = {
    enableLuaLoader = true;

    lineNumberMode = "relative";

    undoFile.enable = false;

    clipboard = {
      enable = true;
      providers.wl-copy.enable = true;
      registers = "unnamedplus";
    };

    options = {
      expandtab = true;
      tabstop = 2;
      shiftwidth = 0;
      softtabstop = -1;

      scrolloff = 8;
      sidescrolloff = 8;

      wrap = false;

      virtualedit = "block";

      termguicolors = true;
    };
  };
}