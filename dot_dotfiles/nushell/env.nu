# Nushell Environment Config File

# To load from a custom file you can use:
# source ($nu.default-config-dir | path join 'custom.nu')

# Config de path para homebrew
$env.PATH = ($env.PATH | split row (char esep) | prepend '/opt/homebrew/bin')

zoxide init nushell --cmd cd | save -f ~/.dotfiles/nushell/zoxide.nu

### Carapace config
$env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense' # optional
mkdir ~/.cache/carapace
carapace _carapace nushell | save --force ~/.cache/carapace/init.nu

