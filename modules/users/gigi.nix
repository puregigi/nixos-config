{ config, inputs, ... }:
let
  m = config.flake.modules;
in
{
  flake.modules.nixos.gigi = { pkgs, ... }: {
    imports = [ inputs.home-manager.nixosModules.home-manager ];

    users.users."gigi" = {
      isNormalUser = true;
      description = "gigi";
      shell = pkgs.fish;
      extraGroups = [ "networkmanager" "wheel" "input" ];
      packages = with pkgs; [];
    };

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      backupFileExtension = "backup";
      users.gigi.imports = [ m.homeManager.gigi ];
    };
  };

  flake.modules.homeManager.gigi = { ... }: {
    imports = with m.homeManager; [
      locale
      catppuccin
      gtk
      mime
      noctalia
      desktop-services
      nvidia
      fish
      fastfetch
      starship
      kitty
      git
      dev
      emacs
      zen-browser
      cli
      gui
      media
    ];

    home.username = "gigi";
    home.homeDirectory = "/home/gigi";
    home.stateVersion = "26.05";

    programs.home-manager.enable = true;
  };
}
