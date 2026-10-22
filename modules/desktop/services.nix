{
  flake.modules.nixos.desktop-services = { pkgs, ... }: {
    security.polkit.enable = true;
    services.udisks2.enable = true;
    services.gvfs.enable = true;
    services.playerctld.enable = true;
    services.upower.enable = true;
    services.power-profiles-daemon.enable = true;
    services.tumbler.enable = true;

    xdg.portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };

    environment.systemPackages = with pkgs; [
      xdg-utils
    ];
  };

  flake.modules.homeManager.desktop-services = { pkgs, ... }: {
    home.packages = with pkgs; [
      udiskie
      ffmpegthumbnailer
    ];
  };
}
