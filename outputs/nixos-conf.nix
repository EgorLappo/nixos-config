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
    inherit pkgs system;
    specialArgs = { inherit inputs; };
    modules = [
      ../system/machine/nixos-vm
      ../system/configuration.nix
      inputs.home-manager.nixosModules.home-manager
      {
        inputs.home-manager.useGlobalPkgs = true;
        inputs.home-manager.useUserPackages = true;
        inputs.home-manager.users.egor = import ../home/home.nix;
      }
    ];
  };

}
