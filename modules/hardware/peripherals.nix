{
  flake.modules.nixos.peripherals = { ... }: {
    hardware.bluetooth.enable = true;
    hardware.logitech.wireless.enable = true;
    hardware.i2c.enable = true;
    programs.solaar.enable = true;
  };
}
