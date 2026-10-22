{
  flake.modules.homeManager.git = { ... }: {
    programs.git = {
      enable = true;

      settings = {
        user = {
          name = "giovanna l.";
          email = "80579735+puregigi@users.noreply.github.com";
        };
        init.defaultBranch = "main";
        pull.rebase = true;
        push.autoSetupRemote = true;
        rerere.enabled = true;
        diff.algorithm = "histogram";
      };

      # Global gitignore
      ignores = [
        ".direnv/"
        "result"
        "result-*"
        ".env"
        ".env.*"
        "!.env.example"
      ];
    };

    programs.lazygit.enable = true;
    programs.gh.enable = true;
  };
}
