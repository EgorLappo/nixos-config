{ config, lib, pkgs, ... }:

{
  programs.dconf.enable = true;

  services = {
    upower.enable = true;

    dbus = {
      enable = true;
      packages = [ pkgs.dconf ];
    };

    xserver = {
      enable = true;

      layout = "us";

      libinput = {
        enable = true;
        touchpad.disableWhileTyping = true;
      };

      displayManager = {
        lightdm.background = ../../imgs/lock.jpg;

        lightdm.greeters.mini = {
          enable = true;
          user = "egor";
          extraConfig = ''
            [greeter]
            show-password-label = false

            [greeter-theme]
            background-color = "#1A1B26"
            background-image-size = cover
            window-color = "#A9B1D6"
          '';
        };

        defaultSession = "none+xmonad";
      };

      windowManager.xmonad = {
        enable = true;
        enableContribAndExtras = true;
      };
    };
  };
}
