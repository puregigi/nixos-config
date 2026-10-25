{
  flake.modules.homeManager.gtk =
    { config, pkgs, ... }:
    let
      adwaita-colors = pkgs.stdenvNoCC.mkDerivation {
        pname = "adwaita-colors-icon-theme";
        version = "git-7d838af";

        src = pkgs.fetchFromGitHub {
          owner = "dpejoh";
          repo = "Adwaita-colors";
          rev = "7d838af258da4ca05040760301d05140aa858145";
          hash = "sha256-EncnmE5Ck7QnebyU5zW4L5yV9wIW2yLr4lB1FgqG+0A=";
        };

        dontConfigure = true;
        dontFixup = true;

        buildPhase = ''
          runHook preBuild

          # writable copy of Adwaita, since the store version is read-only
          cp -r --no-preserve=mode ${pkgs.adwaita-icon-theme}/share/icons/Adwaita adwaita-src
          chmod -R u+w adwaita-src

          # point the script at the writable copy instead of /usr/share/icons
          echo "ADWAITA_PATHS=(\"$PWD/adwaita-src\")" >> variants.conf

          mkdir -p $out/share/icons
          bash ./setup -i -p $out/share/icons

          # Catppuccin Mocha mauve variant, derived from the purple one
          mauve=$out/share/icons/Adwaita-mauve
          cp -a $out/share/icons/Adwaita-purple $mauve
          chmod -R u+w $mauve
          sed -i 's/^Name=Adwaita-purple/Name=Adwaita-mauve/' $mauve/index.theme
          find $mauve -type f -name '*.svg' -exec sed -i \
          -e 's/#d099d6/#cba6f7/Ig' \
          -e 's/#954ab5/#9262cb/Ig' \
          -e 's/#9141ac/#8955c6/Ig' \
          -e 's/#613583/#6e39ac/Ig' \
          {} +

          runHook postBuild
        '';
        dontInstall = true;
      };
    in
    {
      # package and name now come from catppuccin-nix
      home.pointerCursor = {
        enable = true;
        size = 24;
        gtk.enable = true;
      };

      dconf.settings = {
        "org/gnome/desktop/interface" = {
          cursor-theme = config.home.pointerCursor.name;
          cursor-size = 24;
          icon-theme = "Adwaita-mauve";
        };
      };

      home.packages = with pkgs; [
        adw-gtk3
        adwaita-icon-theme
        adwaita-icon-theme-legacy
        adwaita-colors
      ];
    };
}
