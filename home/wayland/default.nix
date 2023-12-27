{ lib, config, pkgs, ... }:
{
  imports = [
#    ./dconf.nix
#    ./i3.nix
#    ./dnust.nix
  ];

  wayland.windowManager.sway = {
    enable = true;
    config = rec {
      modifier = "Mod4";
      focus.followMouse = "no";
      output = {
       "DP-1" = {
          mode = "1920x1080@144Hz";
        };
      };
      #https://github.com/swaywm/sway/issues/4323
      #exec_always {
      #  gsettings set $gnome-schema gtk-theme 'theme name'
      #  gsettings set $gnome-schema icon-theme 'icon theme name'
      #  gsettings set $gnome-schema cursor-theme 'cursor theme name'
      #  gsettings set $gnome-schema font-name 'Sans 10'
      #}

      keybindings = let modifier = config.wayland.windowManager.sway.config.modifier; in lib.mkOptionDefault {
        "${modifier}+d" = "exec wofi --show 'drun,run'";
      };
      bars = [
        { 
          fonts = { names = [ "monospace" "FontAwesome" ]; size = 10.000000; };
          command = "${pkgs.sway}/bin/swaybar";
          statusCommand = "env RUST_BACKTRACE=1 ${pkgs.swayrbar}/bin/swayrbar 2> /tmp/swayrbar.log";
          mode = "dock";
          hiddenState = "hide";
          position = "top";
          workspaceButtons = true;
          workspaceNumbers = true;
          trayOutput = "*";
          colors = {
            activeWorkspace = { border = "#333333"; background = "#5f676a"; text = "#ffffff"; };
            background = "#000000";
            bindingMode = { border = "#2f343a"; background = "#900000"; text = "#ffffff"; };
            focusedWorkspace = { border = "#4c7899"; background = "#285577"; text = "#ffffff"; };
            inactiveWorkspace = { border = "#333333"; background = "#222222"; text = "#888888"; };
            separator = "#666666";
            statusline = "#ffffff";
            urgentWorkspace = { border = "#2f343a"; background = "#900000"; text = "#ffffff"; };
          };
        }
      ];
      terminal = "wezterm";
      input."*" = {
        xkb_layout = "us,il";
        xkb_options = "grp:win_space_toggle";
        accel_profile = "flat";
      };

      startup = [
        { command = "sway-audio-idle-inhibit"; }
        { command = "gsettings set org.gnome.desktop.interface gtk-theme 'Dracula'"; always = true; }
        { command = "gsettings set org.gnome.desktop.interface icon-theme 'Adwaita'"; always = true; }
        { command = "gsettings set org.gnome.desktop.interface cursor-theme 'Adwaita'"; always = true; }
        { command = "gsettings set org.gnome.desktop.interface font-name 'DejaVu Sans, 10'"; always = true; }
      ];
    };
    wrapperFeatures.gtk = true;
  }; 

  home.packages = with pkgs; [ 
    swaylock-effects
    swayrbar
    gammastep
    xorg.xrandr
    ranger
    pavucontrol
    sway-audio-idle-inhibit
  ];

  programs.wofi.enable = true;

  services.swayidle = {
    enable = true;
    timeouts = [
      { timeout = 300; command = "${pkgs.swaylock-effects}/bin/swaylock -fF --screenshots --clock --indicator-idle-visible --effect-blur 7x5 --effect-vignette 0.5:0.5 --fade-in 0.2 --grace 5"; }
      { timeout = 600; command = "${pkgs.sway}/bin/swaymsg 'output * power off'"; resumeCommand = "${pkgs.sway}/bin/swaymsg 'output * power on'"; }
    ];
  };

  services.gammastep = {
    enable = true;
    tray = true;
    latitude = 31.68;
    longitude = 34.95;
    temperature.night = 3200;
  };

  services.mako = {
    enable = true;
  };

  home.file.".local/share/bin/inhibit-idle-loop.sh" = {
    executable = true;
    text = ''
      #!${pkgs.bash}/bin/bash

      while true; do
        ${pkgs.coreutils}/bin/sleep 60
        ${pkgs.systemd}/bin/systemd-inhibit --what=idle --who=inhibit-idle --why=commanded --mode=block ${pkgs.coreutils}/bin/sleep 1
      done
    '';
  };
}

