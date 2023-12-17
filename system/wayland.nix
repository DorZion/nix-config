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
  ];

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
}
