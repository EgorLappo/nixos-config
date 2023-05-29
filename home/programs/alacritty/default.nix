{ pkgs, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      selection.save_to_clipboard = true;
      shell.program = "${pkgs.fish}/bin/fish";
    };
  };
}
