{
  inputs = {
    systems.url = "github:nix-systems/default";
    nixpkgs.follows = "nvf/nixpkgs";
    nvf.url = "github:notashelf/nvf";
    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs = {
    self,
    systems,
    nixpkgs,
    nvf,
    neovim-nightly,
  }: let
    inherit (nixpkgs.lib.attrsets) mapAttrs recursiveUpdate;
    inherit (nixpkgs.lib.fixedPoints) fix;
    inherit (nixpkgs.lib.lists) foldl';

    mapSystems = systems: f: (foldl' (acc: system: (f system
      |> mapAttrs (_: value: {${system} = value;})
      |> recursiveUpdate acc)) {}
    systems);

    lib = fix (self: nixpkgs.lib // nvf.lib // import ./lib.nix {lib = self;});
    sources = import ./npins;
  in
    mapSystems (import systems) (system: let
      pkgs = let
        pkgs = nixpkgs.legacyPackages.${system};
        flake-compat = import sources.flake-compat;
        statix = (flake-compat {src = sources.statix;}).defaultNix.packages.${system}.default;
      in
        (pkgs
          .extend (_: _: {inherit statix;}))
          .extend neovim-nightly.overlays.default;
      import' = path: import path {inherit lib pkgs self system;};
    in {
      devShells.default = import' ./internal/devshell.nix;
      formatter = import' ./internal/formatter.nix;

      packages =
        (import ./pkgs {
          inherit pkgs;
          sources = import ./npins;
        })
        // {
          inherit
            (lib.neovimConfiguration {
              inherit pkgs;
              extraSpecialArgs = {
                inherit lib;
                flake = self;
              };
              modules = [./neovim];
            })
            neovim
            ;
          default = self.packages.${system}.neovim;
        };
    });
}
