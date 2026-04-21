#!/bin/bash

# Make sure we’re using the latest Homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade

# Install everything else

# file navigation & other utils
brew install bat # `cat` replacement
brew install broot # `br`, file subtree navigation, TODO review against `fzf`
brew install eza # `ls` replacement
brew install fd # file searching
brew install fzf # file subtree navigation
brew install jq # JSON preview
brew install mmv # batch file rename
brew install poppler # lib for PDF rendering
brew install ripgrep # `rg`, file content searching
brew install sevenzip # `7zz`, archives
brew install unison # files sync
brew install yazi # `y`, file explorer
brew install zoxide # `z`, historical directories navigation

# coding
brew install composer
brew install docker
brew install git # more up-to-date than the MacOS version
brew install git-extras
brew install git-quick-stats
brew install typst
brew install uv # complete Python env & dev tooling

# networking & sync
brew install bettercap # network/BT/etc. scanning + sniffing with web UI
# brew install bind # up-to-date DNS tools
brew install mosh # mobile shell (SSH with intermittent connectivity)
brew install snitch # connections inspector (friendlier ss/netstat)
brew install syncthing # P2P files sync between devices

# media
brew install exiftool
brew install fontforge
brew install graphicsmagick
brew install kew # music player
brew install kid3 # ID3 tag editor (GUI)

# other system utils
brew install btop # system monitor
brew install espanso # text expander
brew tap FelixKratz/formulae && brew install borders && brew services start borders # window borders
brew install mole # system clean up
brew install sf-pwgen # password generator
brew install witr # Why Is This Running?

# Remove outdated versions from the cellar
brew cleanup
