#!/usr/bin/env zsh

VIM=/usr/local/bin/nvim
daily=""

if [[ "$1" == "-daily" ]]; then
	daily=1
fi

if [ ! -z "$daily" ]; then
	(
		cd $HOME/daily
		exec $VIM index.md
	)
else
	exec $VIM $*
fi

