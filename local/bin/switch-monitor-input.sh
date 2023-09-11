#!/usr/bin/env zsh

for i in "11"; do
__mon=$(ddccontrol -r 0x60 dev:/dev/i2c-11)
if [[ "$__mon" =~ 'Dell 5322' ]]; then
  break
fi
done

if [[ "$__mon" =~ '4626/4626' ]]; then
  ddccontrol -r 0x60 -w 15 dev:/dev/i2c-$i
else
  ddccontrol -r 0x60 -w 18 dev:/dev/i2c-$i
fi
