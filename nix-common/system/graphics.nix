{ config, ... }:

{ 
  hardware.opengl.enable = true;
  hardware.opengl.driSupport = true;

  # Support OpenGL 32-bit programs such as Wine
  hardware.opengl.driSupport32Bit = true;

  # Enable NVIDIA drivers for X11
  services.xserver.videoDrivers = [ "nvidia" ];
  
  # Enable NVIDIA for Wayland
  # hardware.nvidia.modesetting.enable = true;
  # programs.xwayland.enable = true;
}
