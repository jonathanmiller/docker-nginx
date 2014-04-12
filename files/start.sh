#!/bin/bash

if [ -e /firstrun ];
then
  sh /scripts/auto-key-gen.sh
  rm -f /firstrun
fi

exec /usr/sbin/nginx
