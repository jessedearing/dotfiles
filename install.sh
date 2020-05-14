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

for configitem in `find $HOME/.dotfiles/gnupg -type f`; do
  homeconfigitem=`echo $configitem | sed -e 's/\.dotfiles\//./'`
  if [ -e $homeconfigitem ]; then
    echo "$homeconfigitem already exists"
  else
    echo "Linking $configitem to $homeconfigitem"
    mkdir -p `dirname $homeconfigitem`
    ln -s $configitem $homeconfigitem
  fi
done

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
