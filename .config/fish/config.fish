### EXPORTS ###
set TERM "xterm-256color"
set HISTORY_IGNORE "(l[l ll]|cd|pwd|exit|h[s]|history|cd -|cd ..|cd)"
set SAVEHIST 10000
set HISTSIZE 10000
set EDITOR 'nvim'
set VISUAL 'nvim'
set SUDO_EDIOTR 'nvim'

# Local
set PATH "$HOME/.local/bin:$PATH"
set PATH "$HOME/.bin:$PATH"

# Rbenv
set RBENV_ROOT "$HOME/.rbenv"
set PATH "$RBENV_ROOT/bin:$PATH"
set PATH "$RBENV_ROOT/plugins/ruby-build/bin:$PATH"

# Pyenv
set -Ux PYENV_ROOT "$HOME/.pyenv"
set -U fish_user_paths $PYENV_ROOT/bin $fish_user_paths
status is-login; and pyenv init --path | source
status is-interactive; and pyenv init - | source

# Poetry
set POETRY_ROOT "$HOME/.poetry"
set PATH "$POETRY_ROOT/bin:$PATH"

# Scalaenv
set SCALAENV_ROOT "$HOME/.scalaenv"
set PATH "$SCALAENV_ROOT/bin:$PATH"

# Rust setup
set PATH "$HOME/.cargo/bin:$PATH"

# Jenv
set JENV_ROOT "$HOME/.jenv"
set PATH "$JENV_ROOT/bin:$PATH"
set JAVA_HOME "/usr/lib/jvm/default"

# GO
set GOENV_ROOT "$HOME/.goenv"
set PATH "$GOENV_ROOT/bin:$PATH"
set PATH "$GOROOT/bin:$PATH"
set PATH "$PATH:$GOPATH/bin"

# Node
set NVM_DIR "$HOME/.nvm"

# Spark
if [ "$OSTYPE" = "darwin21" ]
  set SPARK_HOME /usr/local/Cellar/apache-spark
else
  set SPARK_HOME /opt/spark
end

set PATH "$SPARK_HOME/bin:$SPARK_HOME/sbin:$PATH"

# Emacs
set PATH "$HOME/.emacs.doom/bin:$PATH"

# Docker
if [ "$OSTYPE" = "darwin21" ]
else
  set DOCKER_HOST unix://$XDG_RUNTIME_DIR/docker.sock
end

# Coursier
set PATH "$PATH:$HOME/.local/share/coursier/bin"

# Metals
set PATH "$PATH:/Users/clvanbrandt/Library/Application Support/Coursier/bin"

### END OF EXPORTS

function fish_user_key_bindings
  # fish_default_key_bindings
  # fish_vi_key_bindings
end

## Autojump
if test -f /usr/share/autojump/autojump.fish;
	source /usr/share/autojump/autojump.fish;
else if test -f /usr/local/share/autojump/autojump.fish
	source /usr/local/share/autojump/autojump.fish;
end


# Type d to move up to top parent dir which is a repository
function d
	while test $PWD != "/"
		if test -d .git
			break
		end
		cd ..
	end
end

## Prompt
# Fish git prompt
set __fish_git_prompt_showuntrackedfiles 'yes'
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate ''
set __fish_git_prompt_showupstream 'none'
set -g fish_prompt_pwd_dir_length 3

# colored man output
# from http://linuxtidbits.wordpress.com/2009/03/23/less-colors-for-man-pages/
setenv LESS_TERMCAP_mb \e'[01;31m'       # begin blinking
setenv LESS_TERMCAP_md \e'[01;38;5;74m'  # begin bold
setenv LESS_TERMCAP_me \e'[0m'           # end mode
setenv LESS_TERMCAP_se \e'[0m'           # end standout-mode
setenv LESS_TERMCAP_so \e'[38;5;246m'    # begin standout-mode - info box
setenv LESS_TERMCAP_ue \e'[0m'           # end underline
setenv LESS_TERMCAP_us \e'[04;38;5;146m' # begin underline

setenv FZF_DEFAULT_COMMAND 'fd --type file --follow'
setenv FZF_CTRL_T_COMMAND 'fd --type file --follow'
setenv FZF_DEFAULT_OPTS '--height 20%'

function fish_prompt
    set_color brblack
    echo -n "["(date "+%H:%M")"] "
    set_color blue
    echo -n (whoami)
    if [ $PWD != $HOME ]
        set_color brblack
        echo -n ':'
        set_color yellow
        echo -n (basename $PWD)
    end
    set_color green
    printf '%s ' (__fish_git_prompt)
    set_color red
    echo -n '| '
    set_color normal
end

function fish_greeting

end

# Aliases

abbr -a clc 'clear'
abbr -a vi 'nvim'
abbr -a vim 'nvim'

if command -v doas > /dev/null 
    abbr -a sudo 'doas'
end

if command -v yay > /dev/null
	abbr -a p 'yay'
	abbr -a up 'yay -Syu'
else if command -v pacman > /dev/null
	abbr -a p 'sudo pacman'
	abbr -a up 'sudo pacman -Syu'
end

if command -v exa > /dev/null
	abbr -a l 'exa'
	abbr -a ls 'exa'
	abbr -a ll 'exa -l'
	abbr -a lll 'exa -la'
else
	abbr -a l 'ls'
	abbr -a ll 'ls -l'
	abbr -a lll 'ls -la'
end


# Configuration
function config 
    /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME $argv
end

abbr -a ezsh 'nvim $HOME/.zshrc'
abbr -a efish 'nvim $HOME/.config/fish/config.fish'
abbr -a ezprofile 'nvim $HOME/.zprofile'
abbr -a ealias 'nvim $HOME/.omz-custom/alias.zsh'
abbr -a ealacritty 'nvim $HOME/.config/alacritty/alacritty.yml'
abbr -a eqtile 'nvim $HOME/.config/qtile/config.py'
abbr -a envim 'nvim $HOME/.config/nvim/init.lua'
abbr -a essh 'nvim $HOME/.ssh/config'
abbr -a eemacs 'nvim $HOME/.emacs.d/init.el'

# Kubernetes
abbr -a kcucc 'kubectl config unset current-context'

# Java
abbr -a jenv_set_java_home 'export JAVA_HOME="$HOME/.jenv/versions/'(jenv version-name)'"'

# Python
function python
    $HOME/.pyenv/shims/python $argv
end

# SSH
function ssh
    env TERM=xterm ssh $argv
end

# AWS
function aen
    aws-vault exec $argv[1] --no-session
end

