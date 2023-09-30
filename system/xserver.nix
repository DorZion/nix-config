{ config, pkgs, ... }:

{
  # Configure keymap in X11
  services.xserver = {
    layout = "us";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  services.xserver.desktopManager.plasma5.runUsingSystemd = false;
}
