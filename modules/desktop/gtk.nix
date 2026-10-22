{
  flake.modules.homeManager.gtk = { pkgs, ... }: {
    home.pointerCursor = {
      enable = true;
      package = pkgs.catppuccin-cursors.mochaMauve;
      name = "catppuccin-mocha-mauve-cursors";
      size = 24;
      gtk.enable = true;
    };

    dconf.settings = {
      "org/gnome/desktop/interface" = {
        cursor-theme = "catppuccin-mocha-mauve-cursors";
        cursor-size = 24;
        icon-theme = "Adwaita";
      };
    };

    home.packages = with pkgs; [
      adw-gtk3
      adwaita-icon-theme
      adwaita-icon-theme-legacy
      catppuccin-cursors.mochaMauve
    ];
  };
}
