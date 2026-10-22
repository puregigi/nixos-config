{
  flake.modules.homeManager.cli = { pkgs, ... }: {
    home.packages = with pkgs; [
      yazi
      unzip
      zip
      p7zip
      pciutils
      evtest
    ];
  };
}
