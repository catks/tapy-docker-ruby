FROM ruby:2.6.6-alpine AS dev

RUN apk update \
  && apk upgrade \
  && apk add --update \
    tzdata \
    linux-headers \
    build-base \
    postgresql-dev \
    postgresql-client \
    && rm -rf /var/cache/apk/*

WORKDIR /usr/src/app

ENV BUNDLE_PATH=/bundle \
    BUNDLE_BIN=/bundle/bin \
    GEM_HOME=/bundle
ENV PATH="${BUNDLE_BIN}:${PATH}"

RUN gem install bundler -v 1.17.3

# TODO: Add production stage

FROM dev AS release

COPY Gemfile Gemfile.lock ./

RUN bundle install --jobs 2 --retry 1

COPY . .
