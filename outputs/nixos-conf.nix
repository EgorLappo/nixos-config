{ inputs, system, ... }:

let
  inherit (inputs.nixpkgs.lib) nixosSystem;

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
