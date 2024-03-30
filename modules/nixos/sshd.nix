{ config, lib, ... }:
let
	inherit (lib)
		mkEnableOption
		mkIf
		;
	
	cfg = config.stupid.sshd;
in
{
	options.stupid.sshd = {
		enable = mkEnableOption "openssh sshd (for remote access)";
	};

	config = mkIf cfg.enable {
		services.openssh = {
			enable = true;
			settings = {
				PermitRootLogin = "no";
				PasswordAuthentication = false;
			};
		};
	};
}
