{ config, lib, ... }:
let
	inherit (lib)
		mkEnableOption
		mkIf
		;

	cfg = config.stupid.kitty;
in
{
	options.stupid.kitty = {
		enable = mkEnableOption "Kitty";
	};

	config = mkIf cfg.enable {
		programs.kitty = {
			enable = true;
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
	};
}
