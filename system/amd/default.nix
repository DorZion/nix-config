{ config, pkgs, ... }:

{
  boot.initrd.kernelModules = [ "amdgpu" ]; 

  hardware.opengl.enable = true;
  hardware.opengl.driSupport = true;

  # Support OpenGL 32-bit programs such as Wine
  hardware.opengl.driSupport32Bit = true;
  hardware.opengl.extraPackages = with pkgs; [
    #amdvlk
    vaapiVdpau
    libvdpau-va-gl
  ];

  environment.systemPackages = with pkgs; [
     vulkan-tools
     corectrl
  ];
}
