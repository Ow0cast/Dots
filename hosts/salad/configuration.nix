{ config, pkgs, ... }:

{
  # Bootloader. salad
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "salad"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

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

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.owuh = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      #firefox
      kate
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
		users.owuh.enable = true;
	};

  system.stateVersion = "23.11"; # dont change this or youre stupid
}
