{ config, pkgs, ... }:
{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.dor = {
    isNormalUser = true;
    description = "Dor";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.fish;
    packages = with pkgs; [
      fish
    ];
  };

  programs.fish.enable = true;
  programs.noisetorch.enable = true;
}
