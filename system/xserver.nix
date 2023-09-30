{ config, pkgs, ... }:

{
  # Configure keymap in X11
  services.xserver = {
    layout = "us";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable Desktop Environment.
  #services.xserver.displayManager.gdm.enable = true;
  #services.xserver.displayManager.gdm.wayland = false;
  #services.xserver.desktopManager.gnome.enable = true;
  #services.xserver.desktopManager.budgie.enable = false;
  #services.xserver.desktopManager.deepin.enable = false;
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.displayManager.sessionCommands = "export KDEWM=${pkgs.i3-gaps}/bin/i3";
  services.xserver.desktopManager.plasma5.enable = true;
  services.xserver.desktopManager.plasma5.runUsingSystemd = false;
}
