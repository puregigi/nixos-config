{
  flake.modules.homeManager.starship = { ... }: {
    programs.starship = {
      enable = true;
      enableFishIntegration = true;
      enableTransience = true;
      settings = {
        "$schema" = "https://starship.rs/config-schema.json";
        palette = "catppuccin_mocha";
        format = "$directory$git_branch$git_status$time $fill $rust$bun$golang$custom$shell $line_break$character";

        directory = {
          truncation_length = 4;
          style = "fg:base bg:mauve bold";
          read_only_style = "fg:base bg:mauve bold";
          format = "[](fg:mauve)[  $path ]($style)[$read_only]($read_only_style)[](fg:mauve)";
          read_only = " 󰦝 ";
          home_symbol = " ~";
        };

        git_branch = {
          symbol = "󰊢 ";
          style = "fg:base bg:teal bold";
          format = " [](fg:teal)[$symbol $branch ]($style)";
        };

        git_status = {
          style = "fg:base bg:teal bold";
          up_to_date = "SYNC ";
          format = "[ $ahead_behind$all_status]($style)[](fg:teal)";
          untracked = "\${count}󱕠 ";
          stashed = " ";
          modified = "\${count}󰔤 ";
          staged = "\${count}󰯖 ";
          renamed = "\${count} ";
          deleted = "\${count}󱕞 ";
          ahead = "[SYNC󰋔 ](fg:red bg:teal)";
          behind = "[SYNC󰋔 ](fg:red bg:teal)";
          diverged = "[SYNC󰋔 ](fg:red bg:teal)";
        };

        custom = {
          git_clean = {
            command = "git diff --quiet && git diff --cached --quiet && git ls-files --others --exclude-standard | grep -q '^$' && echo '✓'";
            when = "git rev-parse --is-inside-work-tree 2>/dev/null";
            format = "[$output]($style)";
            style = "fg:base bg:teal bold";
          };

          obsidian = {
            when = "test -d .obsidian";
            format = "[](fg:lavender)[$symbol]($style)[](fg:lavender) ";
            style = "fg:base bg:lavender bold";
            symbol = "";
          };
        };

        time = {
          disabled = false;
          time_format = "%H:%M";
          style = "fg:base bg:lavender bold";
          format = " [](fg:lavender)[󱩸  $time ]($style)[](fg:lavender)";
        };

        fill = {
          symbol = "─"; # or "━" or "·"
          style = "fg:lavender";
        };

        rust = {
          style = "fg:base bg:peach bold";
          symbol = "󱘗 ";
          format = "[](fg:peach)[$symbol $version]($style)[](fg:peach) ";
          detect_files = [ "Cargo.toml" ];
        };

        bun = {
          style = "fg:base bg:pink bold";
          symbol = " ";
          format = "[](fg:pink)[$symbol $version]($style)[](fg:pink) ";
          detect_files = [ "bun.lock" ];
        };

        golang = {
          style = "fg:base bg:sky bold";
          symbol = "󰟓 ";
          format = "[](fg:sky)[$symbol $version]($style)[](fg:sky) ";
          detect_files = [ "go.mod" "go.sum" ];
        };

        shell = {
          disabled = false;
          style = "fg:base bg:blue bold";
          format = "[](fg:blue)[$indicator]($style)[](fg:blue)";
        };

        character = {
          success_symbol = "  [󱞩](fg:mauve bold) [](fg:green)";
          error_symbol = "  [󱞩](fg:mauve bold) [](fg:red)";
        };

        palettes = {
          catppuccin_mocha = {
            rosewater = "#f5e0dc";
            flamingo = "#f2cdcd";
            pink = "#f5c2e7";
            mauve = "#cba6f7";
            red = "#f38ba8";
            maroon = "#eba0ac";
            peach = "#fab387";
            yellow = "#f9e2af";
            green = "#a6e3a1";
            teal = "#94e2d5";
            sky = "#89dceb";
            sapphire = "#74c7ec";
            blue = "#89b4fa";
            lavender = "#b4befe";
            text = "#cdd6f4";
            subtext1 = "#bac2de";
            subtext0 = "#a6adc8";
            overlay2 = "#9399b2";
            overlay1 = "#7f849c";
            overlay0 = "#6c7086";
            surface2 = "#585b70";
            surface1 = "#45475a";
            surface0 = "#313244";
            base = "#1e1e2e";
            mantle = "#181825";
            crust = "#11111b";
          };
        };
      };
    };

    # Required by `enableTransience` above
    programs.fish.interactiveShellInit = ''
        function starship_transient_prompt_func
            echo -n (set_color babbf1)" "(set_color normal)
        end
    '';
  };
}
