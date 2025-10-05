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

  outputs = {self, ...} @ inputs: let
    lib = inputs.nixpkgs.lib.fixedPoints.fix (self:
      inputs.nixpkgs.lib
      // inputs.nvf.lib
      // import ./lib.nix {lib = self;});
    forEachSystem = systems: f: let
      systemOutputs = lib.attrsets.genAttrs systems f;
      outputNames = systemOutputs |> lib.attrsets.attrValues |> lib.lists.head |> lib.attrsets.attrNames;
    in
      lib.attrsets.genAttrs outputNames (outputName:
        systemOutputs |> lib.attrsets.mapAttrs (_: attrs: attrs.${outputName}));
  in
    forEachSystem (import inputs.systems) (system: let
      # statix > 0.5.8
      # pkgs = inputs.nixpkgs.legacyPackages.${system};
      pkgs = inputs.nixpkgs.legacyPackages.${system}.extend (_: _: {
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

      devShells.default = pkgs.mkShell {
        packages = with pkgs; [deadnix nixd npins statix];
      };

      formatter = pkgs.writeShellApplication {
        name = "fmt";
        runtimeInputs = with pkgs; [alejandra deadnix fd mdformat statix];
        text = ''
          fd "$@" -t f -e md -X mdformat '{}'
          fd "$@" -t f -e nix -E npins/ -X alejandra --quiet '{}'
          fd "$@" -t f -e nix -E npins/ -X deadnix --fail '{}'
          fd "$@" -t f -e nix -E npins/ -x statix check '{}'
        '';
      };
    });
}
