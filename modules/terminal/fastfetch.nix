{
  flake.modules.homeManager.fastfetch = {
    programs.fastfetch.enable = true;

    xdg.configFile."fastfetch/config.jsonc".source = ./_fastfetch/config.jsonc;
    xdg.configFile."fastfetch/nixos.txt".source = ./_fastfetch/nixos.txt;
    xdg.configFile."fastfetch/cat.txt".source = ./_fastfetch/cat.txt;
  };
}
