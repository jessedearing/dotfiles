#!/bin/bash

(
cd $HOME/.dotfiles

all_dir=`find $PWD -maxdepth 1 \! -iname 'themes' \! -iname 'README.md' \! -iname '.*' \! -iname 'powerline-fonts' \! -iname misc_scripts \! -iname 'install.sh' \! -iname 'global.gems'`

for dir in $all_dir; do
  if [ ! -e $HOME/.`basename $dir` ]; then
    echo Linking $dir to $HOME/.`basename $dir`
    ln -s $dir $HOME/.`basename $dir`
  else
    echo $HOME/.`basename $dir` already exists
  fi
done
)
