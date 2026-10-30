{
  flake.modules.homeManager.emacs = { config, pkgs, ... }: {
    home.packages = with pkgs; [
      # Emacs with prebuilt tree-sitter grammars
      (emacs-pgtk.pkgs.withPackages (epkgs: [ epkgs.treesit-grammars.with-all-grammars ]))
      # Doom Emacs dependencies
      ripgrep
      fd
      clang
      cmake
      gnumake
      languagetool
      (aspellWithDicts (d: [
        d.en
        d.pt_BR
      ]))
      # Formatters for the (sh) and (nix) modules with (format +onsave)
      shellcheck
      shfmt
      nixfmt
      pandoc
      libxml2
      dockfmt
    ];

    # Doom Symlink
    xdg.configFile."doom".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.nixos/doom";

    # Doom's CLI
    programs.fish.interactiveShellInit = ''
      fish_add_path ${config.home.homeDirectory}/.config/emacs/bin
    '';

    # Doom's CLI session variable inside Home Manager
    home.sessionVariables = {
      DOOMDIR = "${config.xdg.configHome}/doom";
    };
  };
}
