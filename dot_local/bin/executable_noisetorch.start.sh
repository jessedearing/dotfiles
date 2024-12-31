#!/usr/bin/env bash

__device_id=$(noisetorch -l | grep -A 1 'Blue Snowball' | awk 'NR == 2 { print $3 }')

exec noisetorch -i -s "$__device_id"
