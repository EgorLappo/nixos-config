let
  ext = import ./ch_extensions.nix;
in
{
  programs.chromium = {
    enable = true;
    extensions = builtins.attrValues ext;
  };
}
