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
    git.enable = mkEnableOption "Misc. programs";
  };

  config = {
    programs.git = mkIf cfg.git.enable {
      enable = true;
      userName = "owuh";
      email = "owuh@wayland.best";
      extraConfig.init.defaultBranch = "main";
    };
  };
}