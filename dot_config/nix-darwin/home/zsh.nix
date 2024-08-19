{pkgs, ...}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;  # Habilita las sugerencias de autocompletado
    syntaxHighlighting.enable = true;  # Habilita el resaltado de sintaxis
    syntaxHighlighting.highlighters = [ "brackets" ];

    #initExtra = builtins.readFile ./zshrc;

    #initExtraFirst = "  # Commands that should be added to top of {file}.zshrc.
    #";

    initExtra = ''

      # Cargar funciones desde el archivo
      source ~/.config/nix-darwin/home/zsh_func

      # Agregar pkgx al PATH y cargar su configuración
      source <(pkgx --shellcode)
      #eval "$(pkgx integrate)"

      # Integracion de thefuck
      eval $(thefuck --alias)

      [ -n "$WEZTERM_PANE" ] && export NVIM_LISTEN_ADDRESS="/tmp/nvim$WEZTERM_PANE"

      export HOSTNAME=$(hostname)

      '';

    shellAliases = {
      rustscan = "docker run -it --rm --name rustscan --platform linux/amd64 rustscan/rustscan";
      "..." = "cd ../..";
      update = "darwin-rebuild switch --flake ~/.config/nix-darwin/";
      uflake = "nix flake update --flake ~/.config/nix-darwin";
      ngc = "nix-collect-garbage -d";
      sgc = "sudo nix-collect-garbage -d";
      bcp0 = "brew cleanup --prune=0";
      flushdns = "sudo dscacheutil -flushcache && sudo killall -HUP mDNSResponder";
      allow_app = "codesign --sign - --force --deep @$ && xattr -d com.apple.quarantine @$"; #Para de-quarantine un app de MacOS
      n = "nano -clS";
      fzn="fzf --preview 'bat --style=numbers --color=always {}' | xargs -n1 nvim";
      sshp="ssh -o ProxyJump=sabaext";

      urldecode = "python3 -c 'import sys, urllib.parse as ul; print(ul.unquote_plus(sys.stdin.read()))'";
      urlencode = "python3 -c 'import sys, urllib.parse as ul; print(ul.quote_plus(sys.stdin.read()))'";

    };

    history = {
      size = 10000;
      ignoreDups = true; #Ignora duplicados
      #ignoreAllDups = true; # NO almacenar duplicados ** Investigar porque indica que opcion no existe para Macos
      ignoreSpace = true; #Elimina del historial los comandos que empiecen con un espacio
      extended = true; # Guarda el timestamp
      share = true; #Comparte el historial de comando entre sesiones
      expireDuplicatesFirst = true; #elimina los duplicados primero.
    };

    # oh-my-zsh = {
    #   enable = true;
    #   plugins = [
    #     "git" "sudo" "tmux" "docker" "kubectl" "direnv" "brew" "minikube" "fzf" "aliases" "vscode"];
    #   theme = "strug"; #robbyrussell
    #   #theme = "robbyrussell";
    # };

#    initExtra = "eval \"\$(zoxide init zsh)\"";

  };
}
