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
        lib.attrsets.mapAttrs (_: attrs: attrs.${outputName}) systemOutputs);
  in
    forEachSystem (import inputs.systems) (system: let
      pkgs = inputs.nixpkgs.legacyPackages.${system};
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
        packages = with pkgs; [nixd npins];
      };

      formatter = pkgs.writeShellApplication {
        name = "fmt";
        # statix > 0.5.8
        # runtimeInputs = with pkgs; [alejandra deadnix fd mdformat statix];
        runtimeInputs =
          (with pkgs; [alejandra deadnix fd mdformat])
          ++ [(inputs.statix.packages.${system}.statix.overrideAttrs (_: {RUSTFLAGS = null;}))];
        text = ''
          fd "$@" -t f -e md -X mdformat '{}'
          fd "$@" -t f -e nix -E npins/ -X alejandra --quiet '{}'
          fd "$@" -t f -e nix -E npins/ -X deadnix --fail '{}'
          fd "$@" -t f -e nix -E npins/ -x statix check '{}'
        '';
      };
    });
}
