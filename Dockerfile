FROM ruby:2.5.1

RUN mkdir /var/app
WORKDIR /var/app

COPY . .

RUN bundle install
