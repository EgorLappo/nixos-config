{ pkgs, ... }:

{
  fileSystems."/boot/efi" =
    {
      device = "/dev/disk/by-uuid/9363-8123";
      fsType = "vfat";
    };

  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/edd1b02d-7464-4ee2-97ad-f1fd9af6a30d";
      fsType = "ext4";
    };
}
