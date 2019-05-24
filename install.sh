#!/bin/bash

(
cd $HOME/.dotfiles

all_dir=`find $PWD -maxdepth 1 \! -iname 'pkg' \! -iname 'themes' \! -iname 'README.md' \! -iname '.*' \! -iname 'powerline-fonts' \! -iname misc_scripts \! -iname 'install.sh' \! -iname 'global.gems' \! -iname 'gpg-agent.conf' \! -iname 'coc-settings.json'`

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

if [ -e $HOME/.config/nvim/coc-settings.json ]; then
  echo "$HOME/.config/nvim/coc-settings.json already exists"
else
  echo "Linking $HOME/.dotfiles/coc-settings.json to $HOME/.config/nvim/coc-settings.json"
  ln -s $HOME/.dotfiles/coc-settings.json $HOME/.config/nvim/coc-settings.json
fi
)
