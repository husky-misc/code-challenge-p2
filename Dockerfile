FROM ruby:2.5.1

#RUN apt-get update -yqq

#RUN apt-get install -yqq wget ca-certificates gnupg2

#RUN echo 'deb http://apt.postgresql.org/pub/repos/apt/ stretch-pgdg main' >> /etc/apt/sources.list

#RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -

#RUN apt-get update -yqq

#RUN apt-get install -yqq build-essential libpq-dev nodejs postgresql-client-9.6

RUN mkdir /var/app
WORKDIR /var/app

COPY . .

RUN bundle install
