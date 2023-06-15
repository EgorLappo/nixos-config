{ pkgs, ... }:
let
  settings = {
    theme = "base16_default";

    editor = {
      line-number = "relative";

      lsp.display-messages = true;

      cursor-shape.insert = "bar";
    };
  };
in
{
  programs.helix = {
    inherit settings;

    enable = true;
  };
}
