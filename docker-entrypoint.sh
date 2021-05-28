#!/bin/sh

set -e

{% if postgres %}
chmod +x wait-for-it.sh
./wait-for-it.sh postgres:5432 -t 10
{% endif %}

bundle check || bundle install

exec bundle exec "$@"
