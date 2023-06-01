{
  description = "gvolpe's Home Manager & NixOS configurations";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # neovim-flake = {
    #   url = github:gvolpe/neovim-flake;
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

  };

  outputs = inputs@{ nixpkgs, home-manager, ... }:
    let
      vm-system = "aarch64-linux";
    in
    rec {
      nixosConfigurations = {
        nixos-vm = nixpkgs.lib.nixosSystem
          {
            system = vm-system;

            pkgs = import nixpkgs {
              system = vm-system;
              config = {
                allowUnfree = true;
              };
            };

            specialArgs = {
              inherit inputs;
            };

            modules = [
              ./system/machine/nixos-vm
              ./system/configuration.nix
              home-manager.nixosModules.home-manager
              {
                home-manager. useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users.egor = import home/home.nix;
              }
            ];
          };
      };
    };
}
