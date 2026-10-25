{ inputs, ... }:
{
  flake.modules.nixos.noctalia = { pkgs, ... }: {
    imports = [
      inputs.noctalia.nixosModules.default
      inputs.umbriel.nixosModules.default
      inputs.noctalia-greeter.nixosModules.default
    ];

    # Binary caches for noctalia / umbriel
    nix.settings = {
      extra-substituters = [
        "https://noctalia.cachix.org"
        "https://umbriel.cachix.org"
      ];
      extra-trusted-public-keys = [
        "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
        "umbriel.cachix.org-1:JfNq/2yg2S6D6z4Z2dVSZrZlDPQTKtexB6GAVLD98nw="
      ];
    };

    programs.umbriel.enable = true;
    programs.noctalia.enable = true;

    services.displayManager.noctalia-greeter = {
      enable = true;
      passwordless-sync-users = [ "gigi" ];
      settings = {
        output = {
          width = 1920;
          height = 1080;
        };
        cursor = {
          theme = "catppuccin-mocha-mauve-cursors";
          size = 24;
          path = "${pkgs.catppuccin-cursors.mochaMauve}/share/icons";
        };
        keyboard = {
          layout = "us";
          variant = "intl";
        };
        clock.enabled = false;
      };
    };

    # Pause shell while the machine sleeps - temp fix for Umbriel (wlroots)
    # based on Multi-Process Service (MPS) https://wiki.nixos.org/wiki/Nvidia
    systemd = {
      services."noctalia-suspend" = {
        description = "suspend noctalia";
        before = [
          "systemd-suspend.service"
          "systemd-hibernate.service"
          "nvidia-suspend.service"
          "nvidia-hibernate.service"
        ];
        wantedBy = [
          "systemd-suspend.service"
          "systemd-hibernate.service"
        ];
        serviceConfig = {
          Type = "oneshot";
          ExecStart = "${pkgs.procps}/bin/pkill -f -STOP noctalia";
        };
      };
      services."noctalia-resume" = {
        description = "resume noctalia";
        after = [
          "systemd-suspend.service"
          "systemd-hibernate.service"
          "nvidia-resume.service"
        ];
        wantedBy = [
          "systemd-suspend.service"
          "systemd-hibernate.service"
        ];
        serviceConfig = {
          Type = "oneshot";
          ExecStart = "${pkgs.procps}/bin/pkill -f -CONT noctalia";
        };
      };
    };
  };

  flake.modules.homeManager.noctalia = { config, pkgs, ... }:
  let
    # live symlink into the repo, edits apply without a rebuild
    link = path:
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.nixos/${path}";
  in
  {
    home.packages = with pkgs; [
      xwayland-satellite
      wl-clipboard
      libnotify
      brightnessctl
      ddcutil
    ];

    xdg.configFile."noctalia/config.toml".source = link "noctalia/config.toml";
    xdg.configFile."umbriel/config.toml".source = link "umbriel/config.toml";
  };
}
