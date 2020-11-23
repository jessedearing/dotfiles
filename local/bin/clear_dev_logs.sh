#!/bin/bash
devlogs=$(find $HOME/code $HOME/newrelic -name 'development.log')

for devlog in $devlogs; do
  cat /dev/null > $devlog
done
