#!/bin/bash
set -e

if [ "${1:0:1}" = '-' ]; then
    set -- influxd "$@"
fi

# TODO remove this for 0.13
if [ "$1" = 'influxd' ]; then
    shift
    set -- influxd -config /etc/influxdb/influxdb.conf "$@"
fi

exec "$@"
