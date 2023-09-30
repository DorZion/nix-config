{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    i3-gaps
    picom
    feh
    rofi
    xborders
  ];

  systemd.user.services = {
    i3-session = {
      Unit = {
        Description = "i3 window manager session";
        PartOf = "i3-session-target.target";
        Wants = "i3-session-target.target";
      };
      Service = {
        Type = "oneshot";
        RemainAfterExit = "yes";
        ExecStart = "/run/current-system/sw/bin/true";
      };
    };
  };

  systemd.user.targets = {
    i3-session-target = {
      Unit = {
        Description = "i3 Session";
        Requires = "basic.target";
        BindsTo = "graphical-session.target";
        Before = "graphical-session.target";
        DefaultDependencies = "no";
        RefuseManualStart = "yes";
        RefuseManualStop = "yes";
        StopWhenUnneeded = "yes";
      };
    };
  };

  home.file.".config/plasma-workspace/env/wm.sh".text = ''
    #!/bin/sh
    export KDEWM=${pkgs.i3-gaps}/bin/i3
  '';
  home.file.".config/plasma-workspace/env/wm.sh".executable = true;

  home.file.".config/i3/config".source = ./i3config;
  home.file.".config/i3/config".executable = true;
  home.file.".config/i3/bg.jpg".source = ./bg.jpg;

  home.file.".config/picom/picom.conf".source = ./picom.conf;

  services.polybar = {
    enable = true;
    package = pkgs.polybar.override {
      i3Support = true;
    };
    script = "polybar &";
  };
  systemd.user.services.polybar = { Install.WantedBy = [ "graphical-session.target" ]; };

  programs.plasma = {
    configFile."startkderc"."General"."systemdBoot" = false;
    configFile."plasma-localerc"."Formats"."LANG" = "en_US.UTF-8";
  };

  services.gammastep = {
    enable = true;
    tray = true;
    latitude = 31.68;
    longitude = 34.95;
    temperature.night = 3200;
  };
}

