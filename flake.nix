{
  description = "it's reproducible guys";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-23.11";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs: with inputs;
  let
    pkgs = import nixpkgs {system = "x86_64-linux";};
    specialArgs = { inherit inputs self; };
  in
  {
    nixosConfigurations = {
      "itsreproducibleguys" = nixpkgs.lib.nixosSystem {
        inherit specialArgs;
        system = "x86_64-linux";
        modules = [./configuration.nix ./modules/nixos];
      };
    };
    homeConfigurations = {
      "dom@itsreproducibleguys" = home-manager.lib.homeManagerConfiguration {
        extraSpecialArgs = specialArgs;
        inherit pkgs;
	modules = [./modules/home ./home];
      };
   };
  };
}
