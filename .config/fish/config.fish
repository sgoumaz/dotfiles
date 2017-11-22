# Homebrew
set -x PATH ""(brew --prefix)"/bin" $PATH

# node (default)
set -x NODE_PATH "/usr/local/lib/node" "/usr/local/lib/node_modules" $NODE_PATH

# node (current version, via n)
n 8.9.1

# expose PATH to graphical apps
launchctl setenv PATH $PATH
