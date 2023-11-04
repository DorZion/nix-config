{ lib, pkgs, ... }:
{
  systemd.user.services = {
    sunshine = {
      Unit = {
        Description = "Sunshine is a self-hosted game stream host for Moonlight.";
        StartLimitIntervalSec = 500;
        StartLimitBurst = 5;
        PartOf = "graphical-session.target";
        Wants = "xdg-desktop-autostart.target";
      };

      Service = {
        ExecStart = "${lib.makeBinPath [ pkgs.sunshine ]}/sunshine";
        Restart = "on-failure";
        RestartSec= "5s";
      };

      Install.WantedBy = [ "graphical-session.target" ];
    };
  };
}
