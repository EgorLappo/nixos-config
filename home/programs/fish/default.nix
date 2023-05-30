{ config, pkgs, lib, ... }:

let
  fzfConfig = ''
    set -x FZF_DEFAULT_OPTS "--preview='bat {} --color=always'" \n
    set -x SKIM_DEFAULT_COMMAND "rg --files || fd || find ."
  '';

  themeConfig = ''
    set -g hydro_fetch true
  '';

  tokyoNightColors = ''
    set -g  fish_color_normal c0caf5
    set -g  fish_color_command 7dcfff
    set -g  fish_color_keyword bb9af7
    set -g  fish_color_quote e0af68
    set -g  fish_color_redirection c0caf5
    set -g  fish_color_end ff9e64
    set -g  fish_color_error f7768e
    set -g  fish_color_param 9d7cd8
    set -g  fish_color_comment 565f89
    set -g  fish_color_selection --background=283457
    set -g  fish_color_search_match --background=283457
    set -g  fish_color_operator 9ece6a
    set -g  fish_color_escape bb9af7
    set -g  fish_color_autosuggestion 565f89

    set -g  fish_pager_color_progress 565f89
    set -g  fish_pager_color_prefix 7dcfff
    set -g  fish_pager_color_completion c0caf5
    set -g  fish_pager_color_description 565f89
    set -g  fish_pager_color_selected_background --background=283457
  '';

  custom = pkgs.callPackage ./plugins.nix { };

  fishConfig = ''
    bind \t accept-autosuggestion
    set fish_greeting
  '' + fzfConfig + themeConfig + tokyoNightColors;

  myPlugins = with pkgs.fishPlugins; [
    { name = "foreign-env"; src = foreign-env.src; }
    { name = "z"; src = z.src; }
    { name = "fzf-fish"; src = fzf-fish.src; }
  ];
in
{
  programs.fish = {
    enable = true;
    plugins = [ custom.theme ] ++ myPlugins;
    interactiveShellInit = ''
      eval (direnv hook fish)
      any-nix-shell fish --info-right | source
    '';
    shellAliases = {
      c = "clear";
      cat = "bat --theme=base16";
      bat = "bat --theme=brease16";
      v = "nvim";
      nswitch = "sudo nixos-rebuild switch --flake ~/.dotfiles#nixos-vm";
      hswitch = "home-manager switch --flake ~/.dotfiles";

      du = "${pkgs.ncdu}/bin/ncdu --color dark -rr -x";
      ls = "${pkgs.exa}/bin/exa";
      ll = "ls -a";
      ".." = "cd ..";
      ping = "${pkgs.prettyping}/bin/prettyping";
      tree = "${pkgs.exa}/bin/exa -T";
      xdg-open = "${pkgs.mimeo}/bin/mimeo";
    };
    shellInit = fishConfig;
  };

  xdg.configFile."fish/completions/keytool.fish".text = custom.completions.keytool;
}
