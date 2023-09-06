{ config, pkgs, ... }:

{
  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
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
  services.xserver.desktopManager.plasma5.enable = true;
  services.xserver.windowManager.i3 = {
    enable = true;
    package = pkgs.i3-gaps;
  };
  services.xserver.windowManager.awesome = {
    enable = false;
    luaModules = with pkgs.luaPackages; [
      luarocks
      luadbi-mysql
    ];
  };
  services.xserver.windowManager.nimdow.enable = false;
}
