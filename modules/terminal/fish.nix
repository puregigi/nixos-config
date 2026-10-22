{
  flake.modules.nixos.fish = { ... }: {
    programs.fish.enable = true;
  };

  flake.modules.homeManager.fish = { ... }: {
    programs.fastfetch.enable = true;
    programs.fish = {
      enable = true;
      interactiveShellInit = ''
        set -g fish_greeting ""

        if status is-interactive
            fastfetch
        end
      '';
    };
  };
}
