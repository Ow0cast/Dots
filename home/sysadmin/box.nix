{ pkgs, ... }:

{
	home.username = "sysadmin";
	home.homeDirectory = "/home/sysadmin";

	home.packages = [ pkgs."maple-mono-NF" ];

	home.stateVersion = "23.11";

	programs.home-manager.enable = true;
	
	stupid.shell.enable = true;

	programs.git = {
		enable = true;
		userName = "owuh";
		userEmail = "owuh@wayland.best";
		extraConfig.init.defaultBranch = "main";
	};
}
