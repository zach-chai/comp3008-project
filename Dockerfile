FROM ruby:2.2.4

# app dependencies
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

RUN mkdir /usr/src/app
