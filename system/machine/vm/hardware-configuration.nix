{ pkgs, ... }:

{
  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/CB80-D79C";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/3e57a6e8-181e-4e9d-892b-8259cdf05665";
      fsType = "ext4";
    };
}
