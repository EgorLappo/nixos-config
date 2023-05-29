{ config, lib, pkgs, stdenv, ... }:

let
  username = "egor";
  homeDirectory = "/home/${username}";
  configHome = "${homeDirectory}/.config";

  defaultPkgs = with pkgs; [
    any-nix-shell # fish support for nix shell
    bottom # alternative to htop & ytop
    calibre # e-book reader
    dconf2nix # dconf (gnome) files to nix converter
    dig # dns command-line tool
    docker-compose # docker manager
    drawio # diagram design
    duf # disk usage/free utility
    exa # a better `ls`
    fd # "find" for files
    glow # terminal markdown viewer
    jmtpfs # mount mtp devices
    killall # kill processes by name
    lnav # log file navigator on the terminal
    multilockscreen # fast lockscreen based on i3lock
    ncdu # disk space info (a better du)
    nitch # minimal system information fetch
    nix-index # locate packages containing certain nixpkgs
    nix-output-monitor # nom: monitor nix commands
    ouch # painless compression and decompression for your terminal
    pavucontrol # pulseaudio volume control
    paprefs # pulseaudio preferences
    pasystray # pulseaudio systray
    playerctl # music player controller
    prettyping # a nicer ping
    pulsemixer # pulseaudio mixer
    ranger # terminal file explorer
    ripgrep # fast grep
    simple-scan # scanner gui
    tdesktop # telegram messaging client
    tldr # summary of a man page
    tree # display files in a tree view
    vlc # media player
    xsel # clipboard support (also for neovim)


    # haskell packages
    haskellPackages.nix-tree # visualize nix dependencies
  ];
in
{
  programs.home-manager.enable = true;

  imports = builtins.concatMap import [
    ./programs
    ./services
    ./themes
  ];

  xdg = {
    inherit configHome;
    enable = true;
  };

  home = {
    inherit username homeDirectory;
    stateVersion = "22.11";

    packages = defaultPkgs;

    sessionVariables = {
      EDITOR = "nvim";
    };
  };

  # restart services on change
  systemd.user.startServices = "sd-switch";

  # notifications about home-manager news
  news.display = "silent";
}
