FROM ruby:2.6.3
RUN apt-get update
RUN apt-get install -y \
  build-essential \
  libpq-dev \
  nodejs \
  postgresql-client \
  yarn
WORKDIR /gym-tomo
COPY Gemfile Gemfile.lock /gym-tomo/
RUN gem install bundler
RUN bundle install