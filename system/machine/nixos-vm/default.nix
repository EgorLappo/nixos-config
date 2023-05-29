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

  # services.xserver = {
  #   xrandrHeads = [
  #     {
  #       output = "HDMI-1";
  #       primary = true;
  #       monitorConfig = ''
  #         Option "PreferredMode" "3840x2160"
  #         Option "Position" "0 0"
  #       '';
  #     }
  #     {
  #       output = "eDP-1";
  #       monitorConfig = ''
  #         Option "PreferredMode" "3840x2160"
  #         Option "Position" "0 0"
  #       '';
  #     }
  #   ];
  #   resolutions = [
  #     { x = 2048; y = 1152; }
  #     { x = 1920; y = 1080; }
  #     { x = 2560; y = 1440; }
  #     { x = 3072; y = 1728; }
  #     { x = 3840; y = 2160; }
  #   ];
  # };
}
