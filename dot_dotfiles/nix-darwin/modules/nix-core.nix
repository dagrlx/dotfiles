{ pkgs, lib, ... }:

{
  # enable flakes globally
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Permite paquetes rotos
  #nixpkgs.config.allowBroken = true;

  nix.package = pkgs.nixVersions.latest;
  #nix.package = pkgs.nixVersions.nix_2_21;

  programs.nix-index.enable = true;

  # do garbage collection weekly to keep disk usage low
  nix.gc = {
    automatic = lib.mkDefault true;
    #dates = "weekly";
    # If using nix-darwin, use this to run on 0th day of every week:
    interval = { Weekday = 0; Hour = 0; Minute = 0; };
    options = lib.mkDefault "--delete-older-than 7d";
  };

  # Manual optimise storage: nix-store --optimise
  # https://nixos.org/manual/nix/stable/command-ref/conf-file.html#conf-auto-optimise-store
  # Disable auto-optimise-store because of this issue:
  #   https://github.com/NixOS/nix/issues/7273
  # "error: cannot link '/nix/store/.tmp-link-xxxxx-xxxxx' to '/nix/store/.links/xxxx': File exists
  # (see https://github.com/NixOS/nix/issues/7273#issuecomment-2295429401)
  # Tip This option only applies to new files, so we recommend manually optimising your nix store when first setting this option.
  nix.optimise = {
        automatic = true;
        interval = [ 
            {
                Hour = 8;
                Minute = 30;
                Weekday = 7;
            }
        ];
    };

  # The store can be optimised during every build.
  # If true, this may slow down builds, as discussedc here https://github.com/NixOS/nix/issues/6033
  nix.settings = { auto-optimise-store = false; };

  # Turn off NIX_PATH warnings now that we're using flakes
  #system.checks.verifyNixPath = false;
}
