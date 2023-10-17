{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    i3-gaps
    picom
    feh
    fribidi
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
      alsaSupport = true;
      pulseSupport = true;
      iwSupport = true;
    };
    script = "polybar --reload main &";
    config = let
      colors = rec {
        background = "#312f2f";
        background-alt = "#3b4354";

        foreground = "#F1FAEE";

        primary = "#08D9D6";
        secondary = "#047672";
        alert = "#ff2e63";
        disabled = "#707880";
      };
    in
    {
      "global/wm" = {
        margin-bottom = 0;
        margin-top = 0;
      };

      "bar/main" = {
        width = "100%";
        height = 38;

        foreground = "${colors.foreground}";
        background = "${colors.background}";

        # underline / overline
        line-size = 2;
        line-color = "${colors.primary}";

        border-size = 0;

        padding = 0;

        module-margin = 1;

        font-0 = "SF Mono:style=Regular:size=13";
        font-1 = "DejaVu Sans:style=Regular:size=13";
        font-2 = "FontAwesome:style=Regular:size=13";

        modules-left = "oslogo xworkspaces xwindow";
        modules-right = "filesystem memory cpu date";
        tray-position = "right";
        cursor-click = "pointer";
        cursor-scroll = "ns-resize";

        enable-ipc = true;
      };

      "module/oslogo" = {
        type = "custom/text";
        #content = " NixOS";
        content = "NixOS";
        content-foreground = "${colors.foreground}";
        content-background = "${colors.background-alt}";
        content-padding = 2;
      };

      "module/xworkspaces" = {
        type = "internal/xworkspaces";
        pin-workspaces = false;
        enable-scroll = false;
        icon-0 = "10;10";
        icon-1 = "1;1";
        icon-2 = "2;2";
        icon-3 = "3;3";
        icon-4 = "4;4";
        icon-5 = "5;5";
        icon-6 = "6;6";
        icon-7 = "7;7";
        icon-8 = "8;8";
        icon-9 = "9;9";
        icon-default = ";";

        format = "<label-state>";

        label-active = "%icon%";
        label-active-foreground = "${colors.primary}";
        label-active-background = "${colors.background-alt}";
        label-active-underline = "${colors.primary}";

        label-occupied = "%icon%";

        label-urgent = "%icon%";
        label-urgent-foreground = "${colors.alert}";

        label-empty = "%icon%";
        label-empty-foreground = "${colors.disabled}";

        label-active-padding = 1;
        label-occupied-padding = 1;
        label-urgent-padding = 1;
        label-empty-padding = 1;
      };

      "module/xwindow" = {
        type = "internal/xwindow";
        label = "%title:0:40:...%";
        format = "<label>";
        format-prefix = "  ";
        format-prefix-foreground = "${colors.primary}";
        label-empty = "NixOS";
      };

      "module/filesystem" = {
        type = "internal/fs";
        interval = 25;
        mount-0 = "/";
        label-mounted = "%{F${colors.primary}}DISK:%{F-} %percentage_used:2%%";
        label-unmounted = "%mountpoint% not mounted";
        label-unmounted-foreground = "${colors.disabled}";
      };

      "module/memory" = {
        type = "internal/memory";
        interval = 2;
        format-prefix = "RAM: ";
        format-prefix-foreground = "${colors.primary}";
        label = "%percentage_used:2%%";
      };

      "module/cpu" = {
        type = "internal/cpu";
        interval = 2;
        format-prefix = "CPU: ";
        format-prefix-foreground = "${colors.primary}";
        label = "%percentage:2%%";
      };

      "module/date" = {
        type = "internal/date";
        interval = 1;
        date = "%Y-%m-%d %H:%M";
        label = "%date%";
        format = "<label>";
        format-prefix = " ";
        format-foreground = "${colors.foreground}";
        format-background = "${colors.background-alt}";
        format-padding = 2;
      };

      "settings" = {
        screenchange-reload = true;
        pseudo-transparency = true;
      };
    };
  };
  systemd.user.services.polybar = { Install.WantedBy = [ "graphical-session.target" ]; };

  programs.plasma = {
    configFile."startkderc"."General"."systemdBoot" = false;
    configFile."plasma-localerc"."Formats"."LANG" = "en_US.utf8";
    configFile."plasma-localerc"."Formats"."LC_TIME" = "";
  };

  programs.rofi = {
    enable = true;
    theme = "gruvbox-dark-hard";
  };

  services.gammastep = {
    enable = true;
    tray = true;
    latitude = 31.68;
    longitude = 34.95;
    temperature.night = 3200;
  };
}

