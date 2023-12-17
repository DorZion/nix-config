{ config, pkgs, ... }:
{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.dor = {
    isNormalUser = true;
    description = "Dor";
    extraGroups = [ "networkmanager" "wheel" "video" ];
    shell = pkgs.fish;
    packages = with pkgs; [
      fish
    ];
  };

  programs.fish.enable = true;
  programs.noisetorch.enable = true;
  programs.steam.enable = true;
  hardware.steam-hardware.enable = true;
  programs.gamemode.enable = true;
  services.unclutter.enable = true;

  # Enable Controllers
  services.udev.extraRules = ''
    # Sony PlayStation Strikepack; USB
    KERNEL=="hidraw*", ATTRS{idVendor}=="054c", ATTRS{idProduct}=="05c5", MODE="0660", TAG+="uaccess"
    
    # Sony PlayStation DualShock 3; bluetooth; USB
    KERNEL=="hidraw*", KERNELS=="*054C:0268*", MODE="0660", TAG+="uaccess"
    KERNEL=="hidraw*", ATTRS{idVendor}=="054c", ATTRS{idProduct}=="0268", MODE="0660", TAG+="uaccess"
    ## Motion Sensors
    SUBSYSTEM=="input", KERNEL=="event*|input*", KERNELS=="*054C:0268*", TAG+="uaccess"

    # Sony PlayStation DualShock 4; bluetooth; USB
    KERNEL=="hidraw*", KERNELS=="*054C:05C4*", MODE="0660", TAG+="uaccess"
    KERNEL=="hidraw*", ATTRS{idVendor}=="054c", ATTRS{idProduct}=="05c4", MODE="0660", TAG+="uaccess"

    # Sony PlayStation DualShock 4 Slim; bluetooth; USB
    KERNEL=="hidraw*", KERNELS=="*054C:09CC*", MODE="0660", TAG+="uaccess"
    KERNEL=="hidraw*", ATTRS{idVendor}=="054c", ATTRS{idProduct}=="09cc", MODE="0660", TAG+="uaccess"

    # Sony PlayStation DualShock 4 Wireless Adapter; USB
    KERNEL=="hidraw*", ATTRS{idVendor}=="054c", ATTRS{idProduct}=="0ba0", MODE="0660", TAG+="uaccess"

    # Sony DualSense Wireless-Controller; bluetooth; USB
    KERNEL=="hidraw*", KERNELS=="*054C:0CE6*", MODE="0660", TAG+="uaccess"
    KERNEL=="hidraw*", ATTRS{idVendor}=="054c", ATTRS{idProduct}=="0ce6", MODE="0660", TAG+="uaccess"
  '';

  # Disable DS4 Touchpad
  services.xserver.extraConfig = ''
    Section "InputClass"
      Identifier   "ds-touchpad"
      Driver       "libinput"
      MatchProduct "Wireless Controller Touchpad"
      Option       "Ignore" "True"
    EndSection
  '';
}
