{
  flake.modules.nixos.audio = { ... }: {
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;

      # after upgrade got weird audio crash - temp fix until further investigation
      #pipewire is crashing with a Segmentation Fault (SIGSEGV) inside libpipewire-module-x11-bell.so due to an X11 display I/O error (X11 display (:0) has encountered a fatal I/O error).
      extraConfig.pipewire = {
        "10-disable-bell" = {
          "context.modules" = [
            {
              name = "libpipewire-module-x11-bell";
              flags = [ "disabled" ];
            }
          ];
        };
      };
    };
  };
}
