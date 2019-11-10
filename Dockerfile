FROM ruby:2.6-slim

RUN apt-get update && apt-get install -qq -y --no-install-recommends \
      build-essential libpq-dev

ENV INSTALL_PATH /chatbot

RUN mkdir -p $INSTALL_PATH

WORKDIR $INSTALL_PATH

COPY Gemfile.lock /$INSTALL_PATH/Gemfile.lock
COPY Gemfile ./

RUN bundle install

COPY . /$INSTALL_PATH

CMD rackup config.ru -o 0.0.0.0