{
  flake.modules.homeManager.cli = { pkgs, ... }: {
    home.packages = with pkgs; [
      yazi
      unzip
      zip
      p7zip
      pciutils
      evtest
      poppler-utils
      jq
      nh
      nvd
      nil
    ];

    programs.zoxide.enable = true;
    programs.fzf.enable = true;
    programs.eza.enable = true;
    programs.bat.enable = true;
  };
}
