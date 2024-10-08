{
  description = "Kompact project";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    pre-commit-hooks-nix.url = "github:hercules-ci/pre-commit-hooks.nix/flakeModule";
    pre-commit-hooks-nix.inputs.nixpkgs.follows = "nixpkgs";
    aiken.url = "github:aiken-lang/aiken/v1.0.29-alpha";
    treefmt-nix.url = "github:numtide/treefmt-nix";
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; }
      {
        imports = [
          inputs.pre-commit-hooks-nix.flakeModule
          inputs.treefmt-nix.flakeModule
        ];
        systems = [ "x86_64-linux" "aarch64-darwin" ];
        perSystem = { config, self', inputs', pkgs, ... }: {
          treefmt = {
            projectRootFile = "flake.nix";
            flakeFormatter = true;
            programs = {
              prettier = {
                enable = true;
              };
            };
          };

          devShells.default = 
          pkgs.mkShell {
            nativeBuildInputs = [
              config.treefmt.build.wrapper
            ]
            ;
            shellHook = ''
              orcfax-types-aiken devshell
            '';
            name = "orcfax-types-aiken";
            packages = with pkgs; [
              inputs'.aiken.packages.aiken
              deno
            ];
          };
        };
        flake = { };
      };
}
