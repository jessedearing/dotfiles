#!/usr/bin/env bash

cat | tr -d '\n' | base64 "$@"
