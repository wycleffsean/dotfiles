# Auto-completion
if [[ -e "/usr/local/opt/fzf/shell/completion.zsh" ]]; then
 [[ $- == *i* ]] && source "/usr/local/opt/fzf/shell/completion.zsh" 2> /dev/null
fi

if [[ -e "/usr/local/opt/fzf/shell/key-bindings.zsh" ]]; then
 source "/usr/local/opt/fzf/shell/key-bindings.zsh"
fi

export FZF_DEFAULT_COMMAND='rg -g "" --hidden --ignore ".git/*"'
