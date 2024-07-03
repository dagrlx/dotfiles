{pkgs, ...}: {
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;

    #initExtra = builtins.readFile ./zshrc;

    initExtra = ''
     
      # Cargar funciones desde el archivo
      source ~/.config/nix-darwin/home/zsh_func

      # Agregar pkgx al PATH y cargar su configuración
      source <(pkgx --shellcode)

      # Agregar tea al PATH
      #export PATH="$HOME/.local/bin:$HOME/.pkgx:$PATH"

       # Integración de pkgx
      #if command -v pkgx &> /dev/null; then
      #  source <(pkgx --shellcode)
      #fi

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

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git" "sudo" "tmux" "docker" "kubectl" "direnv" "brew" "minikube" "fzf" "aliases" "vscode"];
      theme = "strug"; #robbyrussell
      #theme = "robbyrussell";
    };

#    initExtra = "eval \"\$(zoxide init zsh)\"";

  };
}
