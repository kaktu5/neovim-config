{
  inputs = {
    systems.url = "github:nix-systems/default";
    nixpkgs.follows = "nvf/nixpkgs";
    nvf.url = "github:notashelf/nvf/v0.8";

    statix = {
      url = "github:oppiliappan/statix?rev=0f372c9c8f2981961c88dc1498b6f4d27696bdca";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        systems.follows = "systems";
      };
    };
  };

  outputs = {
    self,
    systems,
    nixpkgs,
    nvf,
    ...
  } @ inputs: let
    lib = nixpkgs.lib.fixedPoints.fix (self:
      nixpkgs.lib
      // nvf.lib
      // import ./lib.nix {lib = self;});
    forEachSystem = systems: f: (lib.lists.foldl' (acc: system: (f system
      |> lib.attrsets.mapAttrs (_: value: {${system} = value;})
      |> lib.attrsets.recursiveUpdate acc)) {}
    systems);
  in
    forEachSystem (import systems) (system: let
      # statix > 0.5.8
      # pkgs = nixpkgs.legacyPackages.${system};
      pkgs = nixpkgs.legacyPackages.${system}.extend (_: _: {
        statix = inputs.statix.packages.${system}.default.overrideAttrs (_: {RUSTFLAGS = null;});
      });
    in {
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

      devShells.default = pkgs.mkShellNoCC {
        packages = lib.attrsets.attrValues {
          inherit (pkgs) deadnix nil nixd npins statix;
        };
      };

      formatter = pkgs.writeShellApplication {
        name = "fmt";
        runtimeInputs = lib.attrsets.attrValues {
          inherit (pkgs) alejandra deadnix fd mdformat statix;
        };
        text = ''
          fd "$@" -t f -e md -X mdformat '{}'
          fd "$@" -t f -e nix -E npins/ -X alejandra --quiet '{}'
          fd "$@" -t f -e nix -E npins/ -X deadnix --fail '{}'
          fd "$@" -t f -e nix -E npins/ -x statix check '{}'
        '';
      };
    });
}