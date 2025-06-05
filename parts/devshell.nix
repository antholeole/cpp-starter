{...}: {
  perSystem = {
    pkgs,
    config,
    ...
  }: {
    devShells.default = pkgs.mkShell {
      inputsFrom = [
        config.packages.default

        # give $FLAKE_ROOT var
        config.flake-root.devShell
      ];

      packages = [
        # use the same clang tools as clang format to prevent
        # unecessary downloads.
        config.treefmt.programs.clang-format.package

        # TODO: this should be a check but its hard to get the compile_commands generated
        # in the derivation.
        (pkgs.writeShellApplication {
          name = "run-tidy";
          runtimeInputs = with pkgs; [
            toybox
            config.treefmt.programs.clang-format.package
            parallel
          ];
          text = ''
            parallel --citation
            
            find "$FLAKE_ROOT/src" -name "*.hh" -o -name "*.cc" | parallel clang-tidy {} -p "$FLAKE_ROOT/compile_commands.json"
          '';
        })
      ];

      shellHook = ''
        # maybe this should be somewhere else. this makes launching a new
        # shell very slow, but means that you will never have a broken IDE.
        bazel run @hedron_compile_commands//:refresh_all
      '';
    };
  };
}
