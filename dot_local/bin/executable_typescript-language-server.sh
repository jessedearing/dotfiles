#!/usr/bin/env bash

if yarn exec typescript-language-server -V; then
  exec yarn exec typescript-language-server --stdio
else
  exec typescript-language-server --stdio
fi
