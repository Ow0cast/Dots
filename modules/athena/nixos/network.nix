{ config, lib, pkgs, ... }:
let
  inherit (lib)
    mkEnableOption
    mkIf
    ;

  cfg = config.things.network;
in
{
  options.things.network = {
    enable = mkEnableOption "Configures network";
  };

  config = mkIf cfg.enable {
    networking = {
      hostName = "athena";
      networkmanager.enable = true;
    };
  };
}