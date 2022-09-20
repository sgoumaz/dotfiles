# PATH
# - Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"
# - Rust
fish_add_path $HOME"/.cargo/bin"
# - VS Code
fish_add_path --append "/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
# - PHP composer
fish_add_path --append $HOME"/.composer/vendor/bin"

# node (default)
set -x NODE_PATH "/usr/local/lib/node" "/usr/local/lib/node_modules" $NODE_PATH
# node (current version, via n)
set -x N_PREFIX $HOME/.n
fish_add_path $N_PREFIX/bin

n lts

# EDITOR
set -x EDITOR "code"

# autojump
[ -f /opt/homebrew/share/autojump/autojump.fish ]; and source /opt/homebrew/share/autojump/autojump.fish
