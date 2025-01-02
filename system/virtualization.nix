{ pkgs, ... }:
{
  virtualisation = {
    podman = {
      enable = true;

      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;
    };

    libvirtd = {
      enable = true;
      extraConfig = ''
        unix_sock_group = "libvirtd"
        unix_sock_rw_perms = "0770"
      '';
      hooks.qemu = {
        win10-gpu = "/etc/win10-gpu";
       # = {
       #   source = ./win10-gpu;
       #   mode = "0555";
       # };
      };
    };
  };

  programs.virt-manager.enable = true;

  environment.etc."win10-gpu" = {
    source = ./win10-gpu;
    mode = "0555";
  };

  environment.etc."vfio-startup" = {
    source = ./vfio-startup;
    mode = "0555";
  };

  environment.etc."vfio-teardown" = {
    source = ./vfio-teardown;
    mode = "0555";
  };
}
