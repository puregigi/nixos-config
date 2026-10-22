{
  perSystem =
    { inputs', config, ... }:
    let
      pkgs = inputs'.nixpkgs.legacyPackages;

      goCoreTools = with pkgs; [
        go
        gopls
        gotools
        gofumpt
        golangci-lint
        delve
        air
        govulncheck
        gotests
        impl
        sqlc
        gomodifytags
      ];

      apiTools = with pkgs; [
        goose
        postgresql
        pgcli
        hurl
        pgformatter
        postgres-language-server
      ];

      mkGoShell =
        {
          name,
          extra ? [ ],
          inputsFrom ? [ ],
          hook ? "",
        }:
        pkgs.mkShell {
          inherit name inputsFrom;
          packages = goCoreTools ++ apiTools ++ extra;

          # delve needs fortify off
          hardeningDisable = [ "fortify" ];

          shellHook = ''
            # Use the Nix-provided Go;
            export GOTOOLCHAIN=local

            export GOPATH="$HOME/.go"

            export DATABASE_URL="''${DATABASE_URL:-postgres://postgres:postgres@localhost:5432/app?sslmode=disable}"
            export GOOSE_DRIVER=postgres
            export GOOSE_DBSTRING="$DATABASE_URL"
            ${hook}
          '';
        };
    in
    {
      # Backend only: Go API + Postgres tooling
      devShells.backend = mkGoShell { name = "backend-dev"; };

      # GOTH: Go + Templ + Tailwind CLI (server-rendered, HTMX)
      devShells.goth = mkGoShell {
        name = "goth-dev";
        extra = with pkgs; [
          templ
          tailwindcss
        ];
      };

      # Fullstack: backend + the whole SPA toolchain from spa.nix
      devShells.fullstack = mkGoShell {
        name = "fullstack-dev";
        inputsFrom = [ config.devShells.spa ];
        extra = [ pkgs.process-compose ];
      };
    };
}
