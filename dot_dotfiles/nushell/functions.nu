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

def sshtp [host] {
    let TERM = "xterm-256color";
    ^ssh -o ProxyJump=sabaext $host
}

def ssht [host] {
    let TERM = "xterm-256color";
    ^ssh $host
}

# def zen [arg] {
#     ~/.config/sketchybar/plugins/zen.sh $arg
# }

# Shell wrapper for yazi file managet
def --env y [...args] {
	let tmp = (mktemp -t "yazi-cwd.XXXXXX")
	yazi ...$args --cwd-file $tmp
	let cwd = (open $tmp)
	if $cwd != "" and $cwd != $env.PWD {
		cd $cwd
	}
	rm -fp $tmp
}

# Update brew pakages
# def brew-upg [] {
#     brew update
#     brew upgrade
#     brew upgrade --cask --greedy
# }
