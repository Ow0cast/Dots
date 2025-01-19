{ config, pkgs, ... }: {
  # Create the user
  athena.user.enable = true;
  # Configure the network
  athena.network.enable = true;
  # Configure desktop
  athena.desktop.enable = true;
  athena.terminal.enable = true;
  # Configure misc. programs
  athena.programs.git.enable = true;

  # The greatest font known to man
  home.packages = [ pkgs."maple-mono-NF" ];

  system.stateVersion = "24.11";
}