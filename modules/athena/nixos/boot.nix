{ config, lib, pkgs, ... }:
let
  inherit (lib)
    mkEnableOption
    mkIf
    ;

  cfg = config.athena.boot;
in
{
  options.athena.boot = {
    enable = mkEnableOption "Configures GUUB";
  };

  config = mkIf cfg.enable {
    boot.loader = {
      grub = {
        enable = true;
        useOSProber = true;
        device = "/dev/nvme0n1p1";
      };
    };
  };
}