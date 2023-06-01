{ config, pkgs, ... }:

{

  imports = [
    ./common
    ./home-common.nix
    ./vm
  ];

  home.sessionVariables = {
    MACHINE = "nixos-vm";
  };
}
