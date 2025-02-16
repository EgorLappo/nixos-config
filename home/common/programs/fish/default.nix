{ config, pkgs, lib, ... }:

let
  fzfConfig = ''
    set -x FZF_DEFAULT_OPTS "--preview='bat {} --color=always'" \n
    set -x SKIM_DEFAULT_COMMAND "rg --files || fd || find ."
  '';

  themeConfig = ''
    set -g hydro_fetch true
  '';

  # custom = pkgs.callPackage ./plugins.nix { };

  fishConfig = ''
    bind \t accept-autosuggestion
    set fish_greeting
  '' + fzfConfig + themeConfig;

  myPlugins = with pkgs.fishPlugins; [
    { name = "foreign-env"; src = foreign-env.src; }
    { name = "z"; src = z.src; }
    { name = "fzf-fish"; src = fzf-fish.src; }
    { name = "hydro-theme"; src = pkgs.fishPlugins.hydro; }
  ];
in
{
  programs.fish = {
    enable = true;
    plugins = myPlugins;
    interactiveShellInit = ''
      eval (direnv hook fish)
      any-nix-shell fish --info-right | source
    '';
    shellAliases = {
      c = "clear";
      cat = "bat --theme=base16";
      bat = "bat --theme=brease16";
      erd = "erd -H -I -L 3";
      v = "nvim";
      nswitch = "sudo nixos-rebuild switch --flake ~/.dotfiles#$MACHINE";
      # hswitch = "home-manager switch --flake ~/.dotfiles";

      du = "${pkgs.ncdu}/bin/ncdu --color dark -rr -x";
      ls = "${pkgs.eza}/bin/eza";
      ll = "ls -a";
      ".." = "cd ..";
      ping = "${pkgs.prettyping}/bin/prettyping";
      tree = "${pkgs.exa}/bin/exa -T";
      xdg-open = "${pkgs.mimeo}/bin/mimeo";
    };
    shellInit = fishConfig;
  };
}
