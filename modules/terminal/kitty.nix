{
  flake.modules.homeManager.kitty = { ... }: {
    programs.kitty = {
      enable = true;
      extraConfig = ''
        background_opacity 0.85

        window_padding_width 12
        font_family      Maple Mono
        bold_font        auto
        italic_font      auto
        bold_italic_font auto
        font_size        12

        modify_font cell_height 94%
        text_composition_strategy legacy
        box_drawing_scale 0.001, 0.5, 1.0, 1.5

        shell_integration no-cursor
        cursor_shape beam
        cursor_beam_thickness 1
        cursor_blink_interval 0.5

        symbol_map U+1100-U+11FF,U+3130-U+318F,U+AC00-U+D7A3 Noto Sans Mono CJK KR
        symbol_map U+16E6D Noto Sans Medefaidrin
        symbol_map U+141F DejaVu Sans

        disable_ligatures never
        url_style curly

        tab_bar_edge bottom
        tab_bar_style powerline
        tab_powerline_style slanted
        tab_title_template "{fmt.bold}{index}: {title}"
        active_tab_font_style   bold
        inactive_tab_font_style normal

        include themes/noctalia.conf
      '';
    };
  };
}
