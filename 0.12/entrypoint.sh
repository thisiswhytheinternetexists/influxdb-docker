#!/bin/bash
set -e

if [ "${1:0:1}" = '-' ]; then
    set -- influxd "$@"
fi

# TODO remove this for 0.13
if [ "$1" = 'influxd' ]; then
    shift
    case $1 in
      config)
        shift
        set -- influxd config -config /etc/influxdb/influxdb.conf "$@"
        ;;
      run)
        shift
        set -- influxd run -config /etc/influxdb/influxdb.conf "$@"
        ;;
      -*)
        set -- influxd -config /etc/influxdb/influxdb.conf "$@"
        ;;
      *)
        set -- influxd "$@"
        ;;
    esac
fi

exec "$@"
