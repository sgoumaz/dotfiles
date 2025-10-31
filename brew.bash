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
brew install macos-trash # aliased as `t`
brew install mmv # batch file rename
brew install poppler # lib for PDF rendering
brew install ripgrep # `rg`, file content searching
brew install sevenzip # `7zz`, archives
brew install yazi # `y`, file explorer
brew install zoxide # `z`, historical directories navigation

# coding
brew install composer
brew install docker
brew install git # more up-to-date than the MacOS version
brew install git-extras
brew install git-quick-stats
brew install python # more up-to-date than the MacOS version
brew install typst

# networking & sync
brew install bettercap
# brew install bind # up-to-date DNS tools
brew install httpie
brew install mosh
brew install syncthing

# media
brew install exiftool
brew install fontforge
brew install graphicsmagick
brew install kew

# other system utils
brew install btop # system monitor
brew install espanso
# ⚠️ must `yabai --uninstall-service` before upgrade, then `yabai --start-service` again
brew install koekeishiya/formulae/yabai
brew install sf-pwgen
brew install visidata

# Remove outdated versions from the cellar
brew cleanup
