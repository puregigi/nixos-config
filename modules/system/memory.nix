{
  flake.modules.nixos.memory = {
    systemd.oomd.enable = false;
    services.earlyoom = {
      enable = true;
      enableNotifications = true;
    };

    zramSwap.enable = true;
  };
}
