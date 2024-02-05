{ ... }:

{
	home.username = "owuh";
	home.homeDirectory = "/home/owuh";

	home.packages = [ ];

	home.stateVersion = "23.11";

	programs.home-manager.enable = true;

	stupid.kitty.enable = true;

	programs.git = {
		enable = true;
		userName = "owuh";
		userEmail = "owuh@wayland.best";
		extraConfig.init.defaultBranch = "main";
	};

	programs.zsh = {
		enable = true;
		autocd = true;
		enableAutosuggestions = true;
	};
}
