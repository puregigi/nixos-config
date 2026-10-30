{ inputs, ... }:
let
  flavor = "mocha";
  accent = "mauve";
in
{
  flake.modules.nixos.catppuccin = {
    imports = [ inputs.catppuccin.nixosModules.catppuccin ];
    catppuccin = {
      enable = true;
      autoEnable = false;
      cache.enable = true;
      inherit flavor accent;

      # boot
      plymouth.enable = true;
      limine.enable = true;
      tty.enable = true;
    };
  };

  flake.modules.homeManager.catppuccin = {
    imports = [ inputs.catppuccin.homeModules.catppuccin ];
    catppuccin = {
      enable = true;
      autoEnable = false;
      inherit flavor accent;

      cursors.enable = true;

      # shell and CLI
      fish.enable = true;
      starship.enable = true;
      lazygit.enable = true;
      fzf.enable = true;
      eza.enable = true;
      bat.enable = true;
    };
  };
}
