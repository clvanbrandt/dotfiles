autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit

setopt share_history

# Do not save duplicate commands to history
setopt HIST_IGNORE_ALL_DUPS

# Do not find duplicate command when searching
setopt HIST_FIND_NO_DUPS

export HISTORY_IGNORE="(l[l ll]|cd|pwd|exit|h[s]|history|cd -|cd ..|cd|j|z|vi|e|vi *|l[alsh]#( *)#)"
export HISTFILE="${HOME}/.zsh_history"
export SAVEHIST=100000
export HISTSIZE=100000
export EDITOR='nvim'
export SUDO_EDIOTR='nvim'
# export TERM="alacritty"

# Some keybinds
VIM_MODE_VICMD_KEY='^J'

source ~/.zsh/alias.sh
# source ~/.zsh/tmux.sh

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

fpath+=~/.zfunc
fpath+=/opt/homebrew/share/zsh/site-functions
zstyle ':completion:*' menu select

export STARSHIP_CONFIG=~/.config/starship.toml
eval "$(starship init zsh)"
# eval "$(~/Projects/local/starship/target/release/starship init zsh)"

# zsh-autosuggestions
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
# zsh-syntax-highlighting
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# zsh completions
fpath=(~/.zsh/zsh-completions/src $fpath)
# zsh-history-substring-search
source ~/.zsh/zsh-history-substring-search/zsh-history-substring-search.zsh
# zsh-vim-mode
# In .zshrc
source "$HOME/.zsh/zsh-vim-mode/zsh-vim-mode.plugin.zsh"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# AWS
complete -C '/usr/local/bin/aws_completer' aws

# Kubectl
if command_exists kubectl; then
  source <(kubectl completion zsh)
fi

if command_exists zoxide; then
  eval "$(zoxide init zsh)"
fi 


if command_exists atuin; then
  eval "$(atuin init zsh --disable-up-arrow)"
fi
