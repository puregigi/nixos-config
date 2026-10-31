{
  flake.modules.nixos.audio = { ... }: {
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    # re-added temp fix --> when x11 app quits it crashes pipewire ??? (maybe umbriel update bug)
    systemd.user.services.pipewire.serviceConfig.UnsetEnvironment = [ "DISPLAY" ];
  };
}
