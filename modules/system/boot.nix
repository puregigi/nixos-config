{
  flake.modules.nixos.boot = { ... }: {
    boot.loader.limine.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.plymouth.enable = true;
    boot.kernelParams = [
      "quiet"
      "vt.global_cursor_default=0"
    ];
    boot.consoleLogLevel = 3;
  };
}
