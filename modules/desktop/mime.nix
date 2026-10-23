{
  flake.modules.homeManager.mime =
    { lib, ... }:
    let

      assoc = app: types: lib.genAttrs types (_: [ app ]);

      browser = "zen-beta.desktop";
      editor = "emacs.desktop";
      files = "org.gnome.Nautilus.desktop";
      images = "org.gnome.Loupe.desktop";
      video = "io.github.celluloid_player.Celluloid.desktop";
      audio = "org.gnome.Decibels.desktop";
      pdf = "org.pwmt.zathura-pdf-mupdf.desktop";
      archive = "org.gnome.FileRoller.desktop";
      office = "onlyoffice-desktopeditors.desktop";
    in
    {
      xdg.mimeApps = {
        enable = true;
        defaultApplications =
          assoc files [ "inode/directory" ]

          // assoc browser [
            "x-scheme-handler/http"
            "x-scheme-handler/https"
            "x-scheme-handler/about"
            "x-scheme-handler/unknown"
            "text/html"
            "application/xhtml+xml"
          ]

          // assoc editor [
            "text/plain"
            "text/markdown"
            "text/x-markdown"
            "text/x-nix"
            "text/x-python"
            "text/x-go"
            "text/x-csrc"
            "text/x-chdr"
            "text/css"
            "text/csv"
            "text/xml"
            "application/xml"
            "application/json"
            "application/toml"
            "application/x-yaml"
            "application/x-shellscript"
          ]

          // assoc pdf [
            "application/pdf"
            "application/epub+zip"
          ]

          // assoc "org.pwmt.zathura-djvu.desktop" [
            "image/vnd.djvu"
            "image/x-djvu"
          ]

          // assoc "org.pwmt.zathura-cb.desktop" [
            "application/vnd.comicbook+zip"
            "application/x-cbz"
            "application/x-cbr"
          ]

          // assoc "org.pwmt.zathura-ps.desktop" [
            "application/postscript"
          ]

          // assoc images [
            "image/jpeg"
            "image/png"
            "image/gif"
            "image/webp"
            "image/avif"
            "image/bmp"
            "image/tiff"
            "image/heif"
            "image/svg+xml"
          ]

          // assoc video [
            "video/mp4"
            "video/x-matroska"
            "video/webm"
            "video/quicktime"
            "video/x-msvideo"
            "video/mpeg"
            "video/ogg"
          ]

          // assoc audio [
            "audio/flac"
            "audio/x-flac"
            "audio/mpeg"
            "audio/mp4"
            "audio/aac"
            "audio/ogg"
            "audio/opus"
            "audio/x-wav"
            "audio/x-m4a"
          ]

          // assoc archive [
            "application/zip"
            "application/x-tar"
            "application/gzip"
            "application/x-bzip2"
            "application/x-xz"
            "application/zstd"
            "application/x-7z-compressed"
            "application/vnd.rar"
            "application/x-rar"
            "application/x-compressed-tar"
            "application/x-bzip-compressed-tar"
            "application/x-xz-compressed-tar"
            "application/x-zstd-compressed-tar"
          ]

          // assoc office [
            "application/msword"
            "application/vnd.ms-excel"
            "application/vnd.ms-powerpoint"
            "application/rtf"
            "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
            "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
            "application/vnd.openxmlformats-officedocument.presentationml.presentation"
            "application/vnd.oasis.opendocument.text"
            "application/vnd.oasis.opendocument.spreadsheet"
            "application/vnd.oasis.opendocument.presentation"
          ];
      };
    };
}
