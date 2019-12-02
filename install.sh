#!/bin/bash

set -e

(
cd $HOME/.dotfiles

all_dir=`find $PWD -maxdepth 1 \! -iname 'pkg' \! -iname 'themes' \! -iname 'README.md' \! -iname '.*' \! -iname 'powerline-fonts' \! -iname misc_scripts \! -iname 'install.sh' \! -iname 'global.gems' \! -iname 'gpg-agent.conf' \! -iname 'coc-settings.json' \! -iname 'config'`

for dir in $all_dir; do
  if [ ! -e $HOME/.`basename $dir` ]; then
    echo Linking $dir to $HOME/.`basename $dir`
    ln -s $dir $HOME/.`basename $dir`
  else
    echo $HOME/.`basename $dir` already exists
  fi
done

mkdir -p $HOME/.gnupg
if [ -e $HOME/.gnupg/gpg-agent.conf ]; then
	echo $HOME/.gnupg/gpg-agent.conf already exists
else
	echo Linking gpg-agent.conf to $HOME/.gnupg/gpg-agent.conf
	ln -s $HOME/.dotfiles/gpg-agent.conf $HOME/.gnupg/gpg-agent.conf
fi

for configitem in `find $HOME/.dotfiles/config -type f`; do
  homeconfigitem=`echo $configitem | sed -e 's/\.dotfiles\//./'`
  if [ -e $homeconfigitem ]; then
    echo "$homeconfigitem already exists"
  else
    echo "Linking $configitem to $homeconfigitem"
    mkdir -p `dirname $homeconfigitem`
    ln -s $configitem $homeconfigitem
  fi
done
)
