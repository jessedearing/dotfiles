#!/bin/bash

echo "Setting OS Xcustomizations..."
defaults write NSGlobalDomain KeyRepeat -int 1
sudo chmod 600 /System/Library/CoreServices/Search.bundle/Contents/MacOS/Search
echo "Done, now restart"
