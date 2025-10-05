{lib, ...}: let
  inherit (lib.generators) mkLuaInline;
  border = ["┌" "─" "┐" "│" "┘" "─" "└" "│"];
in {
  vim = {
    utility.oil-nvim = {
      enable = true;
      setupOpts = {
        columns = mkLuaInline ''
          {
            "permissions",
            "size",
            "mtime",
            { "icon", add_padding = false },
          }
        '';
        skip_confirm_for_simple_edits = true;
        constrain_cursor = "name";
        watch_for_changes = true;
        use_default_keymaps = false;
        keymaps = mkLuaInline ''
          {
            ["<CR>"] = "actions.select",
            ["<C-p>"] = "actions.preview",
            ["<C-c>"] = { "actions.close", mode = "n" },
            ["-"] = { "actions.parent", mode = "n" },
            ["_"] = { "actions.open_cwd", mode = "n" },
            ["gs"] = { "actions.change_sort", mode = "n" },
            ["gx"] = "actions.open_external",
            ["g."] = { "actions.toggle_hidden", mode = "n" },
          }
        '';
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
