{ config, lib, pkgs, ... }:
let
  inherit (lib)
    mkEnableOption
    mkIf
    ;

  cfg = config.ystem-name.module-name;
in
{
  options.system-name.module-name = {
    enable = mkEnableOption "option title";
  };

  config = mkIf cfg.enable { };
}
