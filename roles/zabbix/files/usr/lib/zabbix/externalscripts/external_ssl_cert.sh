#!/bin/sh

HOST=$1
PORT=${2:-443}

END_DATE=`openssl \
  s_client \
  -connect ${HOST}:${PORT} \
  -servername ${HOST} < /dev/null 2> /dev/null \
  | openssl x509 -enddate -noout 2> /dev/null \
  | cut -d'=' -f2`

if [ -z "$END_DATE" ]; then
  echo "ZBX_NOTSUPPORTED"
  exit 1
fi

date +"%s" \
  --date="${END_DATE}" \
  | gawk '{printf("%d\n",($0-systime())/86400-1/86400+1)}'
