{
  pkgs,
  lib,
  ...
}: {
  # enable flakes globally
  nix.settings.experimental-features = ["nix-command" "flakes" "auto-allocate-uids"];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Permite paquetes rotos
  #nixpkgs.config.allowBroken = true;

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # Use this instead of services.nix-daemon.enable if you
  # don't wan't the daemon service to be managed for you.
  nix.useDaemon = true;

  #nix.package = pkgs.nix;
  nix.package = pkgs.nixVersions.latest;
  #nix.package = pkgs.nixVersions.nix_2_21;

  programs.nix-index.enable = true;

  # do garbage collection weekly to keep disk usage low
  nix.gc = {
    automatic = lib.mkDefault true;
    options = lib.mkDefault "--delete-older-than 1w";
  };

  # Manual optimise storage: nix-store --optimise
  # https://nixos.org/manual/nix/stable/command-ref/conf-file.html#conf-auto-optimise-store
  nix.settings.auto-optimise-store = true;

  # Turn off NIX_PATH warnings now that we're using flakes
  system.checks.verifyNixPath = false;
}
