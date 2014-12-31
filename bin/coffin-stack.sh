#!/bin/bash

echo $1 | awk '{ name=$1; gsub(/.coffee/, "", name); print name; print $1}' | xargs -n 2 coffin stack
