#!/bin/sh

HOST=$1
DOMAIN=$2
TYPE=$3

[ -z "$DOMAIN" ] && DOMAIN=$HOST
[ -z "$TYPE" ] && TYPE="A"

RESULT=`dig @$HOST $DOMAIN $TYPE +time=5 +tries=1 2> /dev/null`

if [ "`echo \"$RESULT\" | grep \"status: NOERROR\"`" = "" ]; then
  echo "ZBX_NOTSUPPORTED"
  exit 1
fi

echo "$RESULT" \
  | grep "Query time" \
  | cut -d " " -f4
