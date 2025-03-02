# Nushell Config File
# Active mode vim
$env.config.edit_mode = "vi"
 
# Show only startup time  
$env.config.show_banner = "short"

# use_kitty_protocol (bool):
# A keyboard enhancement protocol supported by the Kitty Terminal. Additional keybindings are
# available when using this protocol in a supported terminal. For example, without this protocol,
# Ctrl+I is interpreted as the Tab Key. With this protocol, Ctrl+I and Tab can be mapped separately.
$env.config.use_kitty_protocol = true

#$env.config.buffer_editor = "nvim"

# Lista archivos y directorios en formato árbol con detalles
alias lt = eza --tree --level=2 --long --icons --git

# Actualizacion hombrew 
alias brew-up = do { brew update; brew upgrade; brew upgrade --cask --greedy }

# Actualizacion de nix
alias ufn = do { nix flake update --flake ~/.dotfiles/nix-darwin --verbose }

# Actualizacion de nix-darwin
alias ufd = do { darwin-rebuild switch --flake ~/.dotfiles/nix-darwin/ --verbose }

source ~/.dotfiles/nushell/zoxide.nu

# Caparace autocompletation
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

# Config starship
mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")

