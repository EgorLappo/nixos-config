let
  more = { 
    services = {
      unclutter.enable = true;

      gnome-keyring = {
        enable = true;
	components = ["pkcs" "secrets" "ssh" ];
      };
    };
  };
in
[
  ./dunst
  ./picom
  ./screenlock
  ./udiskie
]
