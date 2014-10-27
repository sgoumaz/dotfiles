# Homebrew
set -x PATH ""(brew --prefix)"/bin" $PATH

# use latest Ruby + Gems
set -x PATH "/usr/local/Cellar/ruby/2.0.0-p0/bin" "/usr/local/opt/ruby/bin" $PATH

# node (default)
set -x NODE_PATH "/usr/local/lib/node" "/usr/local/lib/node_modules" $NODE_PATH

# set paths for nvm
set NVM_NODEVER v0.10.32
set -x PATH ~/.nvm/$NVM_NODEVER/bin $PATH
set -x MANPATH ~/.nvm/$NVM_NODEVER/share/man $MANPATH

# expose PATH to graphical apps
launchctl setenv PATH $PATH
