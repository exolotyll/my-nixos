{
    description = "My NixOS Configuration";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { nixpkgs, home-manager }: let
        system = "x86_64-linux";
        pkgs = nixpkgs.legacyPackages.${system};
    in {
        nixosConfigurations = {
            victus = nixpkgs.lib.nixosSystem {
                inherit system;
                modules = [
                    ./system/configuration.nix
                ];
            };
        };

        homeConfigurations = {
            exolotyll = home-manager.lib.homeManagerConfiguration {
                inherit pkgs;
                modules = [
                    ./home-manager/home.nix
                ];
            };
        };
    };
}