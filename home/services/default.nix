{ lib, pkgs, ... }:
{
  systemd.user.services = {
    sunshine = {
      # Unit = {
      #   Description = "Sunshine is a self-hosted game stream host for Moonlight.";
      #   StartLimitIntervalSec = 500;
      #   StartLimitBurst = 5;
      #   After = "graphical-session.target";
      # };

      Service = {
        ExecStart = "${lib.makeBinPath [ pkgs.sunshine ]}/sunshine";
        Restart = "on-failure";
        RestartSec= "5s";
      };

      Install.WantedBy = [ 
        # "default.target" 
      ];
    };
    inhibit-idle = {
      Unit = {
        Description = "Inhibit idle via Systemd when active.";
      };

      Service = {
        Type = "simple";
        ExecStart = "${pkgs.systemd}/bin/systemd-inhibit --what=idle --who=inhibit-idle --why=commanded --mode=block ${pkgs.coreutils}/bin/sleep infinity";
        Restart = "on-failure";
        RestartSec= "5s";
      };

      Install.WantedBy = [ ];
    };
  };
}
