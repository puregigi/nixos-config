{
  flake.modules.nixos.intel = { ... }: {
    hardware.cpu.intel.updateMicrocode = true;
    hardware.enableRedistributableFirmware = true;
  };
}
