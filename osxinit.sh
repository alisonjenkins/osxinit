#!/bin/bash
function install_homebrew
{
    echo "Installing Homebrew"
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew update
}

function install_homebrew_cask
{
    echo "Installing Homebrew Cask"
    brew install caskroom/cask/brew-cask
    brew cask update
}

function homebrew_install
{
    echo "Installing $1"
    brew install $1
}

function homebrew_cask_install
{
    echo "Installing $1"
    brew cask install $1
}

# check if homebrew is installed and if not install it
if [ ! -x /usr/local/bin/brew ]; then
    install_homebrew
fi

# check if homebrew cask is installed and if not install it
if [ ! -x /usr/local/bin/brew-cask.rb ]; then
    install_homebrew_cask
fi

# read list of software packages to install using homebrew and install them
HOMEBREW_PACKAGES=$(<homebrew_packages)

echo "Installing homebrew packages:"
for package in ${HOMEBREW_PACKAGES}
do
    homebrew_install $package
done

# read list of homebrew cask packages to install and install them
CASK_PACKAGES=$(<cask_packages)

echo "Installing cask packages:"
for package in ${CASK_PACKAGES}
do
    homebrew_cask_install $package
done
