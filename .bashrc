if [ -f $HOME/.dir_colors/dircolors ]; then
    eval `dircolors $HOME/.dir_colors/dircolors`
fi

PS1="\n\[$(tput sgr0)\]\[$(tput bold)\]\[\033[38;5;108m\][\w]\[$(tput sgr0)\]\n\\$ \[$(tput sgr0)\]"

# Prevent accidental overwrites when using IO redirection
# Example: touch file.txt && echo "Hello World!" >| file.txt
set -o noclobber

# History
shopt -s histappend
shopt -s cmdhist
HISTCONTROL=ignoreboth:erasedups
HISTIGNORE="ls:bg:fg:exit:pwd:clear:..:...:....:....."
HISTTIMEFORMAT="%F %T: "
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

# Fix escaped $ with auto-completion
shopt -s direxpand

export VISUAL=nvim
export EDITOR="$VISUAL"
export PAGER=less

export RIPGREP_CONFIG_PATH=$HOME/.ripgreprc

[ -f $HOME/.bash_aliases ] && source $HOME/.bash_aliases

FD_PREFIX="fd --hidden --follow"
export FZF_DEFAULT_COMMAND="$FD_PREFIX --type f"
export FZF_DEFAULT_OPTS="--reverse --multi
    --color=bg+:237,bg:0,border:0,spinner:11,hl:11,fg:15,header:8,info:12,pointer:12,marker:208,fg+:15,prompt:11,hl+:11"

# Use fd for selecting files and directories
export FZF_CTRL_T_COMMAND="$FD_PREFIX"
export FZF_CTRL_T_OPTS="
    --preview 'bat -n --color=always --style=numbers --line-range=:500 {}'
    --bind 'ctrl-/:change-preview-window(hidden|)'"

# Use fd for directory navigation
export FZF_ALT_C_COMMAND="$FD_PREFIX --type d"
export FZF_ALT_C_OPTS="--preview 'tree -C {}'"

# Use fd for path completion
_fzf_compgen_path() {
    $FD_PREFIX . "$1"
}

# Use fd for directory completion
_fzf_compgen_dir() {
    $FD_PREFIX --type d . "$1"
}
