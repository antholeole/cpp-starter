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
      # maybe this should be somewhere else. this makes launching a new
      # shell very slow, but means that you will never have a broken IDE.
      bazel run @hedron_compile_commands//:refresh_all 
      '';
    };
  };
}
