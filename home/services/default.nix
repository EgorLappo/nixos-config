let
  more = {
    services = {
      flameshot.enable = true;
    };
  };
in
[
  ./dunst
  ./networkmanager
  ./picom
  ./polybar
  ./screenlocker
  ./udiskie
  more
]
