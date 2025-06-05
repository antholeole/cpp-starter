{
  description = "a simple C++ starter flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

    flake-parts.url = "github:hercules-ci/flake-parts";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    flake-root.url = "github:srid/flake-root";
  };

  outputs = {
    flake-parts,
    treefmt-nix,
    flake-root,
    ...
  } @ inputs: let
    pname = "cpp-starter";
  in
    flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [
        treefmt-nix.flakeModule
        flake-root.flakeModule

        ./parts/devshell.nix
        ./parts/package.nix
        ./parts/fmt.nix
        ./parts/check.nix
      ];

      systems = [
        "x86_64-linux"
      ];

      _module.args = {
        inherit pname;
      };
    };
}
