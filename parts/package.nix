{pname, ...}: {
  perSystem = {pkgs, ...}: let
    registry = pkgs.fetchFromGitHub {
      owner = "bazelbuild";
      repo = "bazel-central-registry";
      rev = "27a3157e98e4dba4742a63fd7589030d5fbe78e2";
      hash = "sha256-gJr5bJ6Kj7jiUhnCC+YOUh3ChFR/55eUbwpP2srsVvM=";
    };
  in {
    packages.default = pkgs.buildBazelPackage {
      inherit pname;
      version = "1.0.0";

      src = ./.;
      bazel = pkgs.bazel_7;

      fetchAttrs.hash = "sha256-NpLWuVl8/cjaziS2gzyY8a87av+PlfY+IInYSDroe74=";

      buildInputs = with pkgs; [
        git
      ];

      bazelTargets = ["//src:main"];
      bazelTestTargets = ["//..."];
      bazelFlags = [
        "--registry"
        "file://${registry}"
      ];

      buildAttrs.installPhase = ''
        install -D --strip bazel-bin/src/main "$out/bin/$pname"
      '';
    };
  };
}
