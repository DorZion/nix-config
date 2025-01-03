{ config, pkgs, pkgs-master, ... }:
{
  imports = [
    ./vim.nix
    ./wayland
    ./services
    #./kde
    #./gnome
  ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "dor";
  home.homeDirectory = "/home/dor";

  dconf.enable = true;

  #programs.fzf.enable = true;
  #programs.fzf.enableFishIntegration = false;

  home.packages = with pkgs; [
    # Terminal
    wezterm
    starship
    ripgrep
    gron
    jq
    httpie
    fd
    direnv
    delta
    bat
    btop
    fx
    any-nix-shell 
    mongosh
    neofetch
    pdftk
    binutils
    mise

    # Web
    librewolf
    ungoogled-chromium

    # Communication
    tdesktop
    whatsapp-for-linux
    slack
    zoom-us

    # Development
    gh
    jetbrains.idea-community
    mongodb-compass
    mongodb-tools
    dbeaver
    awscli2
    sublime4
    insomnia
    visualvm
    geany

    # Media
    vlc
    spotify
    cider
    ffmpeg

    # Games
    wineWowPackages.stagingFull
    lutris
    pkgs-master.sunshine

    # Desktop
    gimp
    obs-studio
    barrier
    pkgs-master.input-leap
    evolution
    libreoffice
    upscayl
    simplescreenrecorder
    gnome.nautilus
    flameshot
    freetube
    uxplay
    okular

    # Tools
    bitwarden
    mkcert
    obsidian
    aws-vault
    gnome.zenity
    #(callPackage ../aws-client-vpn/default.nix {
    #  openvpn = callPackage ../aws-client-vpn/openvpn.nix { };
    #})
    dmg2img
    visualvm
    gucharmap
    libimobiledevice
    ifuse
    anydesk
  ];

  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      #vscodevim.vim
      yzhang.markdown-all-in-one
    ];
  };

  programs.autorandr.enable = false;
  programs.autorandr.profiles = {
    "home" = {
      fingerprint = {
        DP-0 = "00ffffffffffff000469a424010101010e190104a5351e783a9de5a654549f260d5054b7ef00714f8180814081c081009500b3000101023a801871382d40582c4500132b2100001e000000fd0032961ea021000a202020202020000000fc0056473234380a20202020202020000000ff0046334c4d51533133313034350a01d0020318f14b900504030201111213141f2309070783010000023a801871382d40582c4500132b2100001e8a4d80a070382c4030203500132b2100001afe5b80a07038354030203500132b2100001a866f80a07038404030203500132b2100001afc7e80887038124018203500132b2100001e0000000000000000000000000073";
      };
      config = {
        DP-0 = {
          enable = true;
          primary = true;
          mode = "1920x1080";
          rate = "144.00";
        };
      };
    };
  };
  services.autorandr.enable = false;

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
