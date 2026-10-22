{
  flake.modules.nixos.nvidia = { config, ... }: {
    services.xserver.videoDrivers = [ "nvidia" ];

    hardware.nvidia = {
      modesetting.enable = true;
      powerManagement.enable = true;
      nvidiaSettings = true;
      open = false;
      package = config.boot.kernelPackages.nvidiaPackages.legacy_580; 
    };

    # Keep the suspend/resume order working with the nvidia driver
    systemd.services.systemd-suspend.environment.SYSTEMD_SLEEP_FREEZE_USER_SESSIONS = "false";

    boot.kernelParams = [ "nvidia.NVreg_TemporaryFilePath=/var/tmp" ];
    boot.initrd.kernelModules = [ "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];
  };

  flake.modules.homeManager.nvidia = { pkgs, ... }: {
    home.packages = with pkgs; [
      btop-cuda
      egl-wayland2
    ];
  };
}
