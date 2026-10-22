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
      autoEnable = true;
      inherit flavor accent;
    };
  };

  flake.modules.homeManager.catppuccin = {
    imports = [ inputs.catppuccin.homeModules.catppuccin ];
    catppuccin = {
      enable = true;
      autoEnable = true;
      inherit flavor accent;
    };
  };
}
