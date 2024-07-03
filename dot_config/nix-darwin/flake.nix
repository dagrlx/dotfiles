{
  description = "Nix for macOS configuration";

  ##################################################################################################################
  #
  # Want to know Nix in details? Looking for a beginner-friendly tutorial?
  # Check out https://github.com/ryan4yin/nixos-and-flakes-book !
  #
  ##################################################################################################################

  # the nixConfig here only affects the flake itself, not the system configuration!
  nixConfig = {
    experimental-features = ["nix-command" "flakes" "auto-allocate-uids"];

    #substituters = [
    # Replace official cache with a mirror located in China
    #
    # Feel free to remove this line if you are not in China
    #"https://cache.nixos.org"
    #];
  };

  # This is the standard format for flake.nix. `inputs` are the dependencies of the flake,
  # Each item in `inputs` will be passed as a parameter to the `outputs` function after being pulled and built.
  # repositorio nixpkgs-unstable es rolling release
  inputs = {
    #nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-24.05-darwin";
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    # home-manager, used for managing user configuration
    home-manager = {
      #url = "github:nix-community/home-manager/release-24.05";
      url = "github:nix-community/home-manager";
      # The `follows` keyword in inputs is used for inheritance.
      # Here, `inputs.nixpkgs` of home-manager is kept consistent with the `inputs.nixpkgs` of the current flake,
      # to avoid problems caused by different versions of nixpkgs dependencies.
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  # The `outputs` function will return all the build results of the flake.
  # A flake can have many use cases and different types of outputs,
  # parameters in `outputs` are defined in `inputs` and can be referenced by their names.
  # However, `self` is an exception, this special parameter points to the `outputs` itself (self-reference)
  # The `@` syntax here is used to alias the attribute set of the inputs's parameter, making it convenient to use inside the function.

  outputs = inputs @ {
    self,
    nixpkgs,
    darwin,
    home-manager,
    ...
  }: {
    # TODO please update the whole "your-hostname" placeholder string to your own hostname!
    # such as darwinConfigurations.mymac = darwin.lib.darwinSystem {
    darwinConfigurations."enocm1" = darwin.lib.darwinSystem {
      system = "aarch64-darwin"; # change this to "aarch64-darwin" if you are using Apple Silicon
      pkgs = nixpkgs.legacyPackages.aarch64-darwin;
      #pkgs = import nixpkgs {
      #  system = "aarch64-darwin";
        #config.allowBroken = true; # Aquí es donde se establece allowBroken
      #};
      modules = [
        ./modules/nix-core.nix
        ./modules/system.nix
        ./modules/apps.nix
        #./modules/tiling-wm.nix
        ./modules/host-users.nix

        # home manager
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = inputs;

          # TODO replace "yourusername" with your own username!
          home-manager.users.dgarciar = import ./home;
        }
      ];
    };

    # Define defaultPackage and packages for aarch64-darwin
    defaultPackage.aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.alejandra;
    packages.aarch64-darwin = {
      default = nixpkgs.legacyPackages.aarch64-darwin.alejandra;
      hydra-check = nixpkgs.legacyPackages.aarch64-darwin.hydra-check;
    };

    # nix code formatter
    # TODO also change this line to "aarch64-darwin" if you are using Apple Silicon
    formatter.aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.alejandra;
  };
}
