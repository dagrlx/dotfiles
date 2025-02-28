# Nushell Config File

$env.config.edit_mode = "vi"
$env.config.show_banner = "short"

#$env.config.buffer_editor = "nvim"

# Lista archivos y directorios en formato árbol con detalles
alias lt = eza --tree --level=2 --long --icons --git

# Actualizacion hombrew 
alias brew-up = do { brew update; brew upgrade; brew upgrade --cask --greedy }

# Actualizacion de nix
alias ufn = do { nix flake update --flake ~/.dotfiles/nix-darwin --verbose }
# Actualizacion de nix-darwin
alias ufd = do { darwin-rebuild switch --flake ~/.dotfiles/nix-darwin/ --verbose }

alias sshp =  ^ssh -o ProxyJump=sabaext

# def show-alias [] {
#     echo "=== Aliases ==="
#     scope aliases
#     echo "\n=== Funciones definidas ==="
#      open ~/.dotfiles/nushell/functions.nu
#}

source ~/.dotfiles/nushell/zoxide.nu
 
source ~/.cache/carapace/init.nu

# Config for use of atuin
source ~/.local/share/atuin/init.nu

# Cargar funciones complejas desde un archivo externo
source ~/.dotfiles/nushell/functions.nu

# Shell integration for aichat
source ~/.dotfiles/nushell/aichat_shell.nu

# autocompletation for aichat
source ~/.dotfiles/nushell/aichat_cmp.nu

# Broot file manager
source ~/.dotfiles/nushell/broot_shell.nu

### Config starship
# mkdir ~/.cache/starship
# starship init nu | save -f ~/.cache/starship/init.nu
# use ~/.cache/starship/init.nu

mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")

