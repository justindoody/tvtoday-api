FROM ruby:2.3.0
RUN apt-get update -yqq && apt-get install -yqq build-essential libpq-dev nodejs
RUN mkdir /tvtoday-api
WORKDIR /tvtoday-api
ADD Gemfile /tvtoday-api/Gemfile
ADD Gemfile.lock /tvtoday-api/Gemfile.lock
RUN bundle install
ADD . /tvtoday-api
