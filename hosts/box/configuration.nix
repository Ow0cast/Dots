{ config, pkgs, ... }:

{
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "box"; # Define your hostname.

	nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.networkmanager.enable = true;

  time.timeZone = "America/Toronto";

  i18n.defaultLocale = "en_CA.UTF-8";

  services.xserver.enable = true;
	
	security.pam.loginLimits = [
		{ domain = "@users"; item = "rtprio"; type = "-"; value = 1; }
	];

  services.xserver.displayManager = {
		sddm.enable = true;
		sessionPackages = [ pkgs.sway ];
	};

  services.xserver.desktopManager.plasma5.enable = true;

  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  users.users.sysadmin = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      neovim
    ];
		shell = pkgs.zsh;
  };
	programs.zsh.enable = true;

  nixpkgs.config = {
		allowUnfree = true;
		packageOverrides = pkgs: {
			nur = import (builtins.fetchTarball {
				url = "https://github.com/nix-community/NUR/archive/b221a8e8493458bf33a754d86970bc656fdc43cc.tar.gz";
				sha256 = "18z3rg8gzh5mjjgs7b05llx6gc0gi39dq8msygrr9mn08cbxb7ab";
			})
			{
				inherit pkgs;
			};
		};
	};
	stupid.home-manager = {
		enable = true;
		users.sysadmin.enable = true;
	};
	stupid.sshd.enable = true;
	stupid.samba.enable = true;
  system.stateVersion = "23.11"; # dont change this or youre stupid
}
