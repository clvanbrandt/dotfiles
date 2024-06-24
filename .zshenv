export DOOMDIR="$HOME/dotfiles/.doom.d/"
# Local
export PATH="$HOME/.local/bin:${PATH}"
export PATH="$HOME/.bin:${PATH}"

# Rbenv
export RBENV_ROOT="$HOME/.rbenv"
export PATH="$RBENV_ROOT/bin:${PATH}"
export PATH="$RBENV_ROOT/plugins/ruby-build/bin:${PATH}"

# Pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export PYENV_VIRTUALENV_DISABLE_PROMPT=1

# Poetry
export POETRY_ROOT="$HOME/.poetry"
export PATH="$POETRY_ROOT/bin:$PATH"

# Scalaenv
export SCALAENV_ROOT="$HOME/.scalaenv"
export PATH="$SCALAENV_ROOT/bin:$PATH"

# Rust setup
export PATH="$HOME/.cargo/bin:${PATH}"

# Jenv
export JENV_ROOT="$HOME/.jenv"
export PATH="$JENV_ROOT/bin:$PATH"

# GO
export GOENV_ROOT="$HOME/.goenv"
export PATH="$GOENV_ROOT/bin:$PATH"
export PATH="$GOROOT/bin:$PATH"
export PATH="$PATH:$GOPATH/bin"

# Node
export NVM_DIR="$HOME/.nvm"

# Spark
if [[ "$OSTYPE" == "darwin"* ]]; then
  # export SPARK_HOME="$HOME/.local/apache-spark"
else
  export SPARK_HOME=/opt/spark
  export PATH="$SPARK_HOME/bin:$SPARK_HOME/sbin:${PATH}"
fi

# Emacs
export PATH="$HOME/.config/emacs/bin:${PATH}"

# Docker
if [[ "$OSTYPE" == "darwin"* ]]; then
else
  export DOCKER_HOST=unix://$XDG_RUNTIME_DIR/docker.sock
fi

# Coursier
export PATH="$PATH:$HOME/.local/share/coursier/bin"

# Metals
export PATH="$PATH:/Users/clvanbrandt/Library/Application Support/Coursier/bin"

# export JAVA_HOME="/usr/lib/jvm/default"
. "$HOME/.cargo/env"
