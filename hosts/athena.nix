{ config, pkgs, ... }: {
  imports = [ # Include the results of the hardware scan. 🗣🔥
    ./athena-hw.nix
  ];
  
  # Create the user
  athena.user.enable = true;
  # Configure the network
  athena.network.enable = true;
  # Configure desktop
  athena.desktop.enable = true;
  athena.terminal.enable = true;

  # The greatest font known to man
  home.packages = [ pkgs."maple-mono-NF" ];

  system.stateVersion = "24.11";
}