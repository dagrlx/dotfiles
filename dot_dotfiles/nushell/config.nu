# Nushell Config File

use ~/.cache/starship/init.nu

source ~/.zoxide.nu

source ~/.cache/carapace/init.nu

#### Aliases ####
alias lt = eza --tree --level=2 --long --icons --git

def la [] {
    ls -la | select name type mode user group size modified | update modified {format date "%Y-%m-%d %H:%M:%S"}
}

def fzn [] {
    fzf --preview '''bat --style=numbers --color=always {}''' | xargs -n1 nvim
}

def ff [] {
    aerospace list-windows --all | fzf --bind 'enter:execute(bash -c "aerospace focus --window-id {1}")+abort'
}

