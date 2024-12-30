#!/bin/bash

set -e

(
	cd "$HOME/.dotfiles"

	all_dir=$(find "$PWD" -maxdepth 1 \! -name 'Library' \! -name 'root' \! -iname 'pkg' \! -iname 'themes' \! -iname 'README.md' \! -iname '.*' \! -iname 'powerline-fonts' \! -iname misc_scripts \! -iname 'install.sh' \! -iname 'global.gems' \! -iname 'gpg-agent.conf' \! -iname 'coc-settings.json' \! -iname 'config' \! -iname 'local' \! -name 'shell-bookmarks' \! -name 'folder-templates')

	for dir in $all_dir; do
		if [ ! -e "$HOME/.$(basename "$dir")" ]; then
			echo Linking $dir to $HOME/.$(basename $dir)
			ln -fs $dir $HOME/.$(basename $dir)
		else
			echo $HOME/.$(basename $dir) already exists
		fi
	done

	for configitem in $(find $HOME/.dotfiles/gnupg -maxdepth 0 -type f); do
		homeconfigitem=$(echo $configitem | sed -e 's/\.dotfiles\//./')
		if [ -e $homeconfigitem ]; then
			echo "$homeconfigitem already exists"
		else
			echo "Linking $configitem to $homeconfigitem"
			mkdir -p $(dirname $homeconfigitem)
			ln -fs $configitem $homeconfigitem
		fi
	done

	for configitem in $(find $HOME/.dotfiles/config -type f); do
		homeconfigitem=$(echo $configitem | sed -e 's/\.dotfiles\//./')
		if [ -e $homeconfigitem ]; then
			echo "$homeconfigitem already exists"
		else
			echo "Linking $configitem to $homeconfigitem"
			mkdir -p $(dirname $homeconfigitem)
			ln -fs $configitem $homeconfigitem
		fi
	done

	for configitem in $(find $HOME/.dotfiles/local/bin -type f); do
		homeconfigitem=$(echo $configitem | sed -e 's/\.dotfiles\//./')
		if [ -e $homeconfigitem ]; then
			echo "$homeconfigitem already exists"
		else
			echo "Linking $configitem to $homeconfigitem"
			mkdir -p $(dirname $homeconfigitem)
			ln -fs $configitem $homeconfigitem
		fi
	done

	find "$HOME/.dotfiles/Library" -type f | while read -r configitem; do
		homeconfigitem="$(echo "$configitem" | sed -e 's/\.dotfiles\///')"
		if [ -e "$homeconfigitem" ]; then
			echo "$homeconfigitem already exists"
		else
			echo "Linking $configitem to $homeconfigitem"
			mkdir -p "$(dirname "$homeconfigitem")"
			ln -fs "$configitem" "$homeconfigitem"
		fi
	done
)
