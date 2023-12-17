{ config, pkgs, ... }:
{
  imports = [
#    ./dconf.nix
#    ./i3.nix
#    ./dnust.nix
  ];

  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
#    output = {
#      "Virtual-1" = {
#        mode = "1920x1080@144Hz";
#      };
#    };
  }; 

  home.packages = with pkgs; [
  ];

  services.gammastep = {
    enable = true;
    tray = true;
    latitude = 31.68;
    longitude = 34.95;
    temperature.night = 3200;
  };
}

