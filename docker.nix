# Run as:
#   docker load -i $(
#     nix-build docker.nix \
#       --argstr name <image-name> \
#       --argstr tag <image-tag>
#   )
let
  nixpkgs = builtins.fetchTarball {
    sha256 = "02yk20i9n5nhn6zgll3af7kp3q5flgrpg1h5vcqfdqcck8iikx4b";
    url = "https://github.com/NixOS/nixpkgs/archive/db6e089456cdddcd7e2c1d8dac37a505c797e8fa.tar.gz";
  };
  pkgs = import nixpkgs { };
  windicss = (import ./. { inherit pkgs; }).shell.nodeDependencies;
in
{ name ? "sridca/windicss"
, tag ? "dev"
}: pkgs.dockerTools.buildImage {
  inherit name tag;
  contents = [
    windicss
    # These are required for the GitLab CI runner
    pkgs.coreutils
    pkgs.bash_5
  ];

  config = {
    WorkingDir = "/data";
    Volumes = {
      "/data" = { };
    };
    Entrypoint = [ "${windicss}/bin/windicss" ];
  };
}
