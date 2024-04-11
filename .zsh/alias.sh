# Arch
if command -v yay 1>/dev/null 2>&1; then
	alias p='yay'
	alias up='yay -Syu'
elif command -v pacman 1>/dev/null 2>&1; then
	alias p='sudo pacman'
	alias up='sudo pacman -Syu'
fi

# Common aliases
alias clc='clear'
alias vi='nvim'
alias vim='nvim'
# alias systemctl='sudo systemctl'

if command -v doas 1>/dev/null 2>&1; then
    alias sudo='doas'
fi

alias zsh_history_fix='mv ~/.zsh_history ~/.zsh_history_bad && strings -eS .zsh_history_bad > .zsh_history && fc -R .zsh_history'

# Configuration
alias config='/usr/bin/git --git-dir=${HOME}/.cfg/ --work-tree=${HOME}'
alias ezsh='vi ${HOME}/.zshrc'
alias efish='vi ${HOME}/.config/fish/config.fish'
alias ezprofile='vi ${HOME}/.zprofile'
alias ealias='vi ${HOME}/.zsh/alias.sh'
alias ealacritty='vi ${HOME}/.config/alacritty/alacritty.yml'
alias eqtile='vi ${HOME}/.config/qtile/config.py'
alias envim='vi ${HOME}/.config/nvim/init.lua'
alias essh='vi ${HOME}/.ssh/config'
alias eemacs='vi ${HOME}/.emacs.d/init.el'

if command -v exa 1>/dev/null 2>&1; then
	alias l='exa'
	alias ls='exa'
	alias ll='exa -l'
	alias lll='exa -la'
else
	alias l='ls'
	alias ll='ls -l'
	alias lll='ls -la'
fi

# Kubernetes
alias kcuc='kubectl config use-context'
alias kcucc='kubectl config unset current-context'

# Python
alias python='~/.pyenv/shims/python'

# Docker
# alias docker='sudo docker'
# alias docker-compose='sudo docker-compose'

# SSH
alias ssh="TERM=xterm ssh"

# AWS
alias aen='f(){ aws-vault exec $1 --no-session; }; f'

# WSL
if command -v ipconfig.exe 1>/dev/null 2>&1; then
    alias wsl_display="export WSL_ip_line=$(ipconfig.exe | grep "WSL" -n | awk -F ":" '{print $1+4}') && export DISPLAY=192.168.1.30:0.0 && export LIBGL_ALWAYS_INDIRECT=1"
fi

alias tartozip="for f in *.tar.gz;do rm -rf ${f%.tar.gz} ;mkdir ${f%.tar.gz} ;tar -C ${f%.tar.gz} zxvf $f;zip -r ${f%.tar.gz} $f.zip;rm -rf ${f%.tar.gz};done"

# Git
alias gcane="git commit --amend --no-edit"
alias gp="git push"
alias gpf="git push -f"

if command -v zoxide 1>/dev/null 2>&1; then
    alias cd='z'
    alias cdi='zi'
    alias j='z'
    alias ji='zi'
fi


fe() {
local files
  IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && nvim "${files[@]}"
}
