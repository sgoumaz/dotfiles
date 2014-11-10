# Homebrew
set -x PATH ""(brew --prefix)"/bin" $PATH

# use latest Ruby + Gems
set -x PATH "/usr/local/Cellar/ruby/2.0.0-p0/bin" "/usr/local/opt/ruby/bin" $PATH

# node (default)
set -x NODE_PATH "/usr/local/lib/node" "/usr/local/lib/node_modules" $NODE_PATH

# node (current version, via n)
n 0.10.33

# expose PATH to graphical apps
launchctl setenv PATH $PATH
