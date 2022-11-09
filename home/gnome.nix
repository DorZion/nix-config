{ config, pkgs, ... }:

let 
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in {
  home.packages = [
    pkgs.gnomeExtensions.settingscenter
    pkgs.gnomeExtensions.user-themes
    pkgs.gnomeExtensions.tray-icons-reloaded
    unstable.dconf2nix
    unstable.gnome.nautilus
  ];
}
