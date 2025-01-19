{ config, lib, pkgs, ... }:
let
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in
{
  boot = {
    initrd.kernelModules = [
      "vfio"
      "vfio_pci"
      "nvidia"
      "nvidia_modeset"
      "nvidia_uvm"
    ];

    kernelParams = [
      "video=vesafb:off,efifb:off"
    ];
    kernelPackages = unstable.linuxPackages_latest;
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.opengl = {
    enable = true;
    #	driSupport = true;
  };

  hardware.nvidia = {
    modesetting.enable = true;
    open = false;
    package = config.boot.kernelPackages.nvidiaPackages.beta;
  };
}
