{ config, pkgs, ... }:

let 
  unstablePkgs = import <nixos-unstable> { config = { allowUnfree = true; }; };
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

  home.packages = with unstablePkgs; [
    # Terminal
    wezterm
    starship
    ripgrep
    jq
    httpie
    fzf
    fd
    direnv
    delta
    bat
    any-nix-shell 

    # Web
    librewolf
    ungoogled-chromium

    # Communication
    tdesktop
    slack
    pkgs.zoom-us

    # Development
    gh
    jetbrains.idea-community
    mongodb-compass
    pkgs.dbeaver
    pkgs.awscli2
    sublime4
    insomnia
    visualvm

    # Media
    vlc
    spotify
    cider
    ffmpeg

    # Games
    lutris
    # python310Packages.ds4drv
    (sunshine.override {
      cudaSupport = true;
    })

    # Desktop
    gimp
    obs-studio
    barrier

    # Tools
    bitwarden
    mkcert
    obsidian
  ];

  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      #vscodevim.vim
      yzhang.markdown-all-in-one
    ];
  };

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
