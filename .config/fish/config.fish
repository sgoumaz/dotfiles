# Homebrew
set -x PATH ""(brew --prefix)"/bin" $PATH

# Rust
set -x PATH $HOME"/.cargo/bin" $PATH

# node (default)
set -x NODE_PATH "/usr/local/lib/node" "/usr/local/lib/node_modules" $NODE_PATH

# node (current version, via n)
n lts

# VS Code
set -x PATH $PATH "/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

# autojump
[ -f /usr/local/share/autojump/autojump.fish ]; and source /usr/local/share/autojump/autojump.fish
