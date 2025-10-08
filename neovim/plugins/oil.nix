_: let
  border = ["┌" "─" "┐" "│" "┘" "─" "└" "│"];
in {
  vim = {
    utility.oil-nvim = {
      enable = true;
      setupOpts = {
        columns = {
          "@0" = "permissions";
          "@1" = "size";
          "@2" = "mtime";
          "@3" = {
            "@0" = "icon";
            add_padding = false;
          };
        };
        skip_confirm_for_simple_edits = true;
        constrain_cursor = "name";
        watch_for_changes = true;
        use_default_keymaps = false;
        keymaps = {
          "<CR>" = "actions.select";
          "<C-p>" = "actions.preview";
          "<C-c>" = {
            "@0" = "actions.close";
            mode = "n";
          };
          "-" = {
            "@0" = "actions.parent";
            mode = "n";
          };
          "_" = {
            "@0" = "actions.open_cwd";
            mode = "n";
          };
          "gs" = {
            "@0" = "actions.change_sort";
            mode = "n";
          };
          "gx" = "actions.open_external";
          "g." = {
            "@0" = "actions.toggle_hidden";
            mode = "n";
          };
        };
        view_options = {
          show_hidden = true;
          case_insensitive = true;
        };
        confirmation = {inherit border;};
        progress = {inherit border;};
        ssh = {inherit border;};
      };
    };

    maps.normal."<leader>pv".action = ":Oil<CR>";
  };
}
