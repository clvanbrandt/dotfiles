function command_exists() {
  return $(command -v $1 1>/dev/null 2>&1)
}

eval "$(/opt/homebrew/bin/brew shellenv)"
