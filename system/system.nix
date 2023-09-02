{ config, lib, pkgs, ... }:

{
  imports = [
    ./sound.nix
    ./graphics.nix
    ./xserver.nix
    ./virtualization.nix
  ];

  # Kernel
  #boot.kernelPackages = unstablePkgs.linuxPackages;
  boot.kernelPackages = pkgs.linuxPackages_xanmod;
  boot.kernelParams = [ "clearcpuid=514" ];
  #boot.kernelPackages = unstablePkgs.linuxPackages_latest;

  nix.settings.trusted-users = [ "root" "@wheel" ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim_configurable
    git
    gnupg
    python3
    wget
    htop
    gnome.adwaita-icon-theme
    gnome-themes-extra
    gnome3.gnome-tweaks
    gparted
  ];

  environment.variables = {
    EDITOR = "vim";
    VISUAL = "vim";
    #NIX_LD_LIBRARY_PATH = lib.makeLibraryPath [
    #  pkgs.stdenv.cc.cc
    #  pkgs.openssl
    #  pkgs.zlib
    #  pkgs.gobject-introspection
    #];
    #NIX_LD = lib.fileContents "${pkgs.stdenv.cc}/nix-support/dynamic-linker";
  };

  environment.gnome.excludePackages= (with pkgs; [
    gnome-photos
    gnome-tour
  ]) ++ (with pkgs.gnome; [
    cheese # webcam tool
    gnome-music
    gnome-terminal
    gedit # text editor
    epiphany # web browser
    geary # email reader
    evince # document viewer
    gnome-characters
    totem # video player
    tali # poker game
    iagno # go game
    hitori # sudoku game
    atomix # puzzle game
  ]); 

  networking.hostName = "dor-workstation"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Jerusalem";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_IL";

  # Manage Gnome via Nix
  #services.dbus.packages = [ pkgs.dconf ];
  #services.udev.packages = [ pkgs.gnome3.gnome-settings-daemon ];
  programs.dconf.enable = true;

  # Emulates macOS
  programs.darling.enable = true;

  # Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.package = pkgs.bluezFull;
  services.blueman.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  programs.nix-ld.enable = true;

  # GnuPG
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryFlavor = "gnome3";
  };
  services.pcscd.enable = true;
  services.gnome.gnome-online-accounts.enable = lib.mkForce false;
  services.gnome.gnome-keyring.enable = lib.mkForce false;
  programs.seahorse.enable = lib.mkForce false;

  # Add local domain to the trusted CA store
  security.pki.certificates = [
    ''
      *.nuc.lan
      =========
      -----BEGIN CERTIFICATE-----
      MIIEkjCCAvqgAwIBAgIRAOSJxcvdwY96+AbWDhk4v10wDQYJKoZIhvcNAQELBQAw
      YTEeMBwGA1UEChMVbWtjZXJ0IGRldmVsb3BtZW50IENBMRswGQYDVQQLDBJkb3JA
      bnVjIChEb3IgWmlvbikxIjAgBgNVBAMMGW1rY2VydCBkb3JAbnVjIChEb3IgWmlv
      bikwHhcNMjIxMDI5MTUxNjAyWhcNMzIxMDI5MTUxNjAyWjBhMR4wHAYDVQQKExVt
      a2NlcnQgZGV2ZWxvcG1lbnQgQ0ExGzAZBgNVBAsMEmRvckBudWMgKERvciBaaW9u
      KTEiMCAGA1UEAwwZbWtjZXJ0IGRvckBudWMgKERvciBaaW9uKTCCAaIwDQYJKoZI
      hvcNAQEBBQADggGPADCCAYoCggGBAL8VJQpXFPLvG5dPgfYHWlU6Ja3HR6muF420
      M0mSAEpAvspa6aGOtKFPBvC+AWGHqzGnIiMEtoamVMXe8z2k+oHWsa3h43SJMnWh
      sQO1oR/56Ra2CHuwHcNZZCyG6YSKCwinMkb4Z/JuT7eC01qeG5lNV6nPmYIM/9ux
      ergKOtvacBXmBv4q4lcsb7JkLnaomfdCaX5OVxi9S1eMF24doAoRW6dABQ2mRj+R
      8bzMoQVbD+R6LGHYQeij8rdZTEwi7l+RZmRY/W6N5oX1KXrsC5tqmWrV5u5Lu/TR
      j9GMh0yJtnmLYAPixjsIL0+ZayJ/DEEzBC/psRqUkrZHXMSayQ1WtOnL++fR5EIT
      y400DchXLk0rCOG7HJwzOos/ZfDoTpFtRisdNE4PQkTrGmwgX0zDDhKByOgYNb9T
      hAWaUp5yP4cC0jcWXBQO7Ik1/uQFH7zCQ/JKpmLaOiUhEZACrzf5hJzzuIxaEo+7
      1uDLRVqELiOyiZGwem+QylVovinC3wIDAQABo0UwQzAOBgNVHQ8BAf8EBAMCAgQw
      EgYDVR0TAQH/BAgwBgEB/wIBADAdBgNVHQ4EFgQUvW6KUlDrHikNLc+Am1gfP43G
      w+gwDQYJKoZIhvcNAQELBQADggGBAEsExY+FP+XT+yZq6uKVkCX1elTNK42bSlEh
      fiio3pPgBNXWu6M1dFJXVytl6uIlPRKM1EMZK0c/cQZXbHLVBgTga99UcmTmtUJO
      8BkrH64jB3NciH/Jq9SLN14pqVXqs5IksSpexI0q+OpBzgeg3CmxljnQtO4CNlri
      gPCyRwSrgIUv9zUvhH4R+ZJMhuq028KibH8zLb/2YoQUP9u/zP/IL0g8OjQNBbHn
      iry2hPs2Xrx56X5AmMOkek0MBy7ddeiBoCd7utAJBpX+XACbQXW+WRNcXgpmu421
      /jM6C7jR8Fm+6e1yRsI5cC8QOgAUOHQb9zW/PgaZ5hPW97Z9C2RiPL6O17FElcJs
      rE44Gljw5dmE9Pm6zw3ybhT5gVpKCF7+RsaEeyE1uoQlUo/Ds/Mu8T+0n6G1iZDM
      oy8xeNkxeUSlFJJ57K0d8PfOTZE6nKVS3bnFj0kMbqGDUCeg79FtjERcT+kii41t
      7dwhf6rdBeI9Z77y7qNk7XIxhScpJg==
      -----END CERTIFICATE-----
    ''
  ];
}
