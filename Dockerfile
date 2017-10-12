FROM docker.nustechnology.com/docker-rvm:1.0
MAINTAINER hiepnh@nustechnology.com

ENV APP_HOME /devs/spree-mt
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME
# Install ruby version and bundler.
COPY .ruby-version $APP_HOME/.ruby-version
COPY .ruby-gemset $APP_HOME/.ruby-gemset
RUN /bin/bash -l -c "rvm install $(cat .ruby-version)" && \
    /bin/bash -l -c "rvm use --default $(cat .ruby-version)@$(cat .ruby-gemset) --create && \
    gem install bundler"

# Set up gems
COPY Gemfile* $APP_HOME/
RUN /bin/bash -l -c "bundle install"