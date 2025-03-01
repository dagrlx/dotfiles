# alias la =  ls -la | select name type mode user group size modified | update modified {format date "%Y-%m-%d %H:%M:%S"}
def la [] {
    ls -la | select name type mode user group size modified | update modified {format date "%Y-%m-%d %H:%M:%S"}
}

def fzn [] {
    fzf --preview '''bat --style=numbers --color=always {}''' | xargs -n1 nvim
}

# list applications in Aerospace for selection
def ff [] {
    aerospace list-windows --all | fzf --bind 'enter:execute(bash -c "aerospace focus --window-id {1}")+abort'
}

# Para controladoras
def sshpt [host] {
    let TERM = "xterm-256color";
    ^ssh -o ProxyJump=sabaext $host
}

# Para equipos que no tienen xterm-ghostty
def ssht [host] {
    let TERM = "xterm-256color";
    ^ssh $host
}

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

