{ config, lib, pkgs, ... }:
let
  inherit (lib)
    mkEnableOption
    mkIf
    ;

  cfg = config.athena.programs;
in
{
  options.athena.programs = {
    enable = mkEnableOption "Misc. programs";
  };

  config = mkIf cfg.enable {
    programs.git = {
      enable = true;
      userName = "owuh";
      email = "owuh@wayland.best";
      extraConfig.init.defaultBranch = "main";
    };
  };
}