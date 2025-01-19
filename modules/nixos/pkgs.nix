{ config, lib, pkgs, ... }:
let
  inherit (lib)
    mkEnableOption
    mkIf
    ;

  cfg = config.stupid.pkgs;
in
{
  options.stupid.pkgs = {
    enable = mkEnableOption "config for nixpkgs";
  };

  config = mkIf cfg.enable {
    nixpkgs.config = {
      allowUnfree = true;
      packageOverrides = pkgs: {
        nur = import
          (builtins.fetchTarball {
            url = "https://github.com/nix-community/NUR/archive/b221a8e8493458bf33a754d86970bc656fdc43cc.tar.gz";
            sha256 = "18z3rg8gzh5mjjgs7b05llx6gc0gi39dq8msygrr9mn08cbxb7ab";
          })
          {
            inherit pkgs;
          };
      };
    };
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
  };
}
