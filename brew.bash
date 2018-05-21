#!/bin/bash

# Make sure we’re using the latest Homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade

# Install everything else
brew install ag
brew install autojump
brew install bat
brew install bettercap
brew install fd
brew install git
brew install git-extras
brew install gpg2
brew install httpie
brew install ffmpeg
brew install graphicsmagick
brew install htop
brew install mobile-shell
brew install sf-pwgen
# brew install mysql

# Remove outdated versions from the cellar
brew cleanup
