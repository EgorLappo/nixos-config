{
  description = "egor's nixos config";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };

    helix-flake = {
      url = github:helix-editor/helix;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ nixpkgs, home-manager, helix-flake, ... }:
    let
      vm-system = "aarch64-linux";
      lab-dell-system = "x86_64-linux";
    in
    rec {
      nixosConfigurations = {
        nixos-vm = nixpkgs.lib.nixosSystem
          {
            system = vm-system;

            pkgs = import nixpkgs {
              system = vm-system;
              overlays = [
                helix-flake.overlays.${vm-system}.default
              ];
              config = {
                allowUnfree = true;
              };
            };

            specialArgs = {
              inherit inputs;
            };

            modules = [
              ./system/machine/vm
              ./system/configuration.nix
              home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users.egor = import home/vm.nix;
              }
            ];
          };

        lab-dell = nixpkgs.lib.nixosSystem
          {
            system = lab-dell-system;

            pkgs = import nixpkgs {
              system = lab-dell-system;
              overlays = [
                helix-flake.overlays.${lab-dell-system}.default
              ];
              config = {
                allowUnfree = true;
              };
            };

            specialArgs = {
              inherit inputs;
            };

            modules = [
              ./system/machine/lab-dell
              ./system/configuration.nix
              home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users.egor = import home/lab-dell.nix;
              }
            ];
          };
      };
    };
}
