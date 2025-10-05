{lib, ...}: let
  inherit (lib.generators) mkLuaInline;
  inherit (lib.kkts) collectModules;
in {
  imports = collectModules ./.;

  vim.mini.statusline = {
    enable = true;
    setupOpts.content.active = mkLuaInline ''
      function()
        local statusline = require("mini.statusline")

        local mode, mode_hl = statusline.section_mode({trunc_width = 100})
        local filename = statusline.section_filename({trunc_width = 120})
        local fileinfo = statusline.section_fileinfo({trunc_width = 100})
        local git = statusline.section_git({trunc_width = 20})
        local diff = statusline.section_diff({trunc_width = 55})
        local diagnostics = statusline.section_diagnostics({trunc_width = 55})
        local location = function() return "%l:%v" end
        local search = statusline.section_searchcount({trunc_width = 55})

        local has_diagnostics = diagnostics and diagnostics ~= ""
        local git_hl= has_diagnostics and "MiniStatuslineInfoBg2" or "MiniStatuslineInfoBg1"

        return statusline.combine_groups({
          {hl = mode_hl, strings = {mode}},
          {hl = "MiniStatuslineInfoBg2", strings = {filename}},
          {hl = "MiniStatuslineInfoBg1", strings = {fileinfo}},
          "%<",
          {hl = "MiniStatusLineInfoBg0"},
          "%=",
          {hl = "MiniStatuslineInfoBg1", strings = {diagnostics}},
          {hl = git_hl, strings = {git}},
          {hl = git_hl, strings = {diff}},
          {hl = mode_hl, strings = {search, location()}},
        })
      end
    '';
  };
}
