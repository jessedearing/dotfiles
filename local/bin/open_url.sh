#!/bin/bash

tr -d '\n' | gxargs -I {} -- tmux run-shell 'open "{}"'
