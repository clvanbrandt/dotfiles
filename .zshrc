# Plugin management
source $(brew --prefix)/opt/antidote/share/antidote/antidote.zsh
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

# Completion
fpath+=~/.zfunc
fpath+=/opt/homebrew/share/zsh/site-functions
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no

# Editor
export EDITOR='nvim'
export SUDO_EDITOR='nvim'
# export TERM="alacritty"

# Alias
source ~/.zsh/alias.sh

# More completion
autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit

function command_exists() {
    return $(command -v $1 1>/dev/null 2>&1)
}

for cmdenv in pyenv goenv jenv rbenv scalaenv 
do
    if command_exists $cmdenv; then
        eval "$($cmdenv init -)"
    fi
done

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

if command_exists aws-vault; then
    eval "$(aws-vault --completion-script-zsh)"
fi

if command_exists cz; then
  eval "$(register-python-argcomplete cz)"
fi

if command_exists fuck; then
  eval $(thefuck --alias)
fi

# AWS
complete -C '/usr/local/bin/aws_completer' aws

# Kubectl
if command_exists kubectl; then
  source <(kubectl completion zsh)
fi


# Shell integration
eval "$(fzf --zsh)"

if command_exists zoxide; then
  eval "$(zoxide init zsh)"
fi 

# if command_exists atuin; then
#   eval "$(atuin init zsh --disable-up-arrow)"
# fi

