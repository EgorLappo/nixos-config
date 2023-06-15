{ pkgs, ... }:
let settings = {
  theme = "base16_default";
};
in
{
  programs.helix = {
    inherit settings;
  
    enable = true;
  };
}
