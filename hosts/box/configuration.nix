{ config, pkgs, ... }:

{
  stupid = {
    user.enable = true;
    network.enable = true;
    security.enable = true;
    sshd.enable = true;
    samba.enable = true;
  };
  boot.loader.systemd-boot.enable = true;

  time.timeZone = "America/Toronto";

  i18n.defaultLocale = "en_CA.UTF-8";

  services.aria2.enable = true;

  virtualisation.docker.enable = true;

  system.stateVersion = "23.11"; # dont change this or youre stupid
}
