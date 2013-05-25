#!/bin/bash

# check prerequisites

which brew &> /dev/null
if [[ $? -ne 0 ]]; then
  printf "\nError: Homebrew not installed\n\n"
  exit 1
fi

# fix working dir

cd "$(dirname "${BASH_SOURCE}")"

# pull latest

git pull
if [[ $? -ne 0 ]]; then
  printf "\nWarning: git failed pulling the latest version (see details above).\n\n"
fi

# rsync to home dir

function doSync() {
	rsync --exclude ".git/" --exclude ".DS_Store" --exclude "init" --exclude "*.bash" --exclude "apply-settings.fish" --exclude "*.md" --exclude "*.txt" -av . ~
}
if [ "$1" == "--force" -o "$1" == "-f" ]; then
	doSync
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1
	echo
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		doSync
  else
    printf "Aborted.\n\n"
    exit 0
	fi
fi
unset doSync

# install fish if needed

brew ls fish &> /dev/null
if [[ $? -ne 0 ]]; then
  printf "\nfish not found, installing...\n\n"
  brew update
  if [[ $? -ne 0 ]]; then
    printf "\nError: Homebrew update failed. Aborting.\n\n"
    exit 1
  fi
  brew install fish
  if [[ $? -ne 0 ]]; then
    printf "\nError: fish installation failed. Aborting.\n\n"
    exit 1
  fi
  printf "\nSee instructions above for making fish the default shell.\n"
fi

# apply fish settings

printf "\nSetting up/refreshing fish settings (i.e. universal variables)... "
fish apply-settings.fish
if [[ $? -ne 0 ]]; then
  printf "\nError: applying fish settings failed.\n\n"
  exit 1
else
  printf "done.\n\n"
fi
