{ pkgs, ... }:
let
  tokyoNightColors = {
    schemes = {
      tokyo-night = {
        primary = {
          background = "#1a1b26";
          foreground = "#a9b1d6";
        };
        normal = {
          black = "#32344a";
          red = "#f7768e";
          green = "#9ece6a";
          yellow = "#e0af68";
          blue = "#7aa2f7";
          magenta = "#ad8ee6";
          cyan = "#449dab";
          white = "#787c99";
        };
        bright = {
          black = "#444b6a";
          red = "#ff7a93";
          green = "#b9f27c";
          yellow = "#ff9e64";
          blue = "#7da6ff";
          magenta = "#bb9af7";
          cyan = "#0db9d7";
          white = "#acb0d0";
        };
      };
    };
  };
in
{
  programs.alacritty = {
    enable = true;
    settings = {
      inherit tokyoNightColors. schemes;
      selection.save_to_clipboard = true;
      shell.program = "${pkgs.fish}/bin/fish";
      colors = "*tokyo-night";
    };
  };
}
