#!/bin/bash

# ensure we stop on error (-e) and log cmds (-x)
set -ex

mkdir -p tmp/pids/
rm -f tmp/pids/*.pid

bundle install --without test development
rake db:migrate
puma -C config/puma.rb
