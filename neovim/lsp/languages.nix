_: {
  vim.languages = {
    enableDAP = true;
    enableExtraDiagnostics = true;
    enableFormat = true;
    enableTreesitter = true;

    clang.enable = true;
    css = {
      enable = true;
      format.type = "biome";
    };
    haskell.enable = true;
    html.enable = true;
    markdown = {
      enable = true;
      format.type = "prettierd";
    };
    nix = {
      enable = true;
      lsp.servers = ["nixd"];
    };
    ocaml.enable = true;
    rust = {
      enable = true;
      crates.enable = true;
    };
    typst = {
      enable = true;
      format.type = "typstyle";
    };
  };
}
