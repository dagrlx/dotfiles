{pkgs, ...}: {
  ##########################################################################
  #
  #  Install all apps and packages here.
  #
  #  NOTE: Your can find all available options in:
  #    https://daiderd.com/nix-darwin/manual/index.html
  #
  # TODO Fell free to modify this file to fit your needs.
  #
  ##########################################################################

  # Install packages from nix's official package repository.
  #
  # The packages installed here are available to all users, and are reproducible across machines, and are rollbackable.
  # But on macOS, it's less stable than homebrew.
  #
  # Related Discussion: https://discourse.nixos.org/t/darwin-again/29331
  environment.systemPackages = with pkgs; [
    git
    #lf  #Configurado en core.nix
  ];

   # Cambios derivados de actualizacion en nix-darwin inestable
  fonts = {
  packages = with pkgs; [
    source-code-pro
    font-awesome
    (nerdfonts.override {
      fonts = [
        "JetBrainsMono"
        #"FiraCode"
      ];
    })
  ];
};

#  fonts = {
#    # Fonts
#    fontDir.enable = true;
#    fonts = with pkgs; [
#      source-code-pro
#      font-awesome
#      (nerdfonts.override {
#        fonts = [
#          "JetBrainsMono"
#          #"FiraCode"
#        ];
#      })
 #   ];
  #};

  environment.variables.EDITOR = "nvim";

  # TODO To make this work, homebrew need to be installed manually, see https://brew.sh
  #
  # The apps installed by homebrew are not managed by nix, and not reproducible!
  # But on macOS, homebrew has a much larger selection of apps than nixpkgs, especially for GUI apps!
  homebrew = {
    enable = true;

    onActivation = { 
      # Controla si Homebrew se auto-actualiza a sí mismo y a todas las fórmulas durante la activación del sistema
      # Nix-darwin
      autoUpdate = true;
      # Controla si se deben actualizar las fórmulas de Homebrew durante la activación del sistema Nix-darwin.
      upgrade = true;
      # 'zap': uninstalls all formulae(and related files) not listed here.
      cleanup = "zap";
    };

    # Applications to install from Mac App Store using mas.
    # You need to install all these Apps manually first so that your apple account have records for them.
    # otherwise Apple Store will refuse to install them.
    # For details, see https://github.com/mas-cli/mas
    masApps = {
      # TODO Feel free to add your favorite apps here.

      #Xcode = 497799835;
      "Little Snitch Mini" = 1629008763;
      "WireGuard" = 1451685025;
      #"Tomito" = 1526042937;
      "Microsoft Remote Desktop" = 1295203466;
      "CotEditor" = 1024640650;
      "MegaIPTVmacOS" = 1494386779;
      #"Airmail" = 918858936;
      "Magnet" = 441258766;
      "ScreenBrush" = 1233965871;
      "Amphetamine" = 937984704;
      "The Unarchiver" = 425424353;
      #"You Search" = 1641136636;
    };

    taps = [
      #"homebrew/cask"  #Ya no es necesario en homebrew
      #"homebrew/cask-fonts" # tag depreciado
      "homebrew/services"
      #"homebrew/cask-versions"  # tap depreciado
      #"romkatv/powerlevel10k"
      "jzelinskie/duckdns"
      "koekeishiya/formulae"
      "FelixKratz/formulae"
      "siderolabs/tap"
      "gromgit/fuse"
      "pkgxdev/made"
      "localsend/localsend"
      "nikitabobko/tap"
    ];

    # `brew install`
    # TODO Feel free to add your favorite apps here.
    brews = [
      "wget" # download tool
      "curl" # no not install curl via nixpkgs, it's not working well on macOS!
      "aria2" # download tool
      "httpie" # http client
      "duckdns"
      "podman"

      "yazi"  #file manager 
      "poppler"  #para PDF preview en yazi

      ##Tiling windows manager
      #"yabai"
      #"skhd"
      "sketchybar"
      "lua"
      "switchaudio-osx"
      "nowplaying-cli"
      "borders"

      "nushell"
      "the_silver_searcher" #A code searching tool similar to ack, with a focus on speed.
      "jq" #Se usa en yabai - Lightweight and flexible command-line JSON processor
      "gh" #Se usa en pluing git sketchybar
      "btop" #monitoreo de recursos

      #control versiones dotfiles
      "chezmoi"
      #"yadm"

      #"talosctl"
      "ntfs-3g-mac"

      "pkgx"  # Alternativa a hombrew
      #"thefuck"  #magnificent app that corrects your previous console command.
    ];

    # `brew install --cask`
    # TODO Feel free to add your favorite apps here.
    casks = [
      "firefox"
      #"google-chrome"
      "google-drive"
      "brave-browser"
      #{
      #  name = "microsoft-edge";
      #  greedy = true;
      #}
      # always upgrade auto-updated or unversioned cask to latest version even if already installed
      #{
      #  name = "opera";
      #  greedy = true;
      #}
      #"vivaldi"
      "visual-studio-code"
      "zed"
      "microsoft-remote-desktop"
      "microsoft-teams"
      "syncthing" # file sync
      "raycast" # (HotKey: alt/option + space)search, caculate and run scripts(with many plugins)
      "iglance" # beautiful system monitor
      "mounty"
      "macfuse"
      "vnc-viewer"

      #VPN
      "zerotier-one"
      "tailscale"

      "localsend"
      "landrop"
      "keka"
      #"deepl"
      "KnockKnock"
      "kopiaui"
      "kubecontext"
      "maintenance"
      "onyx"
      "deeper"       
      "tyke"         # App para tomar notas rapidas temporal 
      "applite"       # App grafica homebrew - https://www.thriftmac.com

      "aerospace"    # Tiling manager basado en i3wm 

      #Terminales
      "iterm2"
      "wezterm"
      #"kitty"
      "warp" #terminal con AI y wrapper
      "wave" #terminal con AI alternativa a warp y es software libre
      #"tabby" #Otro Terminal 
      #"rio"

      "keepassxc"
      "podman-desktop"
      "slack"
      "teamviewer"
      "anydesk"
      "orbstack" # Docker y MV
      "appcleaner"
      "diffusionbee" # Create Amazing Images Using AI
      #"authy"
      "utm"
      "numi" # calculadora
      "stats"
      #"neovide"
      #"amazon-chime"
      "qbittorrent"
      "send-anywhere"
      #"remote-desktop-manager"
      "telegram"
      #"wireshark" # network analyzer
      "grandperspective" # Muestra de forma grafica el uso del disco
      "keycastr" #Muestra la pulsación de las teclas en pantalla
      "hyperkey"
      "karabiner-elements" #Permite modificar/crear teclado y combinaciones de teclas 
      "vlc"
      "keyclu" #Muestra la lista de shortcut de las aplicaciones que se seleccione
      "cleanupbuddy" #Bloque teclado y mouse para poder hacer limpieza a la mac
      #"displaylink"
      "obsidian"
      "jordanbaird-ice" # Menu bar - Equivalente a bartender
      "tomatobar"
      "kap"
      #"spaceman"

      #Fonts for sketchybar
      "font-hack-nerd-font" #Font for sketchybar
      "font-sf-pro" #Simbolos
      "sf-symbols" #iconos
      "font-sf-mono"

      "fly"  #Command line interface to Concourse CI
    ];
  };
}