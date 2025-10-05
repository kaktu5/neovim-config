{
  lib,
  pkgs,
  sources,
}: let
  inherit (lib) licenses;
  inherit (lib.strings) substring;
  inherit (pkgs.vimUtils) buildVimPlugin;
  inherit (sources) jj-nvim;
in
  buildVimPlugin {
    pname = "jj-nvim";
    version = substring 0 8 jj-nvim.revision;
    src = jj-nvim;
    meta = {
      description = "A Neovim plugin for Jujutsu (jj) version control system.";
      homepage = "https://github.com/nicolasgb/jj.nvim";
      license = licenses.mit;
    };
  }
