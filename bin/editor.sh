#!/bin/bash

VIM=/usr/local/bin/nvim
args=""

while (( "$#" )); do
	if [[ "$1" == "-daily" ]]; then
		(
			cd $HOME/daily
			$VIM index.md
		)
		return
	fi

	args="$args $1"
	shift
done

$VIM $args
