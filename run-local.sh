#!/usr/bin/env bash

node_modules/.bin/docpad clean
ulimit -S -n 2048
node_modules/.bin/docpad run