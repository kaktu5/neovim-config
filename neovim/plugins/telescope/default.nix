{lib, ...}: let
  inherit (lib.kkts) collectModules;
  inherit (lib.lists) singleton;
in {
  imports = collectModules ./.;

  vim = {
    telescope = {
      enable = true;
      mappings = {
        buffers = null;
        diagnostics = null;
        findFiles = "<leader>pf";
        findProjects = null;
        gitBranches = null;
        gitBufferCommits = null;
        gitCommits = null;
        gitStash = null;
        gitStatus = null;
        helpTags = "<leader>ph";
        liveGrep = "<leader>pg";
        lspDefinitions = null;
        lspDocumentSymbols = null;
        lspImplementations = null;
        lspReferences = null;
        lspTypeDefinitions = null;
        lspWorkspaceSymbols = null;
        open = "<leader>pp";
        resume = "<leader>pr";
      };
      setupOpts.defaults = {
        file_ignore_patterns = [
          ".lock"
          "_build/"
          "result/"
          "target/"
        ];
        prompt_prefix = " ";
        selection_caret = "> ";
        sorting_strategy = "descending";
        layout_config = {
          height = 0.9;
          width = 0.9;
          horizontal = {
            prompt_position = "bottom";
            preview_width = 0.625;
          };
        };
      };
    };

    autocmds = singleton {
      event = ["User"];
      pattern = ["TelescopePreviewerLoaded"];
      command = "setlocal number";
    };
  };
}
