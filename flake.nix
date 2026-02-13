{
  description = "Your new nix config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # You can access packages and modules from different nixpkgs revs
    # at the same time. Here's an working example:
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.11";
    # Also see the 'stable-packages' overlay at 'overlays/default.nix'.

    # Home manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # #Nixvim
    # nixvim = {
    #   # For unstable
    #   url = "github:nix-community/nixvim";
    #   # url = "github:nix-community/nixvim/nixos-25.11";

    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    #awww (way better name)
    awww = {
      url = "git+https://codeberg.org/LGFae/awww";
    };

    nix-citizen.url = "github:LovingMelody/nix-citizen";

    st = {
      url = "github:miztaoak/st";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      st,
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
        nixos-laptop = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [
            # > Our main nixos configuration file <
            ./nixos/configuration.nix
            # Laptop specific config
            ./nixos/nixos-laptop/laptop.nix

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
        nixos-desktop = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [
            # > Our main nixos config file <
            ./nixos/configuration.nix
            #Desktop specific config
            ./nixos/nixos-desktop/desktop.nix
            ./nixos/nixos-desktop/hardware-configuration.nix

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
