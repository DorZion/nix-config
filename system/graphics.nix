{ config, pkgs, ... }:

{ 
  hardware.opengl.enable = true;
  hardware.opengl.driSupport = true;

  # Support OpenGL 32-bit programs such as Wine
  hardware.opengl.driSupport32Bit = true;

  # Enable NVIDIA drivers for X11
  hardware.nvidia.modesetting.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  
  # Set NVIDIA drivers version
  #hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
  #hardware.nvidia.package = pkgs.nur.repos.dorzion.nvidia-patch;
  hardware.nvidia.package = pkgs.callPackage ../nvidia-patch {
    #pkgs.nur.repos.dorzion.nvidia-patch.override {
    nvidia_x11 = config.boot.kernelPackages.nvidiaPackages.stable;
    #nvidia_x11 = pkgs.linuxPackages_xanmod.nvidiaPackages.stable;
  };

  # Enable NVIDIA for Wayland
  # programs.xwayland.enable = true;

  environment.systemPackages = with pkgs; [
    # cudatoolkit
     vulkan-tools
  ];

  environment.variables = {
    # VK_ICD_FILENAMES = "/run/opengl-driver/share/vulkan/icd.d/nvidia_icd.x86_64.json";
    "__GL_SHADER_DISK_CACHE_SKIP_CLEANUP" = "2";
  };
}
