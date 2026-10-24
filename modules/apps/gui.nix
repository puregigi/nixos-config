{
  flake.modules.homeManager.gui = { pkgs, ... }: {
    home.packages = with pkgs; [
      zathura
      anki
      bruno
      nautilus
      papers
      onlyoffice-desktopeditors
      file-roller
    ];
  };
}
