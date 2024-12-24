# Nushell Config File

use ~/.cache/starship/init.nu

source ~/.zoxide.nu

source ~/.cache/carapace/init.nu

#### Aliases ####
alias lt = eza --tree --level=2 --long --icons --git

# def show-alias [] {
#     echo "=== Aliases ==="
#     scope aliases
#     echo "\n=== Funciones definidas ==="
#      open ~/.dotfiles/nushell/functions.nu
#}

# Cargar funciones complejas desde un archivo externo
source ~/.dotfiles/nushell/functions.nu
