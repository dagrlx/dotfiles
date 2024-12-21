{ username, config, ... }:

let
  homeDirectory = "/Users/${username}";
  dotfilesPath = "${homeDirectory}/dotfiles";

in {
  # import sub modules
  imports = [
    ./zsh.nix
    ./core.nix
    #./git.nix
    #./starship.nix
  ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = {
    username = username;
    homeDirectory = "/Users/${username}";

    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    stateVersion = "24.05";
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'. (https://seroperson.me/2024/01/16/managing-dotfiles-with-nix/)
  home.file = {

    #".config/tmux".source = config.lib.file.mkOutOfStoreSymlink "/Users/dgarciar/.config/nix-darwin/home/dotfiles/tmux";
  };

  xdg.configFile = {
    "nvim" = {
      source = config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/nvim";
      recursive = true;
    };

    "starship" = {
      source = config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/startship";
      recursive = true;
    };

    "tmux" = {
      source = config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/tmux";
      recursive = true;
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
