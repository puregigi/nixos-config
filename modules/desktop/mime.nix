{
  flake.modules.homeManager.mime = { ... }: {
    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "inode/directory" = [ "org.gnome.Nautilus.desktop" ];
        "text/plain" = [ "emacs.desktop" ];
        "text/*" = [ "emacs.desktop" ];

        "x-scheme-handler/http" = [ "zen.desktop" ];
        "x-scheme-handler/https" = [ "zen.desktop" ];
        "x-scheme-handler/about" = [ "zen.desktop" ];
        "x-scheme-handler/unknown" = [ "zen.desktop" ];
        "text/html" = [ "zen.desktop" ];
        "application/xhtml+xml" = [ "zen.desktop" ];

        "application/pdf" = [ "org.pwmt.zathura-pdf-mupdf.desktop" ];
        "image/jpeg" = [ "org.gnome.Loupe.desktop" ];
        "image/png" = [ "org.gnome.Loupe.desktop" ];
        "video/mp4" = [ "celluloid.desktop" ];
        "audio/flac" = [ "decibels.desktop" ];
      };
    };
  };
}
