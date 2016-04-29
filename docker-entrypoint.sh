#!/bin/bash

set -e

# Add logstash as command if needed
if [ "${1:0:1}" = '-' ]; then
	set -- logstash "$@"
fi

# Run as user "logstash" if the command is "logstash"
if [ "$1" = 'logstash' ]; then
  # Download configuration if needed
  if [ "$DOWNLOAD_CONFIG" != 'none' ]; then
    mkdir -p /config-dir
    curl $DOWNLOAD_CONFIG > /config-dir/logstash.conf
    set -- gosu logstash  "$@" -f /config-dir/logstash.conf
  else
    set -- gosu logstash "$@"
  fi

fi

exec "$@"
