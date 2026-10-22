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
        o = [ "compress=zstd" "noatime" ];
      in
      {
        "/".options = o;
        "/home".options = o;
        "/nix".options = o;
      };
  };
}
