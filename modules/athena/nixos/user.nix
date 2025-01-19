{ config, lib, pkgs, ... }:
let
  inherit (lib)
    mkEnableOption
    mkIf
    ;

  cfg = config.athena.user;
in
{
  options.athena.user = {
    enable = mkEnableOption "Configures user";
  };

  config = mkIf cfg.enable {
    users.users.nikki = {
      isNormalUser = true;
      extraGroups = [ "networkmanager" "wheel" ];
      packages = with pkgs; [
        aria2
        neovim
        gnupg
        btop
      ];
      shell = pkgs.zsh;
    };

    athena.home-manager = {
      enable = true;
      users.nikki.enable = true;
    };
  };
}