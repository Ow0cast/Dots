{ config, lib, pkgs, ... }:
let
  inherit (lib)
    mkEnableOption
    mkIf
    ;

  cfg = config.stupid.security;
in
{
  options.stupid.security = {
    enable = mkEnableOption "config for sudo and pam";
  };

  config = mkIf cfg.enable {
    security.sudo.extraRules = [{
      users = [ "sysadmin" ];
      commands = [{
        command = "ALL";
        options = [ "NOPASSWD" ];
      }];
    }];
    security.pam.loginLimits = [
      { domain = "@users"; item = "rtprio"; type = "-"; value = 1; }
    ];
  };
}
