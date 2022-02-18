{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, utils }:
    with utils.lib;
    eachSystem defaultSystems (system:
      let
        pkgs = nixpkgs.legacyPackages."${system}";
        python-dev = pkgs.python310.withPackages (pythonPackages:
          with pythonPackages; [
            poetry
            black
            pyflakes
            isort
            nose
            pytest
          ]);
      in {
        devShell = pkgs.mkShell { buildInputs = with pkgs; [ python-dev ]; };

        defaultPackage = with pkgs.poetry2nix;
          mkPoetryApplication {
            projectDir = ./.;
            preferWheels = true;
          };

        defaultApp = utils.lib.mkApp { drv = self.defaultPackage."${system}"; };
      });
}
