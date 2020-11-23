#!/usr/bin/env bash

for pid in `ps aux | grep "$*" | grep -v grep | awk '{ print $2; }'`; do
  kill -TERM $pid
done
