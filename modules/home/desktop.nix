{ config, lib, ... }:
let
	inherit (lib)
		mkEnableOption
		mkIf
		;

	cfg = config.stupid.desktop;
in
{
	options.stupid.desktop = {
		enable = mkEnableOption "Desktop";
	};

	config = mkIf cfg.enable {
		wayland.windowManager.sway = {
			enable = true;
			config = {
				terminal = "kitty";
				gaps = {
					inner = 3;
					outer = 2;
				};
				window = {
					border = 1;
					titlebar = false;
				};
				bars = [
					{
						command = "waybar";
					}
				];
			};
		};
		programs.waybar = {
			enable = true;
			settings = {
				bar = {
					layer = "top";
					position = "top";
					spacing = 0;
					height = 34;
					# modules
					modules-left = [
						"custom/logo"
						"sway/workspaces"
					];
					modules-center = [
						"clock"
					];
					modules-right = [
						"tray"
						"memory"
						"network"
						"pulseaudio"
						"custom/power"
					];

					"sway/workspaces" = {
						on-click = "activate";
						format = "{icon}";
						format-icons = {
							default = "";
							active = "󱓻";
							urgent = "󱓻";
						};
						persisent_workspaces = {
							"1" = [];
							"2" = [];
							"3" = [];
							"4" = [];
							"5" = [];
						};
					};
					memory = {
						interval = 5;
						format = "{ICON} {}%";
						max-length = 10;
					};
					tray.spacing = 10;
					clock = {
						tooltip-format = "<tt>{calendar}</tt>";
						format = "{ICON} {:%a, %d %b %Y} {ICON} {:%H:%M}";
						calendar = {
							mode = "year";
							mode-mon-col = 3;
							weeks-pos = "right";
							on-scroll = 1;
							on-click-right = "mode";
							format = {
								months = "<span color='#f2cdcd'><b>{}</b></span>";
								days = "<span color='#f5c2e7'><b>{}</b></span>";
								weeks =	"<span color='#a6e3a1'><b>{}</b></span>";
								weekdays = "<span color='#f9e2af'><b>{}</b></span>";
								today	=	 "<span color='#f38ba8'><b><u>{}</b></span>";
							};
						};
					};
				};
			};
		};
	};
}
