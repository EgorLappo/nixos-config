{ pkgs, ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      selection.save_to_clipboard = true;


      font = {
        normal.family = "Fantasque Sans Mono";
        size = 11;
      };

      window = {
        decorations = "none";
        opacity = 0.85;
        padding = {
          x = 5;
          y = 5;
        };
      };
    };
  };
}
