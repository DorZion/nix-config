{ config, pkgs, ... }:
{
  imports = [
    ./dconf.nix
  ];

  home.packages = with pkgs; [
    libsForQt5.bismuth
  ];
}
