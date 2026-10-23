{
  flake.modules.nixos.maintenance = {
    nix.gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
    nix.optimise.automatic = true;

    boot.loader.limine.maxGenerations = 20;

    services.fstrim.enable = true;
    services.btrfs.autoScrub.enable = true;

    services.fwupd.enable = true;

    fileSystems =
      let
        o = [
          "compress=zstd"
          "noatime"
        ];
      in
      {
        "/".options = o;
        "/home".options = o;
        "/nix".options = o;
      };

    systemd.tmpfiles.rules = [
      "v /home/.snapshots 0750 root root -"
    ];

    services.snapper = {
      snapshotInterval = "hourly";
      cleanupInterval = "1d";

      configs.home = {
        SUBVOLUME = "/home";
        ALLOW_USERS = [ "gigi" ];
        TIMELINE_CREATE = true;
        TIMELINE_CLEANUP = true;
        TIMELINE_LIMIT_HOURLY = "5";
        TIMELINE_LIMIT_DAILY = "7";
        TIMELINE_LIMIT_WEEKLY = "4";
        TIMELINE_LIMIT_MONTHLY = "3";
        TIMELINE_LIMIT_YEARLY = "0";
      };
    };
  };
}
