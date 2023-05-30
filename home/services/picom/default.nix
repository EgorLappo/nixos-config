{
  services.picom = {
    enable = true;
    activeOpacity = 1.0;
    inactiveOpacity = 0.8;
    backend = "glx";
    fade = true;
    opacityRules = [ "100:name *= 'i3lock'" ];
    fadeDelta = 5;
    shadow = true;
    shadowOpacity = 0.75;
    settings = {
      blur =
        {
          method = "dual_kawase";
        };
    };
  };
}
