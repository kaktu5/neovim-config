{lib, ...}: let
  inherit (lib.modules) mkForce;
in {
  vim.lsp.servers = {
    clangd.cmd = mkForce ["clangd"];
    cssls.cmd = mkForce ["vscode-css-language-server" "--stdio"];
    hls.cmd = mkForce ["haskell-language-server-wrapper" "--lsp"];
    superhtml.cmd = mkForce ["superhtml" "lsp"];
    lua-language-server.cmd = mkForce ["lua-language-server"];
    marksman.cmd = mkForce ["marksman" "server"];
    nil.cmd = mkForce ["nil"];
    nixd.cmd = mkForce ["nixd"];
    ocaml-lsp.cmd = mkForce ["ocamllsp"];
    qmlls.cmd = mkForce ["qmlls"];
    ts_ls.cmd = mkForce ["typescript-language-server" "--stdio"];
    tinymist.cmd = mkForce ["tinymist"];
  };

  vim.languages = {
    # enableDAP = true;
    # enableExtraDiagnostics = true;
    # enableFormat = true;
    enableTreesitter = true;

    clang.enable = true;
    css = {
      enable = true;
      format.type = "biome";
    };
    haskell.enable = true;
    html.enable = true;
    lua = {
      enable = true;
      lsp.lazydev.enable = true;
    };
    markdown = {
      enable = true;
      format.type = "prettierd";
    };
    nix = {
      enable = true;
      lsp.servers = ["nil" "nixd"];
    };
    ocaml.enable = true;
    qml.enable = true;
    rust = {
      enable = true;
      lsp.package = ["rust-analyzer"];
      extensions.crates-nvim.enable = true;
    };
    ts.enable = true;
    typst = {
      enable = true;
      format.type = "typstyle";
    };
    zig.enable = true;
  };
}