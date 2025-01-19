# cached failures: 9
{
  description = "it's reproducible guys!!!";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = github:nix-community/NUR;
  };

  outputs = inputs:
    with inputs;
    let
      specialArgs = { inherit inputs self nur; };
    in
    {
      nixosConfigurations = {
        athena = nixpkgs.lib.nixosSystem {
          inherit specialArgs;
          modules = [
            { nixpkgs.overlays = [ nur.overlay ]; }
            nur.nixosModules.nur
            home-manager.nixosModules.home-manager
            ./modules/nixos
            ./hosts/athena
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.nikki = import ./home/nikki/athena.nix;
              home-manager.extraSpecialArgs = specialArgs;
            }
          ];
        };
        box = nixpkgs.lib.nixosSystem {
          inherit specialArgs;
          modules = [
            { nixpkgs.overlays = [ nur.overlay ]; }
            nur.nixosModules.nur
            home-manager.nixosModules.home-manager
            ./modules/nixos
            ./hosts/box
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.sysadmin = import ./home/sysadmin/box.nix;
              home-manager.extraSpecialArgs = specialArgs;
            }
          ];
        };
      };

      homeConfigurations = {
        "nikki@athena" = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs { system = "x86_64-linux"; };
          modules = [
            ./modules/home
            ./home/nikki
          ];
        };
        "sysadmin@box" = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs { system = "x86_64-linux"; };
          modules = [
            ./modules/home
            ./home/sysadmin
          ];
        };
      };
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;
    };
}
