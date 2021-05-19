let
  sources = import ./nix/sources.nix;
  pkgs = import sources.nixpkgs { };
in
pkgs.stdenv.mkDerivation {
  name = "colmena";

  buildInputs = [ (import sources.colmena { }) ];
}
