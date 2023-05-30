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

      extraLayouts.us-custom = {
        description = "US layout with custom hyper keys";
        languages = [ "eng" ];
        symbolsFile = ./us-custom.xkb;
      };

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

  hardware.bluetooth = {
    enable = true;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
      };
    };
  };

  services.blueman.enable = true;

  systemd.services.upower.enable = true;
}
