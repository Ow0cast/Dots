{ pkgs, ... }:

{
  home.username = "nikki";
  home.homeDirectory = "/home/nikki";

  home.packages = [ pkgs."maple-mono-NF" ];

  home.stateVersion = "24.11";

  programs.home-manager.enable = true;

  stupid.terminal.enable = true;
  stupid.desktop.enable = true;
  stupid.browser.enable = true;
  #programs.firefox.enable = true;

  programs.git = {
    enable = true;
    userName = "owuh";
    userEmail = "owuh@wayland.best";
    extraConfig.init.defaultBranch = "main";
  };
}
