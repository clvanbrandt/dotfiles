export XDG_CONFIG_HOME="$HOME/.config/"

# Local
export PATH="$HOME/.local/bin:${PATH}"
export PATH="$HOME/.bin:${PATH}"

# Rbenv
export RBENV_ROOT="$HOME/.rbenv"
export PATH="$RBENV_ROOT/bin:${PATH}"
export PATH="$RBENV_ROOT/plugins/ruby-build/bin:${PATH}"

# Rust setup
export PATH="$HOME/.cargo/bin:${PATH}"

# Jenv
export JENV_ROOT="$HOME/.jenv"
export PATH="$JENV_ROOT/bin:$PATH"

# Spark
if [[ "$OSTYPE" == "darwin"* ]]; then
  # export SPARK_HOME="$HOME/.local/apache-spark"
else
  export SPARK_HOME=/opt/spark
  export PATH="$SPARK_HOME/bin:$SPARK_HOME/sbin:${PATH}"
fi

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
export PATH="$HOME/.jenv/bin:$PATH"

# Rust
. "$HOME/.cargo/env"

export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
