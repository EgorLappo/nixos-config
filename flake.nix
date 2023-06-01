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

    # Fish shell

    fish-bobthefish-theme = {
      url = github:gvolpe/theme-bobthefish;
      flake = false;
    };

    fish-keytool-completions = {
      url = github:ckipp01/keytool-fish-completions;
      flake = false;
    };

  };

  outputs = inputs:
    let
      vm-system = "aarch64-linux";
    in
    rec {
      nixosConfigurations = {
        nixos-vm = nixpkgs.lib.nixosSystem
          {
            system = vm-system;

            pkgs = import inputs.nixpkgs {
              inherit system;
              config = {
                allowUnfree = true;
              };
            };

            modules = [
              ../system/machine/nixos-vm
              ../system/configuration.nix
              home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users.egor = import home/home.nix;
              }
            ];
          };
      };
    };
