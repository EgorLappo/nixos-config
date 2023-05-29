{ pkgs, ... }:

{
  fileSystems."/boot/efi" =
    {
      device = "/dev/disk/by-uuid/88B0-4332";
      fsType = "vfat";
    };

  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/7c68ba08-6f10-4aba-8ced-7fa34105d756";
      fsType = "ext4";
    };
}
