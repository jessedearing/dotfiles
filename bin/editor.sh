#!/bin/bash

VIM=/usr/local/bin/nvim
args=""
daily=""

while (( "$#" )); do
	if [[ "$1" == "-daily" ]]; then
		daily=1
		break
	fi

	args="$args $1"
	shift
done

if [ ! -z "$daily" ]; then
	(
		cd $HOME/daily
		$VIM index.md
	)
else
	$VIM $args
fi

