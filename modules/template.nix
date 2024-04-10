{ config, lib, pkgs, ... }:
let
  inherit (lib)
    mkEnableOption
    mkIf
    ;

  cfg = config.stupid.blehhhhhhhhhhhhhh;
in
{
  options.stupid.desktop = {
    enable = mkEnableOption "mrrrrrrrrrrp :3";
  };

  config = mkIf cfg.enable { };
}
