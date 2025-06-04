{...}: {
  perSystem = {
    pkgs,
    config,
    ...
  }: {
    devShells.default = pkgs.mkShell {
      inputsFrom = [
        config.packages.default
      ];

      shellHook = ''
        bazel run @hedron_compile_commands//:refresh_all
      '';
    };
  };
}
