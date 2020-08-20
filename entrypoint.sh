#!/bin/sh

if [[ -f /srv/start.sh ]]; then
    sh /srv/start.sh
fi

if [[ -f /srv/bin/start.sh ]]; then
    sh /srv/bin/start.sh
fi

exec "$@"
