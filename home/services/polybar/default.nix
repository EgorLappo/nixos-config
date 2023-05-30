{ config, pkgs, ... }:
let
  # tokyonight colors
  colors = builtins.readFile ./colors.ini;

  default-modules = builtins.readFile ./default_modules.ini;

  wm-bar = builtins.readFile ./wm_config.ini;
in
{
  home.packages = with pkgs; [
    font-awesome # awesome fonts
    material-design-icons # fonts with glyphs
  ];

  services.polybar = {
    enable = true;
    config = colors + wm-bar + default-modules;

    script = ''
      polybar vm &
    '';
  };
}
