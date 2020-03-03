FROM zooniverse/ruby:2.3.1

ENV DEBIAN_FRONTEND noninteractive
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

ARG RAILS_ENV

WORKDIR /rails_app

RUN apt-get update && \
  apt-get install --no-install-recommends -y git libpq-dev && \
  apt-get clean && rm -rf /var/lib/apt/lists/*

COPY ./Gemfile /rails_app/
COPY ./Gemfile.lock /rails_app/

RUN cd /rails_app && \
  bundle install --without test development

COPY ./ /rails_app

ENV RAILS_ENV $RAILS_ENV
ENV RACK_ENV $RAILS_ENV

RUN (cd /rails_app && git log --format="%H" -n 1 > commit_id.txt)

EXPOSE 80

CMD ["/rails_app/docker/start.sh"]