{
  flake.modules.nixos.fonts = { pkgs, ... }: {
    fonts.packages = with pkgs; [
      inter
      roboto
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      fira-code-symbols
      nerd-fonts.fira-code
      nerd-fonts.jetbrains-mono
      maple-mono.truetype
      maple-mono.NF-unhinted
      maple-mono.NF-CN-unhinted
    ];
    fonts.fontconfig = {
      enable = true;
      defaultFonts = {
        sansSerif = [ "Noto Sans" ];
        serif = [ "Noto Serif" ];
        monospace = [ "Noto Sans Mono" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };
}
