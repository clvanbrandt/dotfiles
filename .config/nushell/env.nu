$env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense' # optional
mkdir ~/.cache/carapace
carapace _carapace nushell | save --force ~/.cache/carapace/init.nu

# $env.PATH = []
# $env.PATH = ($env.PATH | split row (char esep) | prepend '/opt/homebrew/bin')

use std/dirs shells-aliases *

