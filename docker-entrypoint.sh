#!/bin/sh

set -e

{% if postgres %}
./wait-for-it.sh postgres:5432 -t 10
{% endif %}

bundle check || bundle install

exec bundle exec "$@"
