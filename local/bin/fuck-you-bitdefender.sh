#!/usr/bin/env bash

for pid in `ps aux | grep Bitdefender | grep -v grep | awk '{ print $2; }'`; do
	sudo renice 20 $pid
done
