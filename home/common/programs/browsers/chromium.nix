{ pkgs, ... }:
let
  ext = import ./ch_extensions.nix;
in
{
  programs.chromium = {
    enable = true;

    commandLineArgs = [ "--force-device-scale-factor=1.5" ];

    extensions = builtins.attrValues ext;
  };
}
