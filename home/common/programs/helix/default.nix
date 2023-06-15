{ pkgs, ... }:
let config = "";
in
{
  programs.helix = {
    enable = true;
  };
}
