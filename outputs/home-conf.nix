{ inputs, system, ... }:

with inputs;

let
  fishOverlay = f: p: {
    inherit fish-bobthefish-theme fish-keytool-completions;
  };

  libOverlay = f: p: rec {
    libx = import ../lib { inherit (p) lib; };
    lib = p.lib.extend (_: _: {
      inherit (libx) removeNewline secretManager;
    });
  };

  pkgs = import nixpkgs {
    inherit system;

    config.allowUnfree = true;

    overlays = [
      fishOverlay
      libOverlay
      nurpkgs.overlay
    ];
  };

  nur = import nurpkgs {
    inherit pkgs;
    nurpkgs = pkgs;
  };

  imports = [
    ../home/home.nix
  ];

  mkHome = { hidpi ? false }: (
    home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      extraSpecialArgs = {
        inherit hidpi;
        inherit (rycee-nurpkgs.lib.${system}) buildFirefoxXpiAddon;
        addons = nur.repos.rycee.firefox-addons;
      };

      modules = [{ inherit imports; }];
    }
  );
in
{
  nixos-vm = mkHome { hidpi = true; };
}
