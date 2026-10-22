{ config, inputs, ... }:
let
  m = config.flake.modules;
in
{
  flake.nixosConfigurations.nixos = inputs.nixpkgs.lib.nixosSystem {
    modules = [ m.nixos.host-nixos ];
  };

  flake.modules.nixos.host-nixos = { ... }: {
    imports = (with m.nixos; [
      # base
      nix
      maintenance
      memory
      boot
      networking
      locale
      audio
      fonts
      # hardware
      intel
      nvidia
      peripherals
      # desktop
      catppuccin
      noctalia
      desktop-services
      # apps & dev
      fish
      media
      gaming
      docker
      dev
      # users
      gigi
    ]) ++ [ ./_hardware-configuration.nix ];

    networking.hostName = "nixos";
    system.stateVersion = "26.05";
  };
}
