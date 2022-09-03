#!/bin/bash

# Make sure we’re using the latest Homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade

# Install everything else

brew install autojump
brew install bat
brew install bettercap
brew install broot
brew install bind
brew install composer
brew install docker
brew install espanso
brew install fd
brew install gh
brew install git
brew install git-extras
brew install git-quick-stats
brew install httpie
brew install graphicsmagick
brew install htop
brew install macos-trash
brew install mosh
brew install python
brew install ripgrep
brew install sf-pwgen
brew install syncthing

# Remove outdated versions from the cellar
brew cleanup
