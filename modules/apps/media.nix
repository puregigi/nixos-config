{
  flake.modules.nixos.media = { ... }: {
    programs.obs-studio.enable = true;
  };

  flake.modules.homeManager.media = { pkgs, ... }: {
    home.packages = with pkgs; [
      kew
      loupe
      snapshot
      decibels
      celluloid
      imagemagick
      ffmpeg
    ];
  };
}
