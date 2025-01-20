{ pkgs, ... }: {
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
    just # use Justfile to simplify nix-darwin's commands
  ];

  environment.variables.EDITOR = "nvim";

  # TODO To make this work, homebrew need to be installed manually, see https://brew.sh
  #
  # The apps installed by homebrew are not managed by nix, and not reproducible!
  # But on macOS, homebrew has a much larger selection of apps than nixpkgs, especially for GUI apps!
  homebrew = {
    brewPrefix = "/opt/homebrew/bin";
    enable = true;
    #macOS pone en cuarentena las aplicaciones descargadas de internet para mayor seguridad.
    #caskArgs.no_quarantine = true;

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
      #"WireGuard" = 1451685025;
      #"Tomito" = 1526042937;
      #"Windows App" = 1295203466;
      #"CotEditor" = 1024640650;
      #"MegaIPTVmacOS" = 1494386779;
      #"Airmail" = 918858936;
      #"Magnet" = 441258766;
      #"ScreenBrush" = 1233965871;
      #"Amphetamine" = 937984704;
      "The Unarchiver" = 425424353;
      #"You Search" = 1641136636;
    };

    taps = [
      "homebrew/services"
      #"romkatv/powerlevel10k"
      "jzelinskie/duckdns"
      "koekeishiya/formulae"
      "FelixKratz/formulae"
      "siderolabs/tap"
      "gromgit/fuse"
      "pkgxdev/made"
      "localsend/localsend"
      "nikitabobko/tap"
      "netbirdio/tap"
      "alienator88/cask"
      "olets/tap"
      "lihaoyun6/tap"
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
      "podlet"

      #"sesh" # session manager for tmux

      #"zsh-autocomplete"
      #"zsh-autosuggestions"
      "zsh-autosuggestions-abbreviations-strategy"

      "neovim"
      "luacheck"

      "yazi" # file manager
      "poppler" # para PDF preview en yazi
      "rich-cli" # for yazi plugin rich-preview

      ##Tiling windows manager
      #"yabai"
      #"skhd"
      "sketchybar"

      "lua" # Lenguaje para config sketchybar, aerospace
      #"lua-language-server"
      "rust"
      "switchaudio-osx"
      "nowplaying-cli"
      "borders"
      "fastfetch" # Reemplazo neofecht

      #"starship"

      "nushell"
      "the_silver_searcher" # A code searching tool similar to ack, with a focus on speed.
      #"jq" # Se usa en yabai - Lightweight and flexible command-line JSON processor
      "gh" # Se usa en pluing git sketchybar
      "btop" # monitoreo de recursos
      "sshs" # List and connect to hosts using ~/.ssh/config.

      #control versiones dotfiles
      "chezmoi"
      #"yadm"
      "age" # Is a simple, modern and secure file encryption tool, format, and Go library.
      #"atuin" # Shell history with SQLite

      #"talosctl"
      #"ntfs-3g-mac"

      #"pkgx" # Alternativa a hombrew
      "thefuck" # magnificent app that corrects your previous console command.

      "tabiew" # Lector de archvio csv con consultas sql"
    ];

    # `brew install --cask`
    # TODO Feel free to add your favorite apps here.
    casks = [

      "firefox"
      "zen-browser"
      #"google-chrome"
      #"brave-browser"
      #{
      #  name = "microsoft-edge";
      #  greedy = true;
      #}
      # always upgrade auto-updated or unversioned cask to latest version even if already installed
      #{
      #  name = "opera";
      #  greedy = true;
      #}
      {
        name = "deepl";
        greedy = true;
      }

      "vivaldi"
      #"visual-studio-code"
      "zed"
      "microsoft-teams"
      "microsoft-auto-update"
      "windows-app" # new app for RDP
      "syncthing" # file sync
      "raycast" # (HotKey: alt/option + space)search, caculate and run scripts(with many plugins)
      #"iglance" # beautiful system monitor
      "macfuse"
      "mounty"
     
      "vnc-viewer"

      #VPN
      "zerotier-one"
      "tailscale"
      "netbird-ui"

      # Utilities
      "localsend"
      "landrop"
      "keka"
      "KnockKnock"
      #"kopiaui"
      #"kubecontext"
      "maintenance"
      "onyx"
      "deeper"
      #"tyke" # App para tomar notas rapidas temporal
      #"applite" # App grafica homebrew - https://www.thriftmac.com
      "google-drive"

      "aerospace" # Tiling manager basado en i3wm
      "MonitorControl"
      "pearcleaner" # mac app cleaner
      "sentinel-app" # A GUI for controlling Gatekeeper
      "ubersicht"

      #Terminales
      "wezterm"
      #"warp" # terminal con AI y wrapper
      #"wave" # terminal con AI alternativa a warp y es software libre
      "ghostty" # Ghostty is a terminal emulator that differentiates itself by being fast, feature-rich, and native.
      "kitty"

      "keepassxc"
      "podman-desktop"
      #"devpod" # desarrollo en container
      #"slack"
      "teamviewer"
      "anydesk"
      "orbstack" # Docker y MV
      "appcleaner"
      #"diffusionbee" # Create Amazing Images Using AI
      #"authy"
      #"utm"
      "numi" # calculadora
      #"stats"
      #"neovide"
      #"amazon-chime"
      "qbittorrent"
      #"send-anywhere"
      #"remote-desktop-manager"

      "telegram"
      "whatsapp"
      "zoom"

      #"wireshark" # network analyzer
      "grandperspective" # Muestra de forma grafica el uso del disco
      "keycastr" # Muestra la pulsación de las teclas en pantalla
      "hyperkey"
      "karabiner-elements" # Permite modificar/crear teclado y combinaciones de teclas
      "vlc"
      "keyclu" # Muestra la lista de shortcut de las aplicaciones que se seleccione
      "cleanupbuddy" # Bloque teclado y mouse para poder hacer limpieza a la mac
      "displaylink"
      "obsidian"
      #"jordanbaird-ice" # Menu bar - Equivalente a bartender
      "tomatobar"
      #"kap"
      #"cap"
      #"spaceman"
      #"raspberry-pi-imager"
      "quickrecorder" # record screen
      "shottr"

      "font-sketchybar-app-font" # apps icons

      #Fonts for sketchybar, wezterm        
      "font-hack-nerd-font" # Font for sketchybar
      "font-sf-pro" # Simbolos
      "sf-symbols" # iconos
      "font-sf-mono"
      "font-blex-mono-nerd-font"

      #"fly" # Command line interface to Concourse CI
    ];
  };
}
