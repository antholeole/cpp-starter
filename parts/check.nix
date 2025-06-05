{...}: {
  # the formatting is checked by the treefmt module.
  perSystem = {
    config,
    pkgs,
    ...
  }: {
    checks.tests = config.packages.default.overrideAttrs {
      bazelTestTargets = ["//..."];
    };
  };
}
