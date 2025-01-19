{ config, pkgs, lib, ... }:
let
  inherit (lib)
    mkEnableOption
    mkIf
    ;

  cfg = config.athena.terminal;
in
{
  options.athena.terminal = {
    enable = mkEnableOption "Terminal things";
  };

  config = mkIf cfg.enable {
    programs.kitty = {
      enable = true;
      font.name = "Maple Mono NF";
      font.size = 16;
      theme = "Catppuccin-Mocha";
      settings = {
        scrollback_lines = 100000;
        enable_audio_bell = false;
        confirm_os_window_close = 0;

        # tab bar
        tab_bar_min_tabs = 1;
        tab_bar_edge = "bottom";
        tab_bar_style = "powerline";
        tab_powerline_syle = "slanted";
        tab_title_template = "{title}{ ' :{}:'.format(num_windows) if num_windows > 1 else ''}";
      };
    };

    programs.zsh = {
      enable = true;
      autocd = true;
      enableAutosuggestions = true;
      enableCompletion = true;
      syntaxHighlighting = {
        enable = true;
        highlighters = [ "main" "brackets" ];
      };
      plugins = [{
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "v0.8.0";
          sha256 = "1lzrn0n4fxfcgg65v0qhnj7wnybybqzs4adz7xsrkgmcsr0ii8b7";
        };
      }];
    };

    programs.starship.enable = true;
  };
}