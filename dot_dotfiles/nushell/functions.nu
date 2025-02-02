# alias la =  ls -la | select name type mode user group size modified | update modified {format date "%Y-%m-%d %H:%M:%S"}
def la [] {
    ls -la | select name type mode user group size modified | update modified {format date "%Y-%m-%d %H:%M:%S"}
}

def fzn [] {
    fzf --preview '''bat --style=numbers --color=always {}''' | xargs -n1 nvim
}

def ff [] {
    aerospace list-windows --all | fzf --bind 'enter:execute(bash -c "aerospace focus --window-id {1}")+abort'
}

def sshp [target] {
    let TERM = "xterm-256color";
    ^ssh -o ProxyJump=sabaext $target
}

# def zen [arg] {
#     ~/.config/sketchybar/plugins/zen.sh $arg
# }

