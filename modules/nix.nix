{
  flake.modules.nixos.nix = { ... }: {
    nixpkgs.config.allowUnfree = true;
    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];

    programs.nh = {
      enable = true;
      flake = "/home/gigi/.nixos";
    };
  };
}
