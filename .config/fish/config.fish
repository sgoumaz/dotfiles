# PATH
# - Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"
fish_add_path /opt/homebrew/bin
# - Rust
fish_add_path $HOME"/.cargo/bin"
# - VS Code
fish_add_path --append "/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
# - PHP composer
fish_add_path --append $HOME"/.composer/vendor/bin"
# - MacTex
fish_add_path --append "/Library/TeX/texbin"

# node (default)
set -x NODE_PATH "/usr/local/lib/node" "/usr/local/lib/node_modules" $NODE_PATH

# fnm
fnm env --use-on-cd | source

# EDITOR
set -x EDITOR "code"

# autojump
[ -f /opt/homebrew/share/autojump/autojump.fish ]; and source /opt/homebrew/share/autojump/autojump.fish
