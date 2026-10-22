{
  flake.modules.nixos.memory = {
    services.earlyoom = {
      enable = true;
      enableNotifications = true;
    };

    zramSwap.enable = true;
  };
}
