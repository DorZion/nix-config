{ lib, pkgs, ... }:
{
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      gtk-theme = "Adwaita-dark";
      cursor-theme = "Adwaita";
      font-name = "Noto Sans,  10";
    };
  };
}

