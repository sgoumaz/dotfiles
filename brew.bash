#!/bin/bash

# Make sure we’re using the latest Homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade

# Install everything else
brew install autojump
brew install bat
brew install bettercap
brew install composer
brew install docker
brew install fd
brew install git
brew install git-extras
brew install git-quick-stats
brew install gpg2
brew install httpie
brew install ffmpeg
brew install graphicsmagick
brew install htop
brew install mosh
brew install python
brew install ripgrep
brew install sf-pwgen

# Remove outdated versions from the cellar
brew cleanup
