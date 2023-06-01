{ config, pkgs, ... }:

{

  imports = [
    ./common
    ./home-common.nix
    ./lab-dell
  ];

  home.sessionVariables = {
    MACHINE = "lab-dell";
  };
}
