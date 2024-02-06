{ # salad.
# cached failures: 2
	description = "it's reproducible guys!!!";
	
	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
		home-manager = {
			url = "github:nix-community/home-manager/release-23.11";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = inputs:
		with inputs;
		let
			specialArgs = { inherit inputs self; };
		in
		{
			nixosConfigurations = {
				salad = nixpkgs.lib.nixosSystem {
					inherit specialArgs;
					modules = [
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
			};

			homeConfigurations = {
				"owuh@salad" = home-manager.lib.homeManagerConfiguration {
					pkgs = import nixpkgs { system = "x86_64-linux"; };
					modules = [
						./modules/home
						./home/owuh
					];
				};
			};
		};
}
