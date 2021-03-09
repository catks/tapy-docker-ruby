FROM ruby:{{ruby | default: "2.7.2"}}-alpine AS dev

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

{% if bundler %}
RUN gem install bundler -v {{ bundler }}
{% endif %}

# TODO: Add production stage

FROM dev AS release

COPY Gemfile Gemfile.lock ./

RUN bundle install --jobs 2 --retry 1

COPY . .
