{ config, pkgs, ... }:
let
  # tokyonight colors
  colors = builtins.readFile ./colors.ini;

  lab-bar = builtins.readFile ./lab_config.ini;

  default-modules = builtins.readFile ./default_modules.ini;

  other-modules = ''
    [module/xmonad]
    type = custom/script
    exec = ${pkgs.xmonad-log}/bin/xmonad-log
    tail = true
  '';

  mypolybar = pkgs.polybar.override {
    alsaSupport = true;
    githubSupport = true;
    mpdSupport = true;
    pulseSupport = true;
  };
in
{
  home.packages = with pkgs; [
    font-awesome # awesome fonts
    material-design-icons # fonts with glyphs
  ];

  services.polybar = {
    enable = true;
    package = mypolybar;
    config = ./config.ini;

    extraConfig = colors + vm-bar + default-modules;

    script = ''
      polybar lab &
    '';
  };
}
