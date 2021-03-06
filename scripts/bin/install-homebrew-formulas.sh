#!/bin/sh
#
# Homebrew
#
# This install --verboses some of the common dependencies needed (or at least desired)
# using Homebrew.
# Stolen from zach holman
# https://github.com/holman/dotfiles/blob/master/homebrew/install --verbose.sh

echo "Installing homebrew formulas"

# Check for Homebrew
if test ! $(which brew)
then
  echo "  x You should probably install Homebrew first:"
  echo "    https://github.com/mxcl/homebrew/wiki/install"
  exit
fi

brew install autoconf
brew install automake
brew install ack
brew install ctags
brew install curl-ca-bundle
brew install dos2unix
brew install fuse4x
brew install fuse4x-kext
brew install gdbm
brew install gettext
brew install --with-blk-sha1 --with-pcre --with-gettext --without-completions git
brew install gnu-sed
brew install jq
# workaround for hub completion bug https://github.com/github/hub/issues/231
brew install --HEAD hub
brew install libtool
brew install libyaml

brew install --override-system-vi vim
brew install macvim

brew install nodejs
brew install npm

brew install php-cs-fixer
brew install python
brew install pyenv-virtualenv

# these usually required for pip deps
# usually needed for python gevent
brew install libevent

brew install ncurses
brew install ntfs-3g
brew install openssl
brew install pcre
brew install pkg-config
brew install pv
brew install readline
brew install siege
brew install stow
brew install terminal-notifier
brew install the_silver_searcher
brew install tig
brew install watch
brew install wget
brew install xz

brew install ssh-copy-id
# dont forget to follow brew post-install instructions. brew info zsh
brew install --disable-etcdir zsh
brew install zsh-completions

exit 0
