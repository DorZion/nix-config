# Generated via dconf2nix: https://github.com/gvolpe/dconf2nix
{ lib, pkgs, ... }:

with lib.hm.gvariant;

{
  dconf.enable = true;
  dconf.settings = {
    "org/gnome/desktop/background" = {
      color-shading-type = "solid";
      picture-options = "zoom";
      picture-uri = "file:///run/current-system/sw/share/backgrounds/gnome/blobs-l.svg";
      picture-uri-dark = "file:///run/current-system/sw/share/backgrounds/gnome/blobs-d.svg";
      primary-color = "#241f31";
      secondary-color = "#000000";
    };

    "org/gnome/desktop/input-sources" = {
      sources = [ (mkTuple [ "xkb" "us" ]) (mkTuple [ "xkb" "il" ]) ];
      xkb-options = [ "terminate:ctrl_alt_bksp" ];
    };

    "org/gnome/desktop/interface" = {
      clock-format = "24h";
      clock-show-seconds = true;
      color-scheme = "prefer-dark";
      enable-hot-corners = false;
      font-antialiasing = "grayscale";
      font-hinting = "slight";
      gtk-theme = "Adwaita-dark";
    };

    "org/gnome/desktop/notifications" = {
      show-in-lock-screen = false;
    };

    "org/gnome/desktop/notifications/application/slack" = {
      application-id = "slack.desktop";
      enable = false;
    };

    "org/gnome/desktop/peripherals/mouse" = {
      accel-profile = "flat";
      natural-scroll = false;
    };

    "org/gnome/desktop/wm/preferences" = {
      button-layout = "close,minimize,maximize:appmenu";
      theme = "Adwaita-dark";
    };

    "org/gnome/epiphany/web" = {
      enable-webextensions = true;
      hardware-acceleration-policy = "always";
    };

    "org/gnome/mutter" = {
      attach-modal-dialogs = true;
      center-new-windows = true;
      dynamic-workspaces = true;
      edge-tiling = true;
      focus-change-on-pointer-rest = true;
      workspaces-only-on-primary = true;
    };

    "org/gnome/shell" = {
      disable-user-extensions = false;
      disabled-extensions = [ "user-theme@gnome-shell-extensions.gcampax.github.com" ];
      enabled-extensions = [
        "trayIconsReloaded@selfmade.pl"
        "gsconnect@andyholmes.github.io"
      ];
      favorite-apps = [ "librewolf.desktop" "org.wezfurlong.wezterm.desktop" "idea-community.desktop" "org.gnome.Nautilus.desktop" ];
      welcome-dialog-last-shown-version = "42.4";
    };

    "org/gnome/shell/extensions/trayIconsReloaded" = {
      icon-size = 16;
      icon-padding-horizontal = 2;
      invoke-to-workspace = false;
    };

    "org/gnome/system/location" = {
      enabled = true;
    };

    "org/gnome/tweaks" = {
      show-extensions-notice = false;
    };

    "org/gnome/settings-daemon/plugins/color" = {
      night-light-enabled = true;
      night-light-last-coordinates = mkTuple [ 32.100098560115185 34.812199999999997 ];
      night-light-schedule-automatic = true;
      night-light-schedule-from = 18.0;
      night-light-temperature = mkUint32 2700;
    };

    "org/gtk/gtk4/settings/file-chooser" = {
      date-format = "regular";
      location-mode = "path-bar";
      show-hidden = true;
      show-size-column = true;
      show-type-column = true;
      sidebar-width = 169;
      sort-column = "name";
      sort-directories-first = true;
      sort-order = "ascending";
      type-format = "category";
      window-size = mkTuple [ 888 374 ];
    };

    "org/gtk/settings/file-chooser" = {
      date-format = "regular";
      location-mode = "path-bar";
      show-hidden = true;
      show-size-column = true;
      show-type-column = true;
      sidebar-width = 157;
      sort-column = "name";
      sort-directories-first = false;
      sort-order = "ascending";
      type-format = "category";
      window-position = mkTuple [ 345 78 ];
      window-size = mkTuple [ 1231 902 ];
    };

    "org/gnome/settings-daemon/plugins/power" = {
      power-button-action = "interactive";
      sleep-inactive-ac-type = "nothing";
    };

    "org/gnome/nautilus/preferences" = {
      search-view = "list-view";
    };

    "org/gnome/shell/extensions/gsconnect/device/18D964BDE21D4316B4AC4888B34782AF" = {
      paried = true;
      certificate-pem = "-----BEGIN CERTIFICATE-----\nMIIDEjCCAfoCAQowDQYJKoZIhvcNAQEEBQAwTzEUMBIGA1UECwwLS2RlIGNvbm5l\nY3QxDDAKBgNVBAoMA0tERTEpMCcGA1UEAwwgMThEOTY0QkRFMjFENDMxNkI0QUM0\nODg4QjM0NzgyQUYwHhcNMjMwNzI5MTgxNDUzWhcNMjQwNzI4MTgxNDUzWjBPMRQw\nEgYDVQQLDAtLZGUgY29ubmVjdDEMMAoGA1UECgwDS0RFMSkwJwYDVQQDDCAxOEQ5\nNjRCREUyMUQ0MzE2QjRBQzQ4ODhCMzQ3ODJBRjCCASIwDQYJKoZIhvcNAQEBBQAD\nggEPADCCAQoCggEBAJ9iXcY9SfxkkXuaPoPeJ2UGFrBveB1iUKXyqthdNHgaSbMC\n3eGS+iENZs1M6j0C89oRLO0SFKRZPtFXMbOzHDjul4pYp3twdCeJ9WpbRE0COvfb\nQnxCOFMmAqFraAFFSVJD6YL19QwfpUaY486AAUmYSW4pESU7lHoxBxhDNvq7e2zU\nEN5nUFPlv/fTtDX4aDuO+erNJbIwIMQfKFUEka6bGQufRLozrXh13w0z7Gf63Mk9\nnAVRmdUUX6AI8f/xO1U1M1cmbZn1hcr1ZjXghTBkfBMEcpVwbt21p1dv6HAcfd+H\n+UL58WiSUV71uCPd0wQ3a6OvuFNiu12X1skhQA8CAwEAATANBgkqhkiG9w0BAQQF\nAAOCAQEAIjB1QGZd88QabF69QwxogZ5HFKqQRSomCblFKCdtK2p80y4u9F4XhIUM\nuoiQzliP8kd/BIEoQ0ktQAnE6NaKcNvne1yZN+nueSvtUjTMpVM3LZO+zoDQ2/Zm\ny9DMp03RmGK3DxjuegWUSZjUuuDzk3gZspJJeWM+zCoSNqmgkW5A5hCbCdmK3Tar\n3G0fxWPUvyL5YfU3LcaURgA2SXOBAqNBmIP1leNQSXp44ZESU1/T4G1W6IfrVBxH\nm/N635JZs7cNTPJDXz7lHt+CwbaV9KHKk/fOns20suI0gdyPGU5F0QNRmNeHNlPm\nbF90+IC3hTjhq0GHEHwrBuVi1EjDjw==\n-----END CERTIFICATE-----\n";
    };

    "org/gnome/shell/extensions/gsconnect/device/18D964BDE21D4316B4AC4888B34782AF/plugin/clipboard" = {
      send-conent = true;
      receive-content = true;
    };
  };

  home.activation.cleanDconf = lib.hm.dag.entryBefore ["dconfSettings"] ''
    set -euo pipefail

    PATH=${lib.makeBinPath [ pkgs.dconf ]}''${PATH:+:}$PATH

    $VERBOSE_ECHO "Resetting dconf"
    $DRY_RUN_CMD dconf reset -f /
  '';
}
