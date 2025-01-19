{ config, lib, pkgs, ... }:
let
  inherit (lib)
    mkEnableOption
    mkIf
    ;

  cfg = config.stupid.network;
in
{
  options.stupid.network = {
    enable = mkEnableOption "networking config";
  };

  config = mkIf cfg.enable {
    networking = {
      hostName = "box";
      networkmanager.enable = true;
      firewall.allowedTCPPorts = [ 22 8096 8920 5055 8989 80 6789 7878 9696 8080 5960 ];
    };
  };
}
