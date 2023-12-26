{ config, pkgs, ... }:

{
  programs.xwayland.enable = true;
  security.polkit.enable = true;

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    wlr = {
      enable = true;
    };

    # gtk portal needed to make gtk apps happy
    extraPortals = [ 
      pkgs.xdg-desktop-portal-gtk 
    ];

    config.common.default = "*";
  };

  environment.systemPackages = with pkgs; [
    xdg-utils
    glib
    dracula-theme
    gnome3.adwaita-icon-theme
    wl-clipboard
    wdisplays
  ];

  security.pam.services."swaylock" = {
    text = ''
      auth include login
    '';
  };

  services.greetd = {
    enable = true;
    settings = {
     default_session.command = ''
      ${pkgs.greetd.tuigreet}/bin/tuigreet \
        --time \
        --asterisks \
        --user-menu \
        --cmd sway
    '';
    };
  };

  environment.etc."greetd/environments".text = ''
    sway
  '';

  environment.etc."start-sway" = {
    mode = "0555";
    text = ''
      dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway XDG_SESSION_TYPE=wayland
      dbus-run-session -- sway
    '';
  };
}
