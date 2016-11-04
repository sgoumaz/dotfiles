#!/bin/bash

# Make sure we’re using the latest Homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade

# Install GNU core utilities (those that come with OS X are outdated)
# brew install coreutils
# echo "Don’t forget to add $(brew --prefix coreutils)/libexec/gnubin to \$PATH."

# Install more recent versions of some OS X tools
# brew tap homebrew/dupes
# brew install homebrew/dupes/grep
# brew tap josegonzalez/homebrew-php
# brew install php54
# brew install ruby

# Install everything else
brew install ag
brew install git
brew install git-extras
brew install httpie
brew install ffmpeg
brew install graphicsmagick
brew install htop
brew install mobile-shell
brew install sf-pwgen
# brew install mysql

# Remove outdated versions from the cellar
brew cleanup
