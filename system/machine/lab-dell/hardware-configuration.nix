{ pkgs, ... }:

{
  fileSystems."/boot/efi" =
    {
      device = "/dev/disk/by-uuid/3D9D-728F";
      fsType = "vfat";
    };

  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/0c9629f8-b4c8-43b1-a5b8-d08c58c156e1";
      fsType = "ext4";
    };
}
