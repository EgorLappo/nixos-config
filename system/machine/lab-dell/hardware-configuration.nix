{ pkgs, ... }:

{
  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/32D6-4524";
      fsType = "vfat";
    };

  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/dad840af-8162-46fd-ba43-5398b7965f95";
      fsType = "ext4";
    };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
