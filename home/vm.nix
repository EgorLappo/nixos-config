{ config, pkgs, ... }:

{

  imports = builtins.concatMap import [
    ./common
    ./home-common.nix
    ./vm
  ];

  home.sessionVariables = {
    MACHINE = "nixos-vm";
  };
}
