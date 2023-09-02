{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    gnomeExtensions.settingscenter
    gnomeExtensions.user-themes
    gnomeExtensions.gsconnect
    gnomeExtensions.appindicator
    dconf2nix
    gnome.nautilus
    gnome.epiphany
    gnome.zenity
  ];

  services.gnome-keyring.enable = true;
}
