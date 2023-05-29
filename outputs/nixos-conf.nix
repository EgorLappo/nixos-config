{ inputs, system, ... }:

let
  inherit (inputs.nixpkgs.lib) nixosSystem;

  libx = import ../lib { inherit (inputs.nixpkgs) lib; };

  lib = inputs.nixpkgs.lib.extend (_: _: {
    inherit (libx) secretManager;
  });


  pkgs = import inputs.nixpkgs {
    inherit system;
    config = {
      allowUnfree = true;
    };
  };
in
{
  nixos-vm = nixosSystem {
    inherit lib pkgs system;
    specialArgs = { inherit inputs; };
    modules = [
      ../system/machine/nixos-vm
      ../system/configuration.nix
    ];
  };

}
