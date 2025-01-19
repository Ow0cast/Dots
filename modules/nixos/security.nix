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
    security.pam.loginLimits = [
      { domain = "*"; item = "memlock"; type = "-"; value = "infinity"; }
      { domain = "*"; item = "nofile"; type = "-"; value = "65536"; }
      { domain = "@users"; item = "rtprio"; type = "-"; value = 1; }
    ];
  };
}
