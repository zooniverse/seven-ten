#!/bin/bash

# ensure we stop on error (-e) and log cmds (-x)
set -ex

mkdir -p tmp/pids/
rm -f tmp/pids/*.pid

rake db:migrate
puma -C config/puma.rb
