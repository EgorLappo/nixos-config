{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    font-awesome # awesome fonts
    material-design-icons # fonts with glyphs
    xfce.orage # lightweight calendar
  ];

  services.polybar = {
    enable = true;

    script = ''
      polybar example --reload &
    '';
  };
}
