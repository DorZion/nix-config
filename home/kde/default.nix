{ config, pkgs, ... }:
{
  imports = [
    ./dconf.nix
    ./i3.nix
    ./dnust.nix
  ];

  home.packages = with pkgs; [
    whitesur-kde
    kwalletcli
  ];
}

