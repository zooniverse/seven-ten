[![pullreminders](https://pullreminders.com/badge.svg)](https://pullreminders.com?ref=badge)

# Seven-Ten

Split testing service

[![Build Status](https://travis-ci.org/zooniverse/Seven-Ten.svg?branch=master)](https://travis-ci.org/zooniverse/Seven-Ten)

## Getting started

``` bash
# clone the repository
git clone https://github.com/zooniverse/Seven-Ten.git
cd Seven-Ten

# copy some config files
for f in config/*.yml.docker; do cp "$f" "${f%.docker}"; done
```

With Docker

``` bash
docker-compose build
docker-compose up
# alternatively get a bash console in the docker container
docker-compose run --service-ports --rm app bash
```

## [Documentation](https://github.com/zooniverse/Seven-Ten/blob/master/docs/)

Documentation can be found in [/docs](https://github.com/zooniverse/Seven-Ten/blob/master/docs/).

### Client

The JavaScript client is located at [zooniverse/Seven-Ten-Client](https://github.com/zooniverse/Seven-Ten-Client).
