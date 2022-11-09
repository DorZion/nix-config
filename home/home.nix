{ config, ... }:

let 
  pkgs = import <nixos-unstable> { config = { allowUnfree = true; }; };
in {

  imports = [
    ./dconf.nix
    ./vim.nix
    ./gnome.nix
  ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "dor";
  home.homeDirectory = "/home/dor";

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    # Terminal
    wezterm
    starship
    ripgrep
    jq
    httpie
    fzf
    direnv
    delta

    # Web
    librewolf
    ungoogled-chromium

    # Communication
    slack
    zoom-us

    # Development
    gh
    jetbrains.idea-community
    mongodb-compass
    awscli2

    # Media
    vlc
    spotify

    # Tools
    bitwarden
    mkcert
  ];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
