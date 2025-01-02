{ config, pkgs, ... }:

{
  programs.xwayland.enable = true;
  security.polkit.enable = true;

  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
          Type = "simple";
          ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
          Restart = "on-failure";
          RestartSec = 1;
          TimeoutStopSec = 10;
        };
    };
  };

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
    libportal
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

  systemd.services.greetd.serviceConfig = {
    Type = "idle";
    StandardInput = "tty";
    StandardOutput = "tty";

    # Without these, errors will spam on screen
    StandardError = "journal"; 
    TTYReset = true;
    TTYHangup = true;
    TTYDisallocate = true;
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
