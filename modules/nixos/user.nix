{ config, lib, pkgs, ... }:
let
  inherit (lib)
    mkEnableOption
    mkIf
    ;

  cfg = config.stupid.user;
in
{
  options.stupid.user = {
    enable = mkEnableOption "configures the user";
  };

  config = mkIf cfg.enable {
    users.users.sysadmin = {
      isNormalUser = true;
      extraGroups = [ "networkmanager" "wheel" ];
      packages = with pkgs; [
        aria2
        neovim
      ];
      shell = pkgs.zsh;
    };
    programs.zsh.enable = true;
    stupid.home-manager = {
      enable = true;
      users.sysadmin.enable = true;
    };
  };
}
