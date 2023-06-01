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
      nixosConfigurations =
        import ./outputs/nixos-conf.nix { inputs = inputs; system = vm-system; };
    };
}
