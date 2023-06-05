{ config, pkgs, ... }:

{
  imports = [
    # Hardware scan
    ./hardware-configuration.nix
  ];

  # Use the GRUB 2 boot loader.
  boot = {
    initrd.availableKernelModules = [ "nvme" "xhci_pci" "usbhid" "sr_mod" ];
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      systemd-boot.enable = true;
      systemd-boot.configurationLimit = 5;
      efi.canTouchEfiVariables = true;
      efi.efiSysMountPoint = "/boot/efi";
    };
  };

  networking = {
    hostName = "nixos-vm";
  };

  # fileSystems."/data" = {
  #   device = "/dev/nvme0n1p3";
  #   fsType = "ext4";
  # };

  services.xserver = {
    xrandrHeads = [
      {
        output = "Virtual-1";
        primary = true;
        monitorConfig = ''
          Option "PreferredMode" "2560x1600"
          Option "Position" "0 0"
        '';
      }

    ];
    resolutions = [
      { x = 2560; y = 1600; }
    ];
  };
}
