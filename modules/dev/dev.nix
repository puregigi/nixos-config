{
  perSystem = { config, ... }: {
    devShells.default = config.devShells.fullstack;
  };

  flake.modules.nixos.dev = { ... }: {
    programs.nix-ld.enable = true;
  };

  flake.modules.homeManager.dev = {config, ... }: {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
      silent = true;
    };

   home.sessionVariables.GOPATH = "${config.home.homeDirectory}/.go";
  };
}
