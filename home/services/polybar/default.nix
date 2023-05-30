{ config, pkgs, ... }:
let
  # tokyonight colors
  colors = builtins.readFile ./colors.ini;

  default-modules = ''
    [module/xworkspaces]
    type = internal/xworkspaces

    label-active = %name%
    label-active-background = ${colors.background-alt}
    label-active-underline= ${colors.primary}
    label-active-padding = 1

    label-occupied = %name%
    label-occupied-padding = 1

    label-urgent = %name%
    label-urgent-background = ${colors.alert}
    label-urgent-padding = 1

    label-empty = %name%
    label-empty-foreground = ${colors.disabled}
    label-empty-padding = 1

    [module/xwindow]
    type = internal/xwindow
    label = %title:0:60:...%

    [module/pulseaudio]
    type = internal/pulseaudio

    format-volume-prefix = "VOL "
    format-volume-prefix-foreground = ${colors.primary}
    format-volume = <label-volume>

    label-volume = %percentage%%

    label-muted = muted
    label-muted-foreground = ${colors.disabled}

    [module/xkeyboard]
    type = internal/xkeyboard
    blacklist-0 = num lock

    label-layout = %layout%
    label-layout-foreground = ${colors.primary}

    label-indicator-padding = 2
    label-indicator-margin = 1
    label-indicator-foreground = ${colors.background}
    label-indicator-background = ${colors.secondary}

    [module/memory]
    type = internal/memory
    interval = 2
    format-prefix = "RAM "
    format-prefix-foreground = ${colors.primary}
    label = %percentage_used:2%%

    [module/cpu]
    type = internal/cpu
    interval = 2
    format-prefix = "CPU "
    format-prefix-foreground = ${colors.primary}
    label = %percentage:2%%

    [module/eth]
    inherit = network-base
    interface-type = wired
    label-connected = %{F#F0C674}%ifname%%{F-} %local_ip%

    [module/date]
    type = internal/date
    interval = 1

    date = %H:%M
    date-alt = %Y-%m-%d %H:%M:%S

    label = %date%
    label-foreground = ${colors.primary}
  '';
in
{
  home.packages = with pkgs; [
    font-awesome # awesome fonts
    material-design-icons # fonts with glyphs
  ];

  services.polybar = {
    enable = true;
    config = ./wm_config.ini;
    extraConfig = colors + default-modules;

    script = ''
      polybar vm &
    '';
  };
}
