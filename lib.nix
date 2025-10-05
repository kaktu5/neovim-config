{lib}: let
  inherit (builtins) readDir;
  inherit (lib.attrsets) attrNames;
  inherit (lib.lists) filter map;
  inherit (lib.nvim.lua) toLuaObject;
  inherit (lib.strings) hasPrefix;
in {
  kkts = {
    collectModules = path:
      readDir path
      |> attrNames
      |> filter (file:
        !(hasPrefix "." file)
        && file != "default.nix")
      |> map (file: /${path}/${file});

    setup = name: expr: ''require("${name}").setup(${toLuaObject expr})'';
  };
}
