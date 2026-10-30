{
  flake.modules.nixos.fish = { ... }: {
    programs.fish.enable = true;
  };

  flake.modules.homeManager.fish = { ... }: {
    programs.fish = {
      enable = true;
      interactiveShellInit = ''
        set -g fish_greeting ""

        if status is-interactive; and not set -q INSIDE_EMACS
            fastfetch
        end
      '';
    };
  };
}
