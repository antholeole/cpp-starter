{pname, ...}: {
  perSystem = {pkgs, ...}: let
    registry = pkgs.fetchFromGitHub {
      owner = "bazelbuild";
      repo = "bazel-central-registry";
      rev = "27a3157e98e4dba4742a63fd7589030d5fbe78e2";
      hash = "sha256-gJr5bJ6Kj7jiUhnCC+YOUh3ChFR/55eUbwpP2srsVvM=";
    };
  in rec {
    packages.${pname} = pkgs.buildBazelPackage {
      inherit pname;
      version = "1.0.0";

      src = ./..;
      bazel = pkgs.bazel_7;

      fetchConfigured = false;
      fetchAttrs.hash = "sha256-ePiXCNG6GFPaJeN3RMpOCaV8JqDS3u77H9qoaU6fu7M=";

      buildInputs = with pkgs; [
        git
      ];

      bazelTargets = ["//src:main"];
      bazelFlags = [
        "--registry"
        "file://${registry}"
      ];

      buildAttrs.installPhase = ''
        install -D --strip bazel-bin/src/main "$out/bin/$pname"
      '';
    };
    packages.default = packages.${pname};
  };
}
