{pkgs, ...}:
###################################################################################
#
#  macOS's System configuration
#
#  All the configuration options are documented here:
#    https://daiderd.com/nix-darwin/manual/index.html#sec-options
#
###################################################################################
{
  system = {
    stateVersion = 4;
    # activationScripts are executed every time you boot the system or run `nixos-rebuild` / `darwin-rebuild`.
    activationScripts.postUserActivation.text = ''
      # activateSettings -u will reload the settings from the database and apply them to the current session,
      # so we do not need to logout and login again to make the changes take effect.
      /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
    '';

    defaults = {
      menuExtraClock.Show24Hour = true; # show 24 hour clock

      # customize dock
      dock = {
        autohide = true;
        orientation = "bottom";
        showhidden = true;
        show-recents = false; # disable recent apps
        tilesize = 40;
        enable-spring-load-actions-on-all-items = true;
        appswitcher-all-displays = true;
        expose-group-by-app = false; #Agrupa ventana por aplicació (Opción desactivada para mejora de yabai)
        mru-spaces = false; # Agrupa spaces auto en función del uso mas reciente (Opción desactivada para yabai)
        magnification = false; #Resalta icono cuando se posiciona sobre el
      };

      # customize finder
      finder = {
        _FXShowPosixPathInTitle = true; # show full path in finder title
        AppleShowAllFiles = true; #Muestra siempre los archivos ocultos
        AppleShowAllExtensions = true; # show all file extensions
        FXEnableExtensionChangeWarning = false; # disable warning when changing file extension
        FXPreferredViewStyle = "Nlsv"; # Vista por defecto modo lista
        FXDefaultSearchScope = "SCcf"; #Busca en el directorio actual
        QuitMenuItem = true; # enable quit menu item
        ShowPathbar = true; # show path bar
        ShowStatusBar = true; # show status bar
      };

      # customize trackpad
      trackpad = {
        # tap-  touchpad, click
        Clicking = true; # enable tap to click(Tocar el touchpad equivale a hacer clic)
        TrackpadRightClick = true; # enable two finger right click
        #TrackpadThreeFingerDrag = true; # enable three finger drag
      };

      # customize macOS
      NSGlobalDomain = {
        # `defaults read NSGlobalDomain "xxx"`
        "com.apple.swipescrolldirection" = true; # enable natural scrolling(default to true)
        "com.apple.sound.beep.feedback" = 0; # disable beep sound when pressing volume up/down key
        #AppleInterfaceStyle = "Dark"; # dark mode
        AppleInterfaceStyleSwitchesAutomatically = true;
        AppleKeyboardUIMode = 3; # Mode 3 enables full keyboard control.
        #ApplePressAndHoldEnabled = true; # enable press and hold
      };

      # Customize settings that not supported by nix-darwin directly
      # see the source code of this project to get more undocumented options:
      #    https://github.com/rgcr/m-cli
      #
      # All custom entries can be found by running `defaults read` command.
      # or `defaults read xxx` to read a specific domain.
      CustomUserPreferences = {
        "com.apple.finder" = {
          ShowExternalHardDrivesOnDesktop = true;
          ShowHardDrivesOnDesktop = false;
          ShowMountedServersOnDesktop = false;
          ShowRemovableMediaOnDesktop = true;
          _FXSortFoldersFirst = true;
          # When performing a search, search the current folder by default
          FXDefaultSearchScope = "SCcf";
        };

        "com.apple.desktopservices" = {
          # Avoid creating .DS_Store files on network or USB volumes
          DSDontWriteNetworkStores = true;
          DSDontWriteUSBStores = true;
        };

        "com.apple.screensaver" = {
          # Require password immediately after sleep or screen saver begins
          askForPassword = 1;
          askForPasswordDelay = 0;
        };

        "com.apple.screencapture" = {
          location = "~/Desktop/captures";
          type = "png";
        };

        # Deshabilita la publicidad personalizada de Apple.
        "com.apple.AdLib" = {
          allowApplePersonalizedAdvertising = false;
          forceLimitAdTracking = true;
          allowIdentifierForAdvertising = false;
        };
        # Prevent Photos from opening automatically when devices are plugged in
        "com.apple.ImageCapture".disableHotPlug = true;
      };

      loginwindow = {
        GuestEnabled = false; # disable guest user
        SHOWFULLNAME = true; # Muestra campos de usuario y passwd en vez de lista de usuario en la pantalla login 
      };
    };
  };

  # Add ability to used TouchID for sudo authentication
  security.pam.enableSudoTouchIdAuth = true;

  # Create /etc/zshrc that len oads the nix-darwin environment.
  # this is required if you want to use darwin's default shell - zsh
  programs.zsh.enable = true;
  environment.shells = [
    pkgs.zsh
  ];
}
