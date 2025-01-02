{ config, pkgs, ... }:

{
  # Bootloader.
  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.supportedFilesystems =  [ "ntfs" ];

  boot.loader.grub = {
    enable = true;
    devices = [ "nodev" ];
    theme = pkgs.nixos-grub2-theme;
    efiSupport = true;
    useOSProber = true;
  };
}
