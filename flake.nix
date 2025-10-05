{
  inputs = {
    systems.url = "github:nix-systems/default";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nvf.url = "github:notashelf/nvf";
  };

  outputs = {self, ...} @ inputs: let
    lib = inputs.nixpkgs.lib.fix (self:
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
        runtimeInputs = with pkgs; [alejandra fd mdformat stylua];
        text = ''
          fd "$@" -t f -e lua -X stylua '{}'
          fd "$@" -t f -e md -X mdformat '{}'
          fd "$@" -t f -e nix -E npins/ -X alejandra '{}'
        '';
      };
    });
}
