{ config, lib, pkgs, ... }:
let
  inherit (lib)
    mkEnableOption
    mkIf
    ;

  cfg = config.stupid.browser;
in
{
  options.stupid.browser = {
    enable = mkEnableOption "Firefox config";
  };

  config = mkIf cfg.enable {
    programs.firefox = {
      enable = true;
      profiles.owuh = {
        name = "salad";
        id = 0;
        isDefault = true;
        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          clearurls
          darkreader
          fastforwardteam
          istilldontcareaboutcookies
          one-click-wayback
          peertubeify
          proton-pass
          sponsorblock
          return-youtube-dislikes
        ];
      };
      policies = {
        DisablePocket = true;
        DisableSetDesktopBackground = true;
        DisableTelemetry = true;
        DisableFirefoxStudies = true;
      };
    };
  };
}
