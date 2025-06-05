{...}: {
  # the formatting is checked by the treefmt module.
  perSystem = {config, ...}: {
    checks.tests = config.packages.default.overrideAttrs {
      bazelTestTargets = ["//..."];
    };
  };
}
