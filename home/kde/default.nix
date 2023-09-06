{ config, pkgs, ... }:
{
  imports = [
    ./dconf.nix
  ];

  home.packages = with pkgs; [
    whitesur-kde
    latte-dock
  ];
}

