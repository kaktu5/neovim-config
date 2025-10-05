{
  config,
  lib,
  ...
}: let
  inherit (config.kkts) colors;
  inherit (lib.modules) mkDefault;
  inherit (lib.options) mkOption;
  inherit (lib.types) str;
  mkColorOption = hex: (mkOption {
    type = str;
    default = hex;
  });
in {
  options.kkts.colors = {
    bg0 = mkColorOption "#060606"; # oklab(12%, 0%, 0%)
    bg1 = mkColorOption "#121212"; # oklab(18%, 0%, 0%)
    bg2 = mkColorOption "#1f1f1f"; # oklab(24%, 0%, 0%)
    bg3 = mkColorOption "#2e2e2e"; # oklab(30%, 0%, 0%)
    fg0 = mkColorOption "#cdcdcd";
    fg1 = mkColorOption "#bbbbbb";
    fg2 = mkColorOption "#aaaaaa";
    fg3 = mkColorOption "#999999";

    red = mkColorOption "#df6882";
    green = mkColorOption "#8cb66d";
    yellow = mkColorOption "#f3be7c";
    orange = mkColorOption "#e0a363";
    blue = mkColorOption "#7e98e8";
    purple = mkColorOption "#aeaed1";
    cyan = mkColorOption "#9bb4bc";

    termBg = mkOption {type = str;};
    term0 = mkOption {type = str;};
    term1 = mkOption {type = str;};
    term2 = mkOption {type = str;};
    term3 = mkOption {type = str;};
    term4 = mkOption {type = str;};
    term5 = mkOption {type = str;};
    term6 = mkOption {type = str;};
    term7 = mkOption {type = str;};
  };

  config.kkts.colors = with colors; {
    termBg = mkDefault bg0;
    term0 = mkDefault bg3;
    term1 = mkDefault red;
    term2 = mkDefault green;
    term3 = mkDefault yellow;
    term4 = mkDefault blue;
    term5 = mkDefault purple;
    term6 = mkDefault cyan;
    term7 = mkDefault fg0;
  };
}
