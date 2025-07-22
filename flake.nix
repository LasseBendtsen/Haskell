{
  description = "Simple Haskell dev environment using ghcWithPackages";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };

        ghc = pkgs.haskellPackages.ghcWithPackages (hp: with hp; [
          cabal-install
          ghcid
          haskell-language-server
        ]);
      in {
        devShells.default = pkgs.mkShell {
          buildInputs = [ ghc ];
        };
      }
    );
}
