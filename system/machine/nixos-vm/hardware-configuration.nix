{ pkgs, ... }:

{
  fileSystems."/boot/efi" =
    {
      device = "/dev/disk/by-uuid/C1F9-0E15";
      fsType = "vfat";
    };

  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/a2135e99-fd56-47e4-8409-91a4bed4a381";
      fsType = "ext4";
    };
}
