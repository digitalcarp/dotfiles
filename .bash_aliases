# Navigation
alias ~="cd ~"
alias -- -="cd -"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

cl () {
    cd "$1" && ls
}

# Directory management
mcd () {
    mkdir "$1" && cd "$1"
}
alias md="mkdir -pv"
alias rd="rmdir"

# Standard commands
alias grep="grep --color=auto"

alias ls="ls --color=auto"
alias ll="ls -lh"
alias lsa="ls -lah"
alias l="ls -lah"
alias la="ls -lAh"

alias fd="fdfind"

# tmux
alias tmux="tmux -2 -u"
alias ts="tmux new-session -s"
alias ta="tmux attach -t"
alias tad="tmux attach -d -t"
alias td="tmux detach"
alias tl="tmux list-sessions"
alias tkss="tmux kill-session -t"
alias tksv="tmux kill-server"

# vim
alias n="nvim"
alias nf="fzf --print0 | xargs -0 -o nvim"
