#!/bin/bash

if [[ "$RAILS_ENV" == "staging" || "$RAILS_ENV" == "production" ]]; then
  aws s3 sync s3://zooniverse-code/production_configs/seven_ten_$RAILS_ENV config
fi

bundle install --without test development
rake db:migrate
puma -C config/puma.rb
