#!/bin/zsh

(cd $HOME/newrelic/site-engineering/f5_failover && ./bin/sanity_check.rb -e $1)
