{...}: {
  perSystem = {...}: {
    treefmt.programs = {
      buildifier.enable = true;
      clang-format.enable = true;
    };
  };
}
