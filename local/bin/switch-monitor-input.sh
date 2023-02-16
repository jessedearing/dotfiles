#!/usr/bin/env zsh

if ddccontrol -r 0x60 dev:/dev/i2c-11 | grep '4626/4626' &> /dev/null; then
  ddccontrol -r 0x60 -w 15 dev:/dev/i2c-11
else
  ddccontrol -r 0x60 -w 18 dev:/dev/i2c-11
fi
