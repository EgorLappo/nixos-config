{ config, pkgs, ... }:
let
  # tokyonight colors
  colors = builtins.readFile ./colors.ini;

  default-modules = builtins.readFile ./default_modules.ini;

  vm-bar = builtins.readFile ./vm_config.ini;
in
{
  home.packages = with pkgs; [
    font-awesome # awesome fonts
    material-design-icons # fonts with glyphs
  ];

  services.polybar = {
    enable = true;

    config = ./config.ini;

    extraConfig = colors + vm-bar + default-modules;

    script = ''
      polybar vm &
    '';
  };
}
