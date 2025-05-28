# Completion

# autoload bashcompinit && bashcompinit
# autoload -Uz compinit && compinit zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza -1 --color=always $realpath'
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
zstyle ':completion:*:git-checkout:*' sort false

if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

  autoload -Uz compinit
  compinit
fi

# Plugin management
source $(brew --prefix)/opt/antidote/share/antidote/antidote.zsh
export NVM_LAZY=1
antidote load "${HOME}/.zsh/plugins.txt"

# Prompt
export STARSHIP_CONFIG=~/.config/starship.toml
eval "$(starship init zsh)"
# eval "$(~/Projects/local/starship/target/release/starship init zsh)"

# Keybindings
# bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

# History
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

export HISTORY_IGNORE="(l[l ll]|cd|pwd|exit|h[s]|history|cd -|cd ..|cd|j|z|vi|e|vi *|l[alsh]#( *)#)"
export HISTFILE="${HOME}/.zsh_history"
export SAVEHIST=10000
export HISTSIZE=10000

# Editor
export EDITOR='nvim'
export SUDO_EDITOR='nvim'
# export TERM="alacritty"

# Alias
source ~/.zsh/alias.sh

function command_exists() {
    return $(command -v $1 1>/dev/null 2>&1)
}

for cmdenv in jenv # scalenv # goenv rbenv scalaenv
do
    if command_exists $cmdenv; then
        eval "$($cmdenv init -)"
    fi
done

if command_exists aws-vault; then
    eval "$(aws-vault --completion-script-zsh)"
fi

# if command_exists cz; then
#   eval "$(register-python-argcomplete cz)"
# fi

if command_exists fuck; then
  eval $(thefuck --alias)
fi

# Shell integration
eval "$(fzf --zsh)"

if command_exists zoxide; then
  eval "$(zoxide init zsh)"
fi

# if command_exists atuin; then
#   eval "$(atuin init zsh --disable-up-arrow)"
# fi
