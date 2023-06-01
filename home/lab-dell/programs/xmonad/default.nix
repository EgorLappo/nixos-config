{ pkgs, lib, specialArgs, ... }:
let
  wallpaper = ''
    ${pkgs.nitrogen}/bin/nitrogen --restore &
  '';
in
{
  xresources.properties = {
    "Xft.autohint" = 0;
    "Xft.hintstyle" = "hintfull";
    "Xft.hinting" = 1;
    "Xft.antialias" = 1;
    "Xft.rgba" = "rgb";
    "Xcursor*theme" = "Vanilla-DMZ-AA";
    "Xcursor*size" = 24;
  };

  home.packages = with pkgs; [
    xcape # keymaps modifier
    xorg.xkbcomp # keymaps modifier
    xorg.xmodmap # keymaps modifier
    xorg.xrandr # display manager (X Resize and Rotate protocol)
  ];

  xsession = {
    enable = true;

    initExtra = wallpaper;

    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      extraPackages = hp: [
        hp.dbus
        hp.monad-logger
        hp.xmonad-contrib
      ];
      config = ./config.hs;
    };
  };
}
