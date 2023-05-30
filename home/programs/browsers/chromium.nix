{ pkgs, ... }:
let
  ext = import ./ch_extensions.nix;
in
{
  programs.chromium = {
    enable = true;
    package = pkgs.chromium.override {
      callPackage = p: attrs: pkgs.callPackage p (attrs // { deviceScaleFactor = 2.0; });
    };
    extensions = builtins.attrValues ext;
  };
}
