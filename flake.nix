<<<<<<< HEAD
# cached failures: 9
{
  description = "it's reproducible guys!!!";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
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
        salad = nixpkgs.lib.nixosSystem {
          inherit specialArgs;
          modules = [
            { nixpkgs.overlays = [ nur.overlay ]; }
            nur.nixosModules.nur
            home-manager.nixosModules.home-manager
            ./modules/nixos
            ./hosts/salad
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.owuh = import ./home/owuh/salad.nix;
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
        "owuh@salad" = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs { system = "x86_64-linux"; };
          modules = [
            ./modules/home
            ./home/owuh
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
=======
{
  description = "Ow0cast's nix config - https://github.com/ow0cast/nix";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { self, nixpkgs, home-manager, ... }: {
    nixosConfigurations.athena = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      specialArgs = { inherit inputs; };
      modules = [
        ./modules/athena/nixos
        ./modules/home-manager.nix
      ];
    };

    homeConfigurations = {
      "nikki@athena" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs { system = "x86_64-linux"; };
        modules = [
          ./modules/athena/home
        ];
      };
    };
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;
  };
}
>>>>>>> c7391e3 (redo shit)
