{ config, pkgs, ... }:
let
  # tokyonight colors
  colors = builtins.readFile ./colors.ini;

  default-modules = builtins.readFile ./default_modules.ini;
in
{
  home.packages = with pkgs; [
    font-awesome # awesome fonts
    material-design-icons # fonts with glyphs
  ];

  services.polybar = {
    enable = true;
    config = ./wm_config.ini;
    extraConfig = colors + default-modules;

    script = ''
      polybar vm &
    '';
  };
}
