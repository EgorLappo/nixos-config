{ pkgs, ... }:
let config = "";
in
{
  programs.tmux = {
    enable = true;
  };
}
