{ pkgs, ... }:

{
	home.username = "owuh";
	home.homeDirectory = "/home/owuh";

	home.packages = [ pkgs."maple-mono-NF" ];

	home.stateVersion = "23.11";

	programs.home-manager.enable = true;
	
	stupid.shell.enable = true;
	stupid.browser.enable = true;
	#stupid.desktop.enable = true;
	
	programs.git = {
		enable = true;
		userName = "owuh";
		userEmail = "owuh@wayland.best";
		extraConfig.init.defaultBranch = "main";
	};

	programs.firefox = {
		enable = true;
		policies = {
			DisablePocket = true;
			DisableTelemetry = true;
			DisableSetDesktopBackground = true;
			ExtensionSettings = with builtins;
				let extension = shortId: uuid: {
					name = uuid;
					value = {
						install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/${shortId}/latest.xpi";
						installation_mode = "normal_installed";
					};
				};
				in listToAttrs [
					(extension "clearurls" "{74145f27-f039-47ce-a470-a662b129930a}")
				];
			};
		};
}
