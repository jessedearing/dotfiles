#!/bin/bash

echo "Setting OS Xcustomizations..."
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3
defaults write NSGlobalDomain InitialKeyRepeat -int 18
defaults write NSGlobalDomain NSQuitAlwaysKeepsWindows -bool false
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
chflags nohidden ~/Library
sudo chmod 600 /System/Library/CoreServices/Search.bundle/Contents/MacOS/Search
echo "Done, now restart"
