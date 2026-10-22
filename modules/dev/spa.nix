{
  perSystem =
    { inputs', ... }:
    let
      pkgs = inputs'.nixpkgs.legacyPackages;
    in
    {
      devShells.spa = pkgs.mkShell {
        name = "spa-dev";
        packages = with pkgs; [
          bun
          nodejs
          typescript
          typescript-language-server
          vscode-langservers-extracted
          prettier
          tailwindcss
        ];

        shellHook = ''
          export PATH="$PWD/node_modules/.bin:$PATH"
        '';
      };
    };
}
