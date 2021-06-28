# PATH
# - Homebrew
set -x PATH ""(brew --prefix)"/bin" $PATH
# - Rust
set -x PATH $HOME"/.cargo/bin" $PATH
# - VS Code
set -x PATH $PATH "/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
# - PHP composer
set -x PATH $PATH $HOME"/.composer/vendor/bin"

# node (default)
set -x NODE_PATH "/usr/local/lib/node" "/usr/local/lib/node_modules" $NODE_PATH
# node (current version, via n)
n lts

# EDITOR
set -x EDITOR "code"

# autojump
[ -f /usr/local/share/autojump/autojump.fish ]; and source /usr/local/share/autojump/autojump.fish
