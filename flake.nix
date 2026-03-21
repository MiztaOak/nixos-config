{
  description = "Your new nix config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.11";

    # Home manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    #awww (way better name)
    awww = {
      url = "git+https://codeberg.org/LGFae/awww";
    };

    nix-citizen.url = "github:LovingMelody/nix-citizen";

    # st = {
    #   url = "github:miztaoak/st";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    mango = {
      url = "github:mangowm/mango";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      inherit (self) outputs;
      # Supported systems for your flake packages, shell, etc.
      system = "x86_64-linux";
    in
    {
      # Your custom packages
      # Accessible through 'nix build', 'nix shell', etc
      packages = import ./pkgs nixpkgs.legacyPackages.${system};
      # Formatter for your nix files, available through 'nix fmt'
      # Other options beside 'alejandra' include 'nixpkgs-fmt'
      formatter = nixpkgs.legacyPackages.${system}.nixpkgs-fmt;

      # Your custom packages and modifications, exported as overlays
      overlays = import ./overlays { inherit inputs system; };
      # Reusable nixos modules you might want to export
      # These are usually stuff you would upstream into nixpkgs
      nixosModules = import ./modules/nixos;
      # Reusable home-manager modules you might want to export
      # These are usually stuff you would upstream into home-manager
      homeManagerModules = import ./modules/home-manager;

      # NixOS configuration entrypoint
      # Available through 'nixos-rebuild --flake .#your-hostname'
      nixosConfigurations = {
        nixos-desktop = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [
            # > Our main nixos config file <
            ./nixos/configuration.nix
            #Desktop specific config
            ./nixos/nixos-desktop/desktop.nix
            ./nixos/nixos-desktop/hardware-configuration.nix

            inputs.mango.nixosModules.mango

            home-manager.nixosModules.home-manager
            {
              home-manager.users.goaty =
                { ... }:
                {
                  imports = [
                    ./home-manager/home.nix
                  ];
                };
              home-manager.extraSpecialArgs = { inherit inputs outputs; };
            }
          ];
        };
      };
    };
}
