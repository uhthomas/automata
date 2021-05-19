{
  meta.nixpkgs = import (import ./sources.nix).nixpkgs { };

  defaults = ./defaults.nix;

  "5dc508ed7c" = ./pillowtalk;
  d9294fd26f = ./pillowtalk;
  "44fe941f5c" = ./pillowtalk;
  c28593b8bf = ./pillowtalk;
  f0b8e3e4f7 = ./pillowtalk;
}
