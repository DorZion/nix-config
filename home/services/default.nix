{ lib, pkgs, ... }:
{
  systemd.user.services = {
    sunshine = {
      Unit = {
        Description = "Sunshine is a self-hosted game stream host for Moonlight.";
        StartLimitIntervalSec = 500;
        StartLimitBurst = 5;
        PartOf = "graphical-session.target";
      };

      Service = {
        ExecStart = "${lib.makeBinPath [ pkgs.sunshine ]}/sunshine";
        Restart = "on-failure";
        RestartSec= "5s";
      };

      Install.WantedBy = [ "default.target" ];
    };
    inhibit-idle = {
      Unit = {
        Description = "Inhibit idle via Systemd when active.";
      };

      Service = {
        ExecStart = "/home/dor/.local/share/bin/inhibit-idle-loop.sh";
        Restart = "on-failure";
        RestartSec= "5s";
        PIDFile = "/tmp/ihibit-idle-loop.pid";
      };

      Install.WantedBy = [ ];
    };
  };
}
