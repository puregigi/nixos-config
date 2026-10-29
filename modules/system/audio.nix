{
  flake.modules.nixos.audio = { ... }: {
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    # Removed the old extraConfig.pipewire."10-disable-bell" block from audio.nix, and added this instead
    systemd.user.services.pipewire.serviceConfig.UnsetEnvironment = [ "DISPLAY" ];
  };
}
